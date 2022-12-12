using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static PokemonImport.Constant;

namespace PokemonImport
{
    internal class Parser
    {
        List<MyFile> filesToProcess = new List<MyFile>();
        List<Error> errors = new List<Error>();

        bool hasErrors => errors.Any();

        public Parser()
        {
            List<string> fileNames = GetAllFiles();

            foreach (var name in fileNames)
            {
                filesToProcess.Add(CreateFile(name));
            }

            if (hasErrors)
            {
                ReportErrors();
                return;
            }

            Engine engine = new Engine();

            foreach (var file in filesToProcess)
            {
                errors.AddRange(engine.InsertPokemonData(file));
            }

            if (!hasErrors)
            {
                Console.WriteLine("Process completed succesfully for all items!");
            }
            else
            {
                ReportErrors();
            }

        }

        /// <summary>
        /// Get all files in temp folder
        /// </summary>
        /// <returns></returns>
        List<string> GetAllFiles()
        {
            return Directory.GetFiles(directoryPath).Where(x => !x.EndsWith(".txt")).ToList();
        }

        /// <summary>
        /// CreateFiles handles the creation of valid MyFile objects, adds an error if one is found
        /// </summary>
        /// <param name="fileName">string name for the file</param>
        MyFile CreateFile(string fileName)
        {
            string delimiter = string.Empty;
            string extension = string.Empty;

            if (fileName.EndsWith(".csv"))
            {
                delimiter = ",";
                extension = ".csv";
            }
            else
            {
                errors.Add(new Error($"Invalid File Extension, {fileName.Substring(fileName.LastIndexOf("."))} is not supported", $"{fileName}"));
            }

            return new MyFile(delimiter, fileName, extension);
        }

        /// <summary>
        /// Write errors to console
        /// </summary>
        void ReportErrors()
        {
            Console.WriteLine("Process exited with errors!");
            foreach (var error in errors)
            {
                Console.WriteLine($"Error: {error.ErrorMessage} Source: {error.Source}");
            }
        }
    }
}
