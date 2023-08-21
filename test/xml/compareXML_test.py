import os
import sys
import unittest
import xml.etree.ElementTree as ET
from compareXML import compareFiles

def get_files_in_dir(dir_path):
    files = []
    for file in os.listdir(dir_path):
        if file.endswith(".xml") and not file.startswith("jetscape_main"):
            files.append(file)
    return files

class TestCompareXML(unittest.TestCase):
    def test_compare_files(self):

        CONFIG_PATH = '../../../JETSCAPE/config/'

        if len(sys.argv) > 1:
            CONFIG_PATH = sys.argv[1]

        files = get_files_in_dir(CONFIG_PATH)
        print(files)
        allSuccess = True

        for file in files:
            main_path = CONFIG_PATH + 'jetscape_main.xml'
            user_path = CONFIG_PATH + file
            print('\nuser file: ' + user_path)

            # if file is in ignoreFile.txt then skip and continue
            with open('ignoreFile.txt') as f:
                ignoreFiles = f.read().splitlines()
            if file in ignoreFiles:
                print('skipping file: ' + file)
                continue
            
            [missing, success] = compareFiles(main_path, user_path)
            if success:
                print('success')
            else:
                print('failure')    
                print(missing)

            if not success:
                allSuccess = False
        
        self.assertTrue(allSuccess)


if __name__ == '__main__':
    unittest.main()