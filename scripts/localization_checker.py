import os
import re
import argparse

def extract_keys_from_localization_strings(file_path):
    with open(file_path, 'r') as f:
        content = f.read()

    # Use regular expression to find keys in localization.strings
    keys = re.findall(r'"(.*?)"\s*=\s*".*?";', content)
    return keys

def find_keys_in_json_files(json_files, keys):
    found_keys = set()

    for json_file in json_files:
        with open(json_file, 'r') as f:
            json_content = f.read()

        # Check if each key in localization.strings exists in the JSON file content
        for key in keys:
            if key in json_content:
                found_keys.add(key)

    return list(found_keys)

def main():
    parser = argparse.ArgumentParser(description='Scan JSON files for keys used in localization.strings')
    parser.add_argument('-p', '--filepath', help='Path to the directory to scan for JSON files', required=True)
    parser.add_argument('-f', '--localization_file', help='Localization.strings file to extract keys from', required=True)
    args = parser.parse_args()

    # Extract keys from localization.strings
    keys = extract_keys_from_localization_strings(args.localization_file)

    # Find JSON files in the specified directory and its subdirectories
    json_files = [os.path.join(root, file) for root, dirs, files in os.walk(args.filepath) for file in files if file.endswith('.json')]

    # Find keys in JSON files
    found_keys = find_keys_in_json_files(json_files, keys)

    # Print the list of keys found in JSON files
    print("Keys found in JSON files:")
    for key in found_keys:
        print(key)

if __name__ == '__main__':
    main()
