import os
import argparse

# 使用方法: python3 add_dependency.py -p $要注入的文件目录 -k $要查找的关键字 -l "#import \"$要出入的依赖\"" -b $黑名单文件, 不想被注入的.m文件

def check_keyword_in_file(file_path, keyword):
    with open(file_path, 'r') as f:
        content = f.read()
        if keyword in content:
            return True
    return False

def insert_text_into_file(directory, keyword, text, blacklist):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if not file.endswith('.m'):
                continue
            if file in blacklist:
                continue
            file_path = os.path.join(root, file)
            # avoid keyword not exist in file content
            if not check_keyword_in_file(file_path, keyword):
                continue
            # avoid inserted text already exist in file content
            if check_keyword_in_file(file_path, text):
                continue
            print(f'checking file : {file}')
            with open(file_path, 'r+') as f:
                lines = f.readlines()
                f.seek(0, 0)
                last_import_line_index = -1
                for i, line in enumerate(lines):
                    if line.startswith('#import'):
                        last_import_line_index = i
                if last_import_line_index != -1:
                    lines.insert(last_import_line_index + 1, text + '\n')
                else:
                    lines.insert(0, text + '\n')
                f.writelines(lines)
            print(f'Insertion completed for file: {file_path}')
                

if __name__ == '__main__':
    # Parse command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', dest='directory_path', help='Directory path to search files')
    parser.add_argument('-k', dest='keyword', help='Keyword to match in file names')
    parser.add_argument('-l', dest='inserted_text', help='Text line to be inserted')
    parser.add_argument('-b', dest='blacklist', nargs='*', help='Files to avoid insertion')
    args = parser.parse_args()

    # Example usage
    directory_path = args.directory_path
    keyword = args.keyword
    inserted_text = args.inserted_text
    blacklist = args.blacklist if args.blacklist is not None else []

    print(f'Path: {directory_path} | KeyWord: {keyword} | Inserted: {inserted_text} | blacklist{blacklist}')

    insert_text_into_file(directory_path, keyword, inserted_text, blacklist)