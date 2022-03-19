using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories;
using sms_mes_planning_pss_api.Repositories.Interfaces;

namespace sms_mes_planning_pss_api.Services
{
    public class MesIntegrationService : IHostedService, IDisposable
    {
        private readonly IMaterialRepository _materialRepository;
        private readonly IMaterialAttributeDefinitionRepository _materialAttributeDefinitionRepository;
        private readonly ITransitionRepository _transitionRepository;
        private readonly IMesIntegrationRepository _mesIntegrationRepository;
        private readonly ISmsIntegrationBaseRepository _smsIntegration;
        private readonly IConfiguration _configuration;
        private ILogger<MesIntegrationService> _logger;
        private readonly IServiceScopeFactory _scopeFactory;
        private Timer _time;
        private Nullable<DateTime> _lastMaterialIntegrationTime;
        private Nullable<DateTime> _lastTransitionIntegrationTime;

        public MesIntegrationService(
            IMaterialRepository materialRepository,
            IMaterialAttributeDefinitionRepository materialAttributeDefinitionRepository,
            ITransitionRepository transitionRepository,
            IMesIntegrationRepository mesIntegrationRepository,
            IConfiguration configuration,
            ILogger<MesIntegrationService> logger,
            IServiceScopeFactory scopeFactory
        )
        {
            _materialRepository = materialRepository;
            _materialAttributeDefinitionRepository = materialAttributeDefinitionRepository;
            _transitionRepository = transitionRepository;
            _mesIntegrationRepository = mesIntegrationRepository;
            _smsIntegration = new SmsIntegrationBaseRepository("MES", configuration);
            _logger = logger;
            _scopeFactory = scopeFactory;
            _configuration = configuration;
        }

        public void Dispose()
        {
            _time?.Dispose();
        }
        public Task StartAsync(CancellationToken cancellationToken)
        {
            int delay = _configuration.GetValue<int>("MES_Timer");

            _time = new Timer(o =>
            {
                using (var scope = _scopeFactory.CreateScope())
                {
                    SetDataFromMES();
                }
            }, null, TimeSpan.Zero, TimeSpan.FromHours(delay));

            return Task.CompletedTask;
        }
        public Task StopAsync(CancellationToken cancellationToken)
        {
            return Task.CompletedTask;
        }
        private void SetDataFromMES()
        {
            Console.WriteLine("Task Initiated");
            bool isAuthenticated = Authenticate();

            if (isAuthenticated)
            {
                _lastMaterialIntegrationTime = _mesIntegrationRepository.GetLastIntegration("MATERIALS");
                _lastTransitionIntegrationTime = _mesIntegrationRepository.GetLastIntegration("TRANSITIONS");

                if (_lastMaterialIntegrationTime == null)
                    GetMaterialsAll();
                else
                    GetMaterialsChangeSince(_lastMaterialIntegrationTime);

                if (_lastTransitionIntegrationTime == null)
                    GetAllTransitions();
                else
                {
                    // GetTransitionsChangeSince(LastTransitionIntegrationTime);
                }
            }
            else
            {
                Console.WriteLine("Integration had some problem to run caused by a failure in the authentication.");
            }
        }
        private bool Authenticate()
        {
            try
            {
                var MESValues = _configuration.GetSection("MES_Auth");

                object body = new
                {
                    username = MESValues.GetValue<string>("Username"),
                    password = MESValues.GetValue<string>("Password")
                };

                SmsMaterialIntegrationAuth Auth = _smsIntegration.Post<SmsMaterialIntegrationAuth>("/authenticate", body);

                if (Auth == null)
                    throw new Exception("Error to authenticate");

                _smsIntegration.AddAuthHeaders(Auth.token);

                return true;
            }
            catch (Exception ex)
            {                
                string message = "PSS - Error to authenticate - MES API.";
                _logger.LogError(ex, message);
                return false;
            }
        }

