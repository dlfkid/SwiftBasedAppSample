import os
import argparse

def find_target_files(directory, exclude_paths):
    target_files = []
    for root, dirs, files in os.walk(directory):
        if any(os.path.commonpath([root, exc]) == exc for exc in exclude_paths):
            continue  # Skip excluded directories
        for file in files:
            if (file.endswith('VC.m') or file.endswith('ViewController.m') or
                file.endswith('VC.mm') or file.endswith('ViewController.mm') or
                file.endswith('VC.swift') or file.endswith('ViewController.swift')):
                target_files.append((os.path.join(root, file), file.rsplit('.', 1)[0]))
    return target_files

def check_usage_in_directory(directory, target_files, exclude_paths):
    for file_path, class_name in target_files:
        if not is_class_used(directory, class_name, exclude_paths):
            print(file_path)

def is_class_used(directory, class_name, exclude_paths):
    search_strings = [f'{class_name} alloc', f'{class_name} new', f'{class_name}(', f'{class_name}.init', f'{class_name}.new']
    for root, dirs, files in os.walk(directory):
        if any(os.path.commonpath([root, exc]) == exc for exc in exclude_paths):
            continue  # Skip excluded directories
        for file in files:
            if file.endswith(('.m', '.mm', '.swift')):
                if check_file_for_string(os.path.join(root, file), search_strings):
                    return True
    return False

def check_file_for_string(file_path, search_strings):
    try:
        with open(file_path, 'r') as file:
            contents = file.read()
            if any(s in contents for s in search_strings):
                return True
    except Exception as e:
        print(f"Error reading file {file_path}: {e}")
    return False

def parse_arguments():
    parser = argparse.ArgumentParser(description='Search for unused class initializations in code files.')
    parser.add_argument('-p', '--path', type=str, required=True, help='Directory path to search')
    parser.add_argument('-e', '--exclude', nargs='*', help='Paths to exclude from search', default=[])
    args = parser.parse_args()
    return args.path, args.exclude

if __name__ == "__main__":
    directory_to_search, exclude_paths = parse_arguments()
    target_files = find_target_files(directory_to_search, exclude_paths)
    check_usage_in_directory(directory_to_search, target_files, exclude_paths)
