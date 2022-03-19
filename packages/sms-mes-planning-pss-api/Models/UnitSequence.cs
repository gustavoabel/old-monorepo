namespace sms_mes_planning_pss_api.Models
{
    public class UnitSequence
    {
        public int Id { get; set; }
        public string ProductionUnitName { get; set; }
        public string ProductionUnitType { get; set; }
        public int ProductionUnitId { get; set; }
        public int SequenceScenarioVersionId { get; set; }
        public int SequenceScenarioId { get; set; }
        public double MaxHeatWeight { get; set; }
    }

    public class UnitSequenceNewMaterial
    {
        public int? sequenceItemId { get; set; }
        public int materialId { get; set; }
        public int materialOrder { get; set; }
        public int unitSequenceId { get; set; }
    }

    public class HSMItemWithCasterUnit
    {
        public int HSMSequenceItemId { get; set; }
        public int HSMSequenceItemOrder { get; set; }
        public int CasterUnitSequenceId { get; set; }
    }

    public class UnitSequenceAttributesSum
    {
        public string SumOfWeight { get; set; }
        public string SumOfLength { get; set; }
    }
}