        #region SMS MES Materials Part
        private void GetMaterialsAll()
        {
            try
            {
                Console.WriteLine("Get All Materials Called...");
                Materials materialsList = _smsIntegration.Get<Materials>("/materials/all");

                if (materialsList != null)
                {
                    foreach (dynamic material in materialsList.Slabs)
                    {
                        CreateNewMaterial(2, material);
                    }

                    foreach (dynamic material in materialsList.Coils)
                    {
                        CreateNewMaterial(3, material);
                    }

                    _mesIntegrationRepository.SetIntegrationTime("MATERIALS");
                    Console.WriteLine("Get All Materials Ended...");
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("401"))
                {
                    bool isAuthenticated = Authenticate();
                    if (isAuthenticated) GetMaterialsAll();
                }
                string message = "PSS - Error to Get All Materials - MES API.";
                _logger.LogError(ex, message);
            }
        }
        private void GetMaterialsChangeSince(Nullable<DateTime> LastMaterialIntegrationTime)
        {
            try
            {
                Console.WriteLine("Get Materials Changed Since Called...");
                if (LastMaterialIntegrationTime.HasValue)
                {
                    string formattedDate = LastMaterialIntegrationTime.Value.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'sszzz");

                    Materials materialsList = _smsIntegration.Get<Materials>("/materials/changesSince/" + formattedDate);

                    if (materialsList != null)
                    {
                        foreach (dynamic material in materialsList.Slabs)
                        {
                            UpdateOrCreateNewMaterial(2, material);
                        }

                        foreach (dynamic material in materialsList.Coils)
                        {
                            UpdateOrCreateNewMaterial(3, material);
                        }
                    }
                    
                    _mesIntegrationRepository.SetIntegrationTime("MATERIALS");
                    Console.WriteLine("Get Materials Changed Since Ended...");
                }
                else
                {
                    throw new Exception("No Integration Date found.");
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("401"))
                {
                    bool isAuthenticated = Authenticate();
                    if (isAuthenticated) GetMaterialsChangeSince(_lastMaterialIntegrationTime);
                }
                string message = "PSS - Error to Get Materials Changed Since Ended - MES API.";
                _logger.LogError(ex, message);
            }
        }
        private void CreateNewMaterial(int MaterialType, dynamic MaterialData)
        {
            try
            {
                Material NewDatabaseMaterial = _materialRepository.AddNewMaterial(MaterialType);

                if (NewDatabaseMaterial != null)
                {
                    var FormattedMaterialData = JsonConvert.DeserializeObject<ExpandoObject>(
                        MaterialData.GetRawText(), new ExpandoObjectConverter()
                    );
                    _materialRepository.AddMaterialAttributes(NewDatabaseMaterial.id, MaterialType, FormattedMaterialData);
                }
                else
                {
                    throw new Exception("Add New Material Error");
                }
            }
            catch (Exception ex)
            {                
                string message = "PSS - Some error ocurred on trying to create a new Material - MES API.";
                _logger.LogError(ex, message);
            }
        }
        private void UpdateOrCreateNewMaterial(int MaterialType, dynamic MaterialData)
        {
            try
            {
                var FormattedMaterialData = JsonConvert.DeserializeObject<ExpandoObject>(
                    MaterialData.GetRawText(), new ExpandoObjectConverter()
                );

                Material DatabaseMaterial = _materialRepository.GetMaterialByPieceId(FormattedMaterialData.PS_PIECE_ID, MaterialType);

                if (DatabaseMaterial != null)
                {
                    _materialRepository.UpdateMaterialAttributes(DatabaseMaterial.id, MaterialType, FormattedMaterialData);
                }
                else
                {
                    CreateNewMaterial(MaterialType, MaterialData);
                }
            }
            catch (Exception ex)
            {
                string message = "PSS - Some error ocurred when trying to update the materials - MES API.";
                _logger.LogError(ex, message);
            }
        }
        #endregion

