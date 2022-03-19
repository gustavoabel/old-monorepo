using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;
using System.Text;

namespace sms_mes_planning_pss_api.Services
{
    public class CodeService : ICodeService
    {
        private readonly IMaterialAttributeDefinitionService _materialAttributeDefinitionService;

        public CodeService(IMaterialAttributeDefinitionService materialAttributeDefinitionService)
        {
            _materialAttributeDefinitionService = materialAttributeDefinitionService;
        }

        public string GetSchedulingRuleModel(int materialTypeId)
        {
            var materialAttributeDefinitionList = _materialAttributeDefinitionService.GetByMaterialType(materialTypeId);
            StringBuilder schedulingRuleModel = new ();

            schedulingRuleModel.AppendLine(@"/**
            * ----- Helper Functions -----
            * -> ValidateSlabGradeTransition: Function that retrieve the classification of the transition between Slab's Steel Grade.
            * 
            * ----------------------------------------------------------------------------------------------------------------------------------
            * 
            * ----- Scheduling Rule Function Context -----
            * -> currentLine: Current line which the rule will be applied
            * -> nextLine: Next line in the production sequence which the rule will be applied (Available depending on the Material Type)
            * Return => True: If violate any rule | False: Everything is OK
            */ 
            interface Context 
            {
                currentLine: CurrentLine;
                nextLine: NextLine;
            }
            ");
            schedulingRuleModel.AppendLine(GetCurrentLineModel(materialAttributeDefinitionList));
            schedulingRuleModel.AppendLine(GetNextLineModel(materialAttributeDefinitionList));
            schedulingRuleModel.AppendLine(@"
                function ValidateSlabGradeTransition(from: string, to: string): string {
                    return RunValidateSlabGradeTransition(from, to);
                }
            ");

            return schedulingRuleModel.ToString();
        }

        private string GetCurrentLineModel(IEnumerable<MaterialAttributeDefinition> materialAttributeDefinitionList)
        {
            StringBuilder currentLineModel = new StringBuilder(@"/**
                * Current Line for the selected material type
                */
                interface CurrentLine {
                ");

            return GetLineModel(currentLineModel, materialAttributeDefinitionList);
        }

        private string GetNextLineModel(IEnumerable<MaterialAttributeDefinition> materialAttributeDefinitionList)
        {
            StringBuilder nextLineModel = new StringBuilder(@"/**
                * Next Line for the selected material type
                */
                interface NextLine {
                ");

            return GetLineModel(nextLineModel, materialAttributeDefinitionList);
        }

        private string GetLineModel(StringBuilder lineModel, IEnumerable<MaterialAttributeDefinition> materialAttributeDefinitionList)
        {
            foreach (MaterialAttributeDefinition materialAttributeDefinition in materialAttributeDefinitionList)
            {
                lineModel.AppendLine($"static {materialAttributeDefinition.Name}: {GetTypescriptTypeFromMaterialAttributeType(materialAttributeDefinition.Type)};");
            }

            lineModel.AppendLine("}");

            return lineModel.ToString();
        }

        private string GetTypescriptTypeFromMaterialAttributeType(string materialAttributeType)
        {
            switch (materialAttributeType)
            {
                case "date":
                    return "Date";
                case "text":
                    return "string";
                default:
                    return materialAttributeType;
            }
        }
    }
}
