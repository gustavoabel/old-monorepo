using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/materialAttributeDefinition")]
    public class MaterialAttributeDefinitionController : BaseController
    {
        private readonly IMaterialAttributeDefinitionService _materialAttributeDefinitionService;
        private readonly ILogger<MaterialAttributeDefinitionController> _logger;

        public MaterialAttributeDefinitionController(IMaterialAttributeDefinitionService materialAttributeDefinitionService, ILogger<MaterialAttributeDefinitionController> logger)
        {
            _materialAttributeDefinitionService = materialAttributeDefinitionService;
            _logger = logger;
        }

        [HttpGet("planningHorizonOptions/{productionUnitGroupId}")]
        public ActionResult<IEnumerable<MaterialAttributeDefinition>> GetPlanningHorizonOptions(int productionUnitGroupId)
        {
            IEnumerable<MaterialAttributeDefinition> planningHorizonOptions;
            try
            {
                planningHorizonOptions = _materialAttributeDefinitionService.GetPlanningHorizonOptions(productionUnitGroupId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Planning Horizon Options.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(planningHorizonOptions);
        }

        [HttpGet("schedulingRulesOptions/{materialTypeId}")]
        public ActionResult<IEnumerable<MaterialAttributeDefinition>> GetSchedulingRulesOptions(int materialTypeId)
        {
            IEnumerable<MaterialAttributeDefinition> schedulingRulesOptions;
            try
            {
                schedulingRulesOptions = _materialAttributeDefinitionService.GetByMaterialType(materialTypeId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Scheduling Rules Options.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(schedulingRulesOptions);
        }

        [HttpGet("materialFilterOptions/{productionUnitGroupId}")]
        public ActionResult<IEnumerable<MaterialAttributeDefinition>> GetMaterialFilterOptions(int productionUnitGroupId)
        {
            IEnumerable<MaterialAttributeDefinition> materialFilterOptions;
            try
            {
                materialFilterOptions = _materialAttributeDefinitionService.GetMaterialFilterOptions(productionUnitGroupId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Material Filter Options";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(materialFilterOptions);            
        }

        [HttpGet("addMaterialAttributes/{productionUnitId}")]
        public ActionResult<IEnumerable<MaterialAttributeDefinition>> GetAddMaterialAttributes(int productionUnitId)
        {
            IEnumerable<MaterialAttributeDefinition> addMaterialAttributes;
            try
            {
                addMaterialAttributes = _materialAttributeDefinitionService.GetAddMaterialAttributes(productionUnitId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Add Material Attributes";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(addMaterialAttributes);
        }

        [HttpGet("customColumnOrder/{tableType}/{userId}")]
        public ActionResult<string> GetCustomColumnOrder(string tableType, string userId)
        {
            string customColumnOrder;
            try
            {
                customColumnOrder = _materialAttributeDefinitionService.GetCustomColumnOrder(tableType, userId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Custom Column Order";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(customColumnOrder);
        }

        [HttpPost("customColumnOrder")]
        public ActionResult<bool> SetCustomColumnOrder(CustomColumnOrderCreation data)
        {
            bool isSetColumnOrder;
            try
            {
                isSetColumnOrder = _materialAttributeDefinitionService.SetCustomColumnOrder(data.tableType, data.userId, data.columnOrder);
                if (!isSetColumnOrder)                                    
                    return BadRequest();                
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Set Custom Column Order";
                _logger.LogError(ex, message);
                return BadRequest(message);                
            }
            return Ok();
        }
    }
}
