import os
import re
import argparse

# Function to parse a Localizable.strings file and extract keys
def extract_localizable_keys(localizable_file):
    keys = set()
    with open(localizable_file, 'r', encoding='utf-8') as file:
        for line in file:
            match = re.search(r'"(.*?)"\s*=', line)
            if match:
                keys.add(match.group(1))
    return keys

# Function to find and remove unused keys from Localizable.strings
def remove_unused_keys(source_dir, localizable_file):
    used_keys = set()

    # Extract keys from Localizable.strings
    localizable_keys = extract_localizable_keys(localizable_file)

    # Traverse source files to find used keys
    for root, _, files in os.walk(source_dir):
        for file in files:
            if file.endswith(('.m', '.mm', '.swift', '.json')):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as source_file:
                    content = source_file.read()
                    for key in localizable_keys:
                        if key in content:
                            used_keys.add(key)

    # Find unused keys
    unused_keys = localizable_keys - used_keys

    # Remove unused key-value pairs from Localizable.strings
    with open(localizable_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    with open(localizable_file, 'w', encoding='utf-8') as file:
        for line in lines:
            match = re.search(r'"(.*?)"\s*=', line)
            if not match or match.group(1) not in unused_keys:
                file.write(line)

def process_localizable_files(root_dir):
    for root, _, files in os.walk(root_dir):
        for file in files:
            if file == 'Localizable.strings':
                localizable_file = os.path.join(root, file)
                remove_unused_keys(root_dir, localizable_file)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Remove unused localized strings from Localizable.strings")
    parser.add_argument("-p", "--project-dir", required=True, help="iOS project directory")
    args = parser.parse_args()

    project_dir = args.project_dir

    process_localizable_files(project_dir)
    print("Unused localized strings removed from all Localizable.strings files.")
