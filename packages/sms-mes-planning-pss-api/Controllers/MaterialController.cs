using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/material")]
    public class MaterialController : BaseController
    {
        private readonly IMaterialService _materialService;
        private readonly ILogger<MaterialController> _logger;

        public MaterialController(IMaterialService materialService, ILogger<MaterialController> logger)
        {
            _materialService = materialService;
            _logger = logger;
        }

        [HttpGet("available/add")]
        public ActionResult<IEnumerable<dynamic>> GetAvailableMaterialsToAdd(
            [FromQuery] int productionUnitId,
            [FromQuery] int sequenceScenarioId,
            [FromQuery] int groupSequenceId,
            [FromQuery] int? materialFilterId,
            [FromQuery] int? planningHorizonId
        )
        {
            IEnumerable<dynamic> availableMaterialsToAdd;
            try
            {
                availableMaterialsToAdd = _materialService.GetAvailableMaterialsToAdd(productionUnitId, sequenceScenarioId, groupSequenceId, materialFilterId, planningHorizonId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Available Materials To Add";
                _logger.LogError(ex, message);
                return BadRequest(message);                
            }
            return Ok(availableMaterialsToAdd);
        }

        [HttpPost("move")]
        public ActionResult<bool> MoveMaterial(MaterialMovementBody materialMovementBody)
        {
            bool materialMoved;
            try
            {
                materialMoved = _materialService.MoveMaterial(materialMovementBody);
                if (!materialMoved)                
                    return BadRequest(false);                
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Move Material";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(true);
        }

        [HttpPost("remove")]
        public ActionResult RemoveFromUnit(RemoveMaterial materialData)
        {
            bool isRemoved;
            try
            {
                isRemoved = _materialService.RemoveFromUnit(materialData);
                if (!isRemoved)
                    return BadRequest();
            }
            catch (Exception ex)
            { 
                string message = "PSS - Error Remove From Unit";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok();            
        }
    }
}
