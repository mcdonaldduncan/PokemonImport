using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PokemonImport
{
    internal class Constant
    {
        private const string folderName = "temp";

        public static string directoryPath => Path.Combine(Directory.GetCurrentDirectory(), folderName);
    }
}
