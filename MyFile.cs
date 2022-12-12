using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static PokemonImport.Constant;

namespace PokemonImport
{
    internal class MyFile
    {
        public string Delimiter { get; set; }
        public string FilePath { get; set; }
        public string Extension { get; set; }

        public MyFile(string _delimiter, string _fileName, string extension)
        {
            Delimiter = _delimiter;
            FilePath = Path.Combine(directoryPath, _fileName);
            Extension = extension;
        }
    }
}
