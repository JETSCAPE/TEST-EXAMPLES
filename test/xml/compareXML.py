import sys
import xml.etree.ElementTree as ET


# function to find which elements are in the user file but not in the main file
def find_missing_elements(main_root, user_root):
    missing_elements = []
    for elem in user_root.iter():
        if elem.tag not in [elem.tag for elem in main_root.iter()]:
            missing_elements.append(elem.tag)
    return missing_elements


def isEmpty(arr):
    if len(arr) == 0:
        return True
    
    return False


def compareFiles(main_path, user_path):
    root_main = ET.parse(main_path).getroot()
    root_user = ET.parse(user_path).getroot()
    
    missingElements = find_missing_elements(root_main, root_user)

    if isEmpty(missingElements):
        return [missingElements, True]
    else:
        return [missingElements, False]     


def main():
    main_path = 'config/jetscape_main.xml'
    user_path = 'config/jetscape_user.xml'

    if len(sys.argv) > 1:
        main_path = sys.argv[1]
        user_path = sys.argv[2]

    [missingElements, success] = compareFiles(main_path, user_path)

    if success:
        print("success: all user xml elements are found in main xml file")
    else:
        print("failure: missing elements found in user xml file")
        print(missingElements)


if __name__ == '__main__':
    main()
