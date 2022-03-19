using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/planningHorizon")]
    public class PlanningHorizonController : BaseController
    {
        private readonly IPlanningHorizonService _planningHorizonService;
        private readonly ILogger<PlanningHorizonController> _logger;

        public PlanningHorizonController(IPlanningHorizonService planningHorizonService, ILogger<PlanningHorizonController> logger)
        {
            _planningHorizonService = planningHorizonService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<PlanningHorizon>> GetAll()
        {
            IEnumerable<PlanningHorizon> planningHorizons;            
            try
            {
                planningHorizons = _planningHorizonService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get All Planning Horizons";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(planningHorizons);
        }

        [HttpGet("{productionUnitGroupId}")]
        public ActionResult<IEnumerable<PlanningHorizon>> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            IEnumerable<PlanningHorizon> planningHorizons;
            try
            {
                planningHorizons = _planningHorizonService.GetByProductionUnitGroupId(productionUnitGroupId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Planning Horizons By Production Unit Group Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(planningHorizons);
        }

        [HttpPost]
        public ActionResult Add(PlanningHorizon planningHorizon)
        {
            try
            {
                _planningHorizonService.Add(planningHorizon);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Add Planning Horizon";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();
        }

        [HttpPut]
        public ActionResult Update(PlanningHorizon planningHorizon)
        {
            try
            {
                _planningHorizonService.Update(planningHorizon);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Update Planning Horizon";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();
        }

        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            try
            {
                _planningHorizonService.Delete(id);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Delete Planning Horizon";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();
        }
    }
}
