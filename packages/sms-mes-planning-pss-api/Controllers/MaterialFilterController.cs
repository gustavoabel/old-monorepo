using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/materialFilter")]
    public class MaterialFilterController : BaseController
    {
        private readonly IMaterialFilterService _materialFilterService;
        private readonly ILogger<MaterialFilterController> _logger;

        public MaterialFilterController(IMaterialFilterService materialFilterService, ILogger<MaterialFilterController> logger)
        {
            _materialFilterService = materialFilterService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<MaterialFilter>> GetAll()
        {
            IEnumerable<MaterialFilter> materialFilter;
            try
            {
                materialFilter = _materialFilterService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Material Filter";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(materialFilter);
        }

        [HttpGet("{productionUnitGroupId}")]
        public ActionResult<IEnumerable<MaterialFilter>> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            IEnumerable<MaterialFilter> materialFilter;
            try
            {
                materialFilter = _materialFilterService.GetByProductionUnitGroupId(productionUnitGroupId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Material Filter By Production Unit Group Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(materialFilter);            
        }

        [HttpPost]
        public ActionResult Add(MaterialFilter materialFilter)
        {
            try
            {
                _materialFilterService.Add(materialFilter);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Add Material Filter";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok();
        }

        [HttpPut]
        public ActionResult Update(MaterialFilter materialFilter)
        {
            try
            {
                _materialFilterService.Update(materialFilter);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Update Material Filter";
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
                _materialFilterService.Delete(id);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Delete Material Filter";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }            
            return Ok();
        }
    }
}
