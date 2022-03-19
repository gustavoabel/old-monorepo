using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/sequenceScenario")]
    public class SequenceScenarioController : BaseController
    {
        private readonly ISequenceScenarioService _sequenceScenarioService;
        private readonly ILogger<SequenceScenarioController> _logger;

        public SequenceScenarioController(ISequenceScenarioService sequenceScenarioService, ILogger<SequenceScenarioController> logger)
        {
            _sequenceScenarioService = sequenceScenarioService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<SequenceScenario>> GetByGroupSequenceId([FromQuery] int? groupSequenceId)
        {
            IEnumerable<SequenceScenario> sequenceScenarios;
            try
            {
                sequenceScenarios = _sequenceScenarioService.GetByGroupSequenceId(groupSequenceId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Sequence Scenario By Group Sequence Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(sequenceScenarios);
        }

        [HttpPost]
        public ActionResult Add(SequenceScenario sequenceScenario)
        {
            int id;
            try
            {
                id = _sequenceScenarioService.Add(sequenceScenario);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Add Sequence Scenario";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Created("/pss/api/sequenceScenario", id);
        }

        [HttpPut]
        public ActionResult Update(SequenceScenario sequenceScenario)
        {
            try
            {
                _sequenceScenarioService.Update(sequenceScenario);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Update Sequence Scenario";
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
                _sequenceScenarioService.Delete(id);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Delete Sequence Scenario";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok();
        }

        [HttpGet("{id}/materials")]
        public ActionResult<dynamic> GetMaterialList(int id)
        {
            dynamic materialList;
            try
            {
                materialList = _sequenceScenarioService.GetMaterialList(id);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Material List";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(materialList);
        }
    }
}
