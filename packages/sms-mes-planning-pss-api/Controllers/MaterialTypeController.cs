using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/materialType")]
    public class MaterialTypeController : BaseController
    {
        private readonly IMaterialTypeService _materialTypeService;
        private readonly ILogger<MaterialTypeController> _logger;

        public MaterialTypeController(IMaterialTypeService materialTypeService, ILogger<MaterialTypeController> logger)
        {
            _materialTypeService = materialTypeService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<MaterialType>> GetByProductionUnitId([FromQuery] int productionUnitId)
        {
            IEnumerable<MaterialType> materialType;
            try
            {
                materialType = _materialTypeService.GetByProductionUnitId(productionUnitId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Material Type By Production Unit Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(materialType);            
        }
    }
}
