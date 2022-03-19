using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/pss/api/productionUnitGroup")]
    public class ProductionUnitGroupController : BaseController
    {
        private readonly IProductionUnitGroupService _productionUnitGroupService;
        private readonly ILogger<ProductionUnitGroupController> _logger;

        public ProductionUnitGroupController(IProductionUnitGroupService productionUnitGroupService, ILogger<ProductionUnitGroupController> logger)
        {
            _productionUnitGroupService = productionUnitGroupService;
            _logger = logger;
        }

        [HttpGet]
        public ActionResult<IEnumerable<ProductionUnitGroup>> GetAll()
        {
            IEnumerable<ProductionUnitGroup> productionUnitGroups;
            try
            {
                productionUnitGroups = _productionUnitGroupService.GetAll();
            }
            catch (Exception ex)
            {
                string message = "PSS - Error Get All Production Unit Group";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }
            return Ok(productionUnitGroups);
        }
    }
}
