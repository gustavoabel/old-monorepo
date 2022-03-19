using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/groupSequence")]
    public class GroupSequenceController : BaseController
    {
        private readonly IGroupSequenceService _groupSequenceService;
        private readonly ILogger<GroupSequenceController> _logger;
        public GroupSequenceController(IGroupSequenceService groupSequenceService, ILogger<GroupSequenceController> logger)
        {
            _groupSequenceService = groupSequenceService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<GroupSequence>> GetAll()
        {
            IEnumerable<GroupSequence> groupSequence;
            try
            {
                groupSequence = _groupSequenceService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get All Group Sequence.";
                _logger.LogError(ex, message);
                return BadRequest(message);                
            }
            return Ok(groupSequence);
        }

        [HttpGet("GetSequenceByScenarioId/{scenarioId}")]
        public ActionResult<GroupSequence> GetSequenceByScenarioId(int scenarioId)
        {
            GroupSequence groupSequence;
            try
            {
                groupSequence = _groupSequenceService.GetSequenceByScenarioId(scenarioId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Group Sequence By Scenario Id.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(groupSequence);
        }

        [HttpPost]
        public ActionResult Add(GroupSequence groupSequence)
        {
            int groupSequenceId;

            try
            {
                groupSequenceId = _groupSequenceService.Add(groupSequence);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Adding Group Sequence.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Created("/pss/api/groupSequence", groupSequenceId);
        }

        [HttpPut]
        public ActionResult Update(GroupSequence groupSequence)
        {
            try
            {
                _groupSequenceService.Update(groupSequence);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Updating Group Sequence.";
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
                _groupSequenceService.Delete(id);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Deleting Group Sequence.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok();
        }

        [HttpPut("book/{groupSequenceId}/{sequenceScenarioId}")]
        public ActionResult<bool> BookGroupSequence(int groupSequenceId, int sequenceScenarioId)
        {
            bool execute;
            try
            {
                execute = _groupSequenceService.BookGroupSequence(groupSequenceId, sequenceScenarioId);

                if (!execute)
                    return BadRequest("Some error ocurred while trying to book the Group Sequence.");
            }
            catch (Exception ex)
            {                
                string message = "Some error ocurred while trying to book the Group Sequence.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();                
        }

        [HttpPost("saveToMES/{groupSequenceId}")]
        public ActionResult<bool> SaveSequencesMes(int groupSequenceId)
        {
            bool execute;
            try
            {
                execute = _groupSequenceService.SaveSequencesMes(groupSequenceId);

                if (!execute)
                    return BadRequest("Some error ocurred while trying to send the sequence to MES.");
            }
            catch (Exception ex)
            {
                string message = "Some error ocurred while trying to send the sequence to MES.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();
        }
    }
}
