namespace sms_mes_planning_pss_api.Models
{
    public class User
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
    }

    public class Authenticate
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class ResponseLogin
    {
        public string AccessToken { get; set; }
        public double ExpiresIn { get; set; }
        public UserToken User { get; set; }
    }

    public class UserToken
    {
        public string Name { get; set; }
    }

    public class Permission
    {
        public string Key { get; set; }
    }
}
