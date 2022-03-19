using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Controllers;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;

namespace sms_mes_planning_pss.api.Controllers
{
    [Route("/pss/api/limitConfiguration")]
    public class LimitConfigurationController : BaseController
    {
        private readonly ILimitConfigurationService _limitConfigurationService;
        private readonly ILogger<LimitConfigurationController> _logger;

        public LimitConfigurationController(ILimitConfigurationService limitConfigurationService, ILogger<LimitConfigurationController> logger)
        {
            _limitConfigurationService = limitConfigurationService;
            _logger = logger;
        }
        [HttpGet]
        public ActionResult<IEnumerable<LimitConfiguration>> GetAll()
        {
            IEnumerable<LimitConfiguration> limitConfiguration;
            try
            {
                limitConfiguration = _limitConfigurationService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Getting All Limit Configuration.";
                _logger.LogError(ex, message);
                return BadRequest(message);                
            }
            return Ok(limitConfiguration);
        }
        [HttpPut]
        public ActionResult Update(LimitConfiguration limitConfiguration)
        {
            try
            {
                _limitConfigurationService.Update(limitConfiguration);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Updating Limit Configuration.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok();
        }
    }
}