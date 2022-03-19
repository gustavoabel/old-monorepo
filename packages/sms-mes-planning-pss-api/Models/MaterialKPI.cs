namespace sms_mes_planning_pss_api.Models
{
    public class MaterialKPI
    {
        public int MaterialId { get; set; }
        public string MaterialTypeName { get; set; }
        public string PieceId { get; set; }
        public decimal Width { get; set; }
        public decimal Thickness { get; set; }
        public decimal Weight { get; set; }
        public decimal Length { get; set; }
        public string SteelGrade { get; set; }
        public decimal ProductionTime { get; set; }
    }
}
