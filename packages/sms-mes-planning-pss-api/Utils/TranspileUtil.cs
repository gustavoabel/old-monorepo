using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;

namespace sms_mes_planning_pss_api.Utils
{   

    public static class TranspileUtil
    {
        public static void Compile(string TSPath)
        {
            try
            {
                Process process = new();

                string ShellPath = Path.Combine(Directory.GetCurrentDirectory(), "Temp"); 

                if (!Directory.Exists(ShellPath))
                    Directory.CreateDirectory(ShellPath);               

                if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                {
                    string fullFilePath = string.Concat(TSPath, @"\script.ts");
                    string command = @"tsc " + "\"" + fullFilePath + "\"" + " --target ES5";
                    var batPath = ShellPath + @"\Transpile_TS.bat";

                    File.WriteAllText(batPath, command);                    

                    ProcessStartInfo psi = new()
                    {                        
                        CreateNoWindow = true,
                        FileName = batPath,
                        UseShellExecute = false,
                        RedirectStandardError = true
                    };

                    process.StartInfo = psi;
                }
                else if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                {
                    string command = $"cd {TSPath} && tsc ./script.ts --target ES5";
                    File.WriteAllText(ShellPath + @"/Transpile_TS.sh", command);
                    string cmd = $"{ShellPath}/Transpile_TS.sh";

                    var escapedArgs = cmd.Replace("\"", "\\\"");

                    process = new Process
                    {
                        StartInfo = new ProcessStartInfo
                        {
                            FileName = "bash",
                            Arguments = $"-c \"chmod +x {escapedArgs} && {escapedArgs}\"",                            
                            RedirectStandardError = true,
                            UseShellExecute = false,
                            CreateNoWindow = true
                        },
                        EnableRaisingEvents = true
                    };
                }

                process.Start();

                // reads the error output
                var msg = process.StandardError.ReadToEnd();
                Console.WriteLine(msg);

                // make sure it finished executing before proceeding 
                process.WaitForExit();

            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }

        public static string CreateAndTranspile(string implementation)
        {
            try
            {
                string TSPath = Path.Combine(Directory.GetCurrentDirectory(), @"Temp");
                string JSPath = Path.Combine(Directory.GetCurrentDirectory(), @"Temp", @"script.js");

                if (!Directory.Exists(TSPath))
                    Directory.CreateDirectory(TSPath);

                File.WriteAllText(TSPath + @"/script.ts", implementation);
                Compile(TSPath);

                return File.ReadAllText(JSPath);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
    }
}