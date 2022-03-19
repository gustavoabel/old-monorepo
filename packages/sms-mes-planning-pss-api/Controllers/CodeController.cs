using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/code")]
    public class CodeController : BaseController
    {
        private readonly ICodeService _codeService;
        private readonly ILogger<CodeController> _logger;

        public CodeController(ICodeService codeService, ILogger<CodeController> logger)
        {
            _codeService = codeService;
            _logger = logger;
        }

        [HttpGet("schedulingRuleModel")]
        public ActionResult<string> GetSchedulingRuleModel([FromQuery] int materialTypeId)
        {
            string model;

            try
            {
                model = _codeService.GetSchedulingRuleModel(materialTypeId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Scheduling Rule Model.";
                _logger.LogError(ex, message);
                return BadRequest(message);                
            }            
            return Ok(model);
        }
    }
}
