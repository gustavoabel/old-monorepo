using JsonLogic.Net;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json.Linq;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;

namespace sms_mes_planning_pss_api.Services
{
    public class MaterialFilterService : IMaterialFilterService
    {
        private readonly IMaterialFilterRepository _materialFilterRepository;

        public MaterialFilterService(IMaterialFilterRepository materialFilterRepository)
        {
            _materialFilterRepository = materialFilterRepository;
        }

        public void Add(MaterialFilter materialFilter)
        {
            ValidateMaterialFilter(materialFilter);

            MaterialFilter defaultMaterialFilter = GetDefaultMaterialFilter(materialFilter.ProductionUnitGroupId);

            if (defaultMaterialFilter != null)
                UpdateOldDefaultMaterialFilter(materialFilter, defaultMaterialFilter);
            else
                materialFilter.IsDefault = true;

            _materialFilterRepository.Add(materialFilter);
        }

        public void Update(MaterialFilter materialFilter)
        {
            MaterialFilter defaultMaterialFilter = GetDefaultMaterialFilter(materialFilter.ProductionUnitGroupId);
            if (defaultMaterialFilter != null)
            {
                ValidateUpdateMaterialFilter(materialFilter, defaultMaterialFilter);
                UpdateOldDefaultMaterialFilter(materialFilter, defaultMaterialFilter);
            }
            else
            {
                ValidateMaterialFilter(materialFilter);
                materialFilter.IsDefault = true;
            }
            _materialFilterRepository.Update(materialFilter);
        }

        public void Delete(int materialFilterId)
        {
            ValidateDeleteMaterialFilter(materialFilterId);
            _materialFilterRepository.Delete(materialFilterId);
        }

        public IEnumerable<MaterialFilter> GetAll()
        {
            return _materialFilterRepository.GetAll();
        }

        public IEnumerable<MaterialFilter> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            return _materialFilterRepository.GetByProductionUnitGroupId(productionUnitGroupId);
        }

        private MaterialFilter GetDefaultMaterialFilter(int productionUnitGroupId)
        {
            return _materialFilterRepository.GetDefaultMaterialFilter(productionUnitGroupId);
        }

        private void UpdateOldDefaultMaterialFilter(MaterialFilter materialFilter, MaterialFilter defaultMaterialFilter)
        {
            if (materialFilter.IsDefault && defaultMaterialFilter.Id != materialFilter.Id)
            {
                defaultMaterialFilter.IsDefault = false;
                _materialFilterRepository.Update(defaultMaterialFilter);
            }
        }

        private void ValidateMaterialFilter(MaterialFilter materialFilter)
        {
            if (!IsMaterialFilterValid(materialFilter))
                throw new BadHttpRequestException("Please fill all the mandatory fields");
        }

        private void ValidateUpdateMaterialFilter(MaterialFilter materialFilter, MaterialFilter defaultMaterialFilter)
        {
            ValidateMaterialFilter(materialFilter);

            if (IsDefaultUpdateSetToFalse(materialFilter, defaultMaterialFilter))
                throw new BadHttpRequestException("You can't delete this Material Filter, because it's being used by at least one Sequence Scenario");
        }

        private void ValidateDeleteMaterialFilter(int materialFilterId)
        {
            MaterialFilter materialFilter = GetById(materialFilterId);
            if (materialFilter.IsDefault)
                throw new BadHttpRequestException("You can't delete a default material filter");

            var hasScenarios = _materialFilterRepository.hasScenarios(materialFilterId);

            if (hasScenarios)
                throw new BadHttpRequestException("You can't delete if a Material Filter is using by a Scenario");
        }

        private MaterialFilter GetById(int materialFilterId)
        {
            return _materialFilterRepository.GetById(materialFilterId);
        }

        private bool IsDefaultUpdateSetToFalse(MaterialFilter materialFilter, MaterialFilter defaultMaterialFilter)
        {
            return defaultMaterialFilter != null && !materialFilter.IsDefault && defaultMaterialFilter.IsDefault && materialFilter.Id == defaultMaterialFilter.Id;
        }

        private bool IsMaterialFilterValid(MaterialFilter materialFilter)
        {
            return !string.IsNullOrEmpty(materialFilter.Name)
                && !string.IsNullOrEmpty(materialFilter.Expression);
        }
    
        public IEnumerable<dynamic> GetFilteredMaterialsList(int materialFilterId, IEnumerable<dynamic> materialsList)
        {
            var materialFilter = _materialFilterRepository.GetById(materialFilterId);
            var rule = JObject.Parse(materialFilter.Expression);
            var evaluator = new JsonLogicEvaluator(EvaluateOperators.Default);
            return materialsList.Where(material => (bool)evaluator.Apply(rule, material));
        }
    }
}
