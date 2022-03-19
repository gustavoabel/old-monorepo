using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using sms_mes_planning_pss_api.Extensions;
using sms_mes_planning_pss_api.Models;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace sms_mes_planning_pss_api.Controllers
{
    [Route("/api/auth/v1/login")]
    public class LoginController : BaseController
    {
        private readonly AppSettings _appSettings;
        private readonly ILogger<LoginController> _logger;

        public LoginController(IOptions<AppSettings> appSettings, ILogger<LoginController> logger)
        {
            _appSettings = appSettings.Value;
            _logger = logger;
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult<ResponseLogin> Authenticate([FromBody] Authenticate model)
        {
            var user = new User
            {
                Name = model.Username
            };

            if (user == null)
                return BadRequest(new { message = "Username or password is incorrect" });

            try
            {
                var permissions = new List<string>().ToArray();
                var encodedToken = GenerateJwt(user, permissions);

                return Ok(new ResponseLogin
                {
                    AccessToken = encodedToken,
                    ExpiresIn = TimeSpan.FromHours(_appSettings.ExpiresIn).TotalSeconds,
                    User = new UserToken
                    {
                        Name = user.Name
                    }
                });
            }
            catch (Exception ex)
            {
                string message = "PSS - Error on login.";
                _logger.LogError(ex, message);
                return BadRequest(message);
            }

        }

        private string GenerateJwt(User user, string[] permissions)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = _appSettings.Issuer,
                Audience = _appSettings.Audience,
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Name),
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim(ClaimTypes.Role, JsonConvert.SerializeObject(permissions))
                }),
                Expires = DateTime.UtcNow.AddHours(_appSettings.ExpiresIn),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }

        private static long ToUnixEpochDate(DateTime date)
            => (long)Math.Round((date.ToUniversalTime() - new DateTimeOffset(1970, 1, 1, 0, 0, 0, TimeSpan.Zero)).TotalSeconds);
    }
}
