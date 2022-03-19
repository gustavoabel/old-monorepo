using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using Microsoft.Extensions.Logging;
using System;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/unitSequence")]
    public class UnitSequenceController : BaseController
    {
        private readonly IUnitSequenceService _unitSequenceService;
        private readonly ILogger<UnitSequenceController> _logger;

        public UnitSequenceController(IUnitSequenceService unitSequenceService, ILogger<UnitSequenceController> logger)
        {
            _unitSequenceService = unitSequenceService;
            _logger = logger;
        }
        [HttpGet]
        public ActionResult<IEnumerable<UnitSequence>> GetBySequenceScenarioId([FromQuery] int sequenceScenarioId)
        {
            IEnumerable<UnitSequence> unitSequences;            
            try
            {
                unitSequences = _unitSequenceService.GetBySequenceScenarioId(sequenceScenarioId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Unit Sequence By Sequence Scenario Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(unitSequences);        
        }
        [HttpPost]
        [Route("material")]
        public ActionResult AddNewMaterial(UnitSequenceNewMaterial[] unitSequenceNewMaterial)
        {
            bool response;
            try
            {
                response = _unitSequenceService.AddNewMaterial(unitSequenceNewMaterial);

                if (!response)
                    return BadRequest();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Add New Material";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();
        }
        [HttpGet("casters")]
        public ActionResult<IEnumerable<MaterialHeat>> GetCastersBySequenceScenarioId([FromQuery] int scenarioId)
        {
            IEnumerable<dynamic> casters;
            try
            {
                casters = _unitSequenceService.GetCastersBySequenceScenarioId(scenarioId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Casters By Sequence Scenario Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok(casters);
        }
        [HttpGet("heats")]
        public ActionResult<IEnumerable<MaterialHeat>> GetHeatList([FromQuery] int unitSequenceId)
        {
            IEnumerable<dynamic> heatList;
            try
            {
                heatList = _unitSequenceService.GetHeatListByUnitSequence(unitSequenceId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Heat List";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok(heatList);
        }
        [HttpGet("output/order")]
        public ActionResult<int> GetNewOutputOrder([FromQuery] int sequenceItemId)
        {
            int outputOrder;
            try
            {
                outputOrder = _unitSequenceService.GetNewOutputOrder(sequenceItemId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get New Output Order";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(outputOrder);
        }
        [HttpGet("{unitSequenceName}/{scenarioId}/sum")]
        public ActionResult<UnitSequenceAttributesSum> GetUnitSequenceAttributeSum(string unitSequenceName, int scenarioId)
        {
            try
            {
                UnitSequenceAttributesSum sumOfAttribute = _unitSequenceService.GetSumOfAttributes(unitSequenceName, scenarioId);

                return Ok(sumOfAttribute);
            }
            catch (Exception e)
            {
                return BadRequest(e.ToString());
            }
        }
    }
}
