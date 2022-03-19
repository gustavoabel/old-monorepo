using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/kpi")]
    public class KPIController : BaseController
    {
        private readonly IKPIService _kpiService;
        private readonly ILogger<KPIController> _logger;

        public KPIController(IKPIService kpiService, ILogger<KPIController> logger)
        {
            _kpiService = kpiService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<KPI>> GetBySequenceScenario([FromQuery] int sequenceScenarioId)
        {
            IEnumerable<KPI> kpiSequenceScenario;

            try
            {
                kpiSequenceScenario = _kpiService.GetBySequenceScenario(sequenceScenarioId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get KPI by Sequence Scenario.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }

            return Ok(kpiSequenceScenario);
        }
    }
}
