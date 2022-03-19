using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/productionUnit")]
    public class ProductionUnitController : BaseController
    {
        private readonly IProductionUnitService _productionUnitService;
        private readonly ILogger<ProductionUnitController> _logger;

        public ProductionUnitController(IProductionUnitService productionUnitService, ILogger<ProductionUnitController> logger)
        {
            _productionUnitService = productionUnitService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<ProductionUnit>> GetAll()
        {
            IEnumerable<ProductionUnit> productionUnits;
            try
            {
                productionUnits = _productionUnitService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get All Production Unit";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(productionUnits);
        }

        [HttpGet("group/{productionUnitGroupId}")]
        public ActionResult<IEnumerable<ProductionUnit>> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            IEnumerable<ProductionUnit> productionUnits;
            try
            {
                productionUnits = _productionUnitService.GetByProductionUnitGroupId(productionUnitGroupId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get By Production Unit Group Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(productionUnits);
        }

        [HttpGet("casters/group/{productionUnitGroupId}")]
        public ActionResult<IEnumerable<ProductionUnit>> GetCastersByProductionUnitGroupId(int productionUnitGroupId)
        {
            IEnumerable<ProductionUnit> productionUnits;
            try
            {
                productionUnits = _productionUnitService.GetCastersByProductionUnitGroupId(productionUnitGroupId);
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get Casters By Production Unit Group Id";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(productionUnits);
        }
    }
}
