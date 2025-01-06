import argparse
import re  # Add this line to import the re module

def read_key_list(file_path):
    with open(file_path, 'r') as f:
        keys = [line.strip() for line in f.readlines()]
    return keys

def find_missing_keys(localization_file, key_list):
    with open(localization_file, 'r') as f:
        content = f.read()

    # Use regular expression to find keys in localization.strings
    localization_keys = set(re.findall(r'"(.*?)"\s*=\s*".*?";', content))

    # Find keys in key list that are missing in localization.strings
    missing_keys = [key for key in key_list if key not in localization_keys]

    return missing_keys

def main():
    parser = argparse.ArgumentParser(description='Identify keys missing in localization.strings from a key list file')
    parser.add_argument('-p', '--keylist_file', help='Path to the key list file', required=True)
    parser.add_argument('-f', '--localization_file', help='Localization.strings file to check for missing keys', required=True)
    args = parser.parse_args()

    # Read keys from the key list file
    key_list = read_key_list(args.keylist_file)

    # Find missing keys in localization.strings
    missing_keys = find_missing_keys(args.localization_file, key_list)

    # Print the list of missing keys
    print("Keys missing in localization.strings:")
    for key in missing_keys:
        print(key)

if __name__ == '__main__':
    main()