        #region SMS MES Transitions Part
        private void GetAllTransitions()
        {
            try
            {
                Console.WriteLine("Get All Transitions Called...");


                IEnumerable<IntegratedTransitions> transitionsList = _smsIntegration.Get<IEnumerable<IntegratedTransitions>>("/transitions/all");

                if (transitionsList != null)
                {
                    foreach (IntegratedTransitions transition in transitionsList)
                    {
                        CreateNewTransition(transition);
                    }

                    _mesIntegrationRepository.SetIntegrationTime("TRANSITIONS");
                    Console.WriteLine("Get All Transitions Ended...");
                } else {
                    Console.WriteLine("No transitions found");
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("401"))
                {
                    bool isAuthenticated = Authenticate();
                    if (isAuthenticated) GetAllTransitions();
                }
                string message = "PSS - Error on Get All Transitions - MES API.";
                _logger.LogError(ex, message);
            }
        }
        private void GetTransitionsChangeSince(Nullable<DateTime> LastTransitionIntegrationTime)
        {
            try
            {
                Console.WriteLine("Get Transitions Changed Since Called...");
                if (LastTransitionIntegrationTime.HasValue)
                {
                    string formattedDate = LastTransitionIntegrationTime.Value.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'sszzz");

                    IEnumerable<IntegratedTransitions> transitionsList = _smsIntegration.Get<IEnumerable<IntegratedTransitions>>("/transitions/changesSince/" + formattedDate);

                    if (transitionsList != null)
                    {
                        foreach (IntegratedTransitions transition in transitionsList)
                        {
                            UpdateOrCreateNewTransition(transition);
                        }
                    } else {
                        Console.WriteLine("No transitions found.");
                    }
                    _mesIntegrationRepository.SetIntegrationTime("TRANSITIONS");
                    Console.WriteLine("Get Transitions Changed Since Ended...");
                }
                else
                {
                    throw new Exception("No Integration Date found.");
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("401"))
                {
                    bool isAuthenticated = Authenticate();
                    if (isAuthenticated) GetTransitionsChangeSince(_lastTransitionIntegrationTime);
                }
                string message = "PSS - Error on Get Transitions Changed Since Called - MES API.";
                _logger.LogError(ex, message);
            }
        }
        private void CreateNewTransition(IntegratedTransitions Transition)
        {
            try
            {
                List<MESTransition> MesTransitions = Transition.TRANSITION.ToList();
                MaterialAttributeDefinition currentAttributeDefiniton = _materialAttributeDefinitionRepository.GetByMaterialTypeAndAttributeName(Transition.ATTRIBUTE, "Slab");

                if (currentAttributeDefiniton != default(MaterialAttributeDefinition))
                {
                    for (int i=0; i < MesTransitions.Count; i++)
                    {
                        var newTransition = new NewTransition
                        {
                            Attribute = currentAttributeDefiniton.Id,
                            From = MesTransitions[i].FROM,
                            To = MesTransitions[i].TO,
                            Classification = MesTransitions[i].CLASSIFICATION,
                            Active = Convert.ToBoolean(MesTransitions[i].ACTIVE_FLAG)
                        };

                        bool addNewTransition = _transitionRepository.AddNewTransition(newTransition);

                        if (!addNewTransition)
                        {
                            Console.WriteLine("It was not possible to add the following transition:");
                            Console.WriteLine(
                                "Attribute: " + newTransition.Attribute + 
                                " | From: " + newTransition.From + 
                                " | To: " + newTransition.To + 
                                " | Classification: " + newTransition.Classification + 
                                " | Active: " + newTransition.Active
                            );
                        }
                    }
                } else 
                {
                    throw new Exception("Could not found any Attribute informed by the MES.");
                }
            }
            catch (Exception ex)
            {
                string message = "PSS - Error on Create New Transition - MES API.";
                _logger.LogError(ex, message);                
            }
        }
        private void UpdateOrCreateNewTransition(IntegratedTransitions Transition)
        {
            try
            {
                List<MESTransition> MesTransitions = Transition.TRANSITION.ToList();
                MaterialAttributeDefinition currentAttributeDefiniton = _materialAttributeDefinitionRepository.GetByMaterialTypeAndAttributeName(Transition.ATTRIBUTE, "Slab");

                if (currentAttributeDefiniton != default(MaterialAttributeDefinition))
                {
                    for (int i=0; i < MesTransitions.Count; i++)
                    {
                        var apiTransition = new NewTransition
                        {
                            Attribute = currentAttributeDefiniton.Id,
                            From = MesTransitions[i].FROM,
                            To = MesTransitions[i].TO,
                            Classification = MesTransitions[i].CLASSIFICATION,
                            Active = Convert.ToBoolean(MesTransitions[i].ACTIVE_FLAG)
                        };
                        Transition DatabaseTransition = _transitionRepository.GetTransitionByData(apiTransition);

                        if (DatabaseTransition != null)
                        {
                            _transitionRepository.UpdateTransition(apiTransition);
                        }
                        else
                        {
                            _transitionRepository.AddNewTransition(apiTransition);
                        }
                    } 
                } else 
                {
                    throw new Exception("Could not found any Attribute informed by the MES.");
                }
                
            }
            catch (Exception ex)
            {
                string message = "PSS - Some error ocurred when trying to update the materials - MES API.";
                _logger.LogError(ex, message);                                
            }
        }
    }
    #endregion
}