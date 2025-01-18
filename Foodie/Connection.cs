using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Foodie
{
    public class Connection
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }
    }

    public class Utils
    {
        public static bool IsValidExtension(string fileName)
        {
            bool isValid = false;
            string[] fileExtensions = { ".jpg", ".png", ".jpeg" };

            foreach (string extension in fileExtensions)
            {
                if (fileName.EndsWith(extension, StringComparison.OrdinalIgnoreCase))
                {
                    isValid = true;
                    break;
                }
            }

            return isValid; // Ensure the method always returns a value
        }
    }
}
