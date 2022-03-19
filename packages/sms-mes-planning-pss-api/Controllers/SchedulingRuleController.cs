using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/schedulingRule")]
    public class SchedulingRuleController : BaseController
    {
        private readonly ISchedulingRuleService _schedulingRuleService;
        private readonly ILogger<SchedulingRuleController> _logger;

        public SchedulingRuleController(ISchedulingRuleService schedulingRuleService, ILogger<SchedulingRuleController> logger)
        {
            _schedulingRuleService = schedulingRuleService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<SchedulingRule>> GetAll()
        {
            IEnumerable<SchedulingRule> schedulingRules;
            try
            {
                schedulingRules = _schedulingRuleService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get All Production Unit Group";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(schedulingRules);
        }

        [HttpPost]
        public ActionResult Add(SchedulingRule schedulingRule)
        {
            int id;
            try
            {
                id = _schedulingRuleService.Add(schedulingRule);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Add Scheduling Rule";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Created("/pss/api/schedulingRule", id);
        }

        [HttpPut]
        public ActionResult Update(SchedulingRule schedulingRule)
        {
            try
            {
                _schedulingRuleService.Update(schedulingRule);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Update Scheduling Rule";
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
                _schedulingRuleService.Delete(id);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Delete Scheduling Rule";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok();
        }
    }
}
