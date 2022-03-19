using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.IO;
using System;
using Microsoft.Extensions.Logging;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/schedulingRule/violation")]
    public class SchedulingRuleViolationController : BaseController
    {
        private readonly ISchedulingRuleViolationService _schedulingRuleViolationService;
        private readonly ILogger<SchedulingRuleViolationController> _logger;

        public SchedulingRuleViolationController(ISchedulingRuleViolationService schedulingRuleViolationService,
                                                 ILogger<SchedulingRuleViolationController> logger)
        {
            _schedulingRuleViolationService = schedulingRuleViolationService;
            _logger = logger;
        }

        [HttpGet("{scenarioId}")]
        public ActionResult<bool> CheckViolationByScenarioId(int scenarioId)
        {
            bool execute;
            try
            {
                execute = _schedulingRuleViolationService.CheckViolationByScenarioId(scenarioId);

                if (!execute)
                    return Ok("Nothing to worry.");
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Scheduling Rule Violation.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok("Rule Violation.");
        }

        [HttpGet("combo")]
        public ActionResult<IEnumerable<SchedulingRuleViolation>> GetComboBySequenceItem([FromQuery] int MaterialId, [FromQuery] int SequenceItemId)
        {
            IEnumerable<SchedulingRuleViolation> ruleViolationsList;
            try
            {
                ruleViolationsList = _schedulingRuleViolationService.GetComboBySequenceItem(MaterialId, SequenceItemId);

                if (ruleViolationsList != null)
                    return Ok(ruleViolationsList);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error while trying to list the Scheduling Rule Violation for combo.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return BadRequest("Some error ocurred while trying to list the Scheduling Rule Violation for combo...");
        }

        [HttpPost("accept")]
        public ActionResult<string> AcceptRuleViolation(SchedulingRuleViolationAcceptance RuleViolationAccept)
        {
            bool isAccepted;
            try
            {
                isAccepted = _schedulingRuleViolationService.AcceptRuleViolation(RuleViolationAccept);

                if (isAccepted)
                    return Ok("Everything worked fine.");
            }
            catch (Exception ex)
            {
                string message = "PSS - Error while accepting the Rule Violation.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return BadRequest("Something happened and was not possible to accept.");
        }
    }
}
