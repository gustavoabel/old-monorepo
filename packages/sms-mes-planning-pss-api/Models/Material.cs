namespace sms_mes_planning_pss_api.Models
{
    public class Material
    {
        public int id { get; set; }
    }

    public class MaterialHeat
    {
        public int sequenceItemId { get; set; }
        public int sequenceItemOrder { get; set; }
        public string heatWeight { get; set; }
        public string steelGradeInt { get; set; }
        public int groupNumber { get; set; }        
    }

    public class MaterialOutput
    {
        public int Id { get; set; }
        public int ItemOrder { get; set; }
        public int SequenceItemId { get; set; }
        public int MaterialId { get; set; }
    }

    public class MaterialMovementBody
    {
        public string MoveType { get; set; }
        public string MaterialType { get; set; }
        public int MaterialId { get; set; }
        public int OldPosition { get; set; }
        public int NewPositon { get; set; }
        public int OldSequenceItemId { get; set; }
        public int SequenceItemId { get; set; }
    }

    public class RemoveMaterial
    {
        public int MaterialId { get; set; }
        public int SequenceItemId { get; set; }
        public int SequenceScenarioId { get; set; }
    }
}