import sys

def find_duplicate_keys(file_path):
    key_value_pairs = {}
    duplicate_keys = []

    with open(file_path, 'r') as file:
        lines = file.readlines()

    for line in lines:
        line = line.strip()
        if line.endswith(';'):
            line = line[:-1]  # Remove the trailing ';' character

            parts = line.split('=')
            if len(parts) == 2:
                key = parts[0].strip().strip('"')
                value = parts[1].strip().strip('"')

                if key in key_value_pairs:
                    if key not in duplicate_keys:
                        duplicate_keys.append(key)
                else:
                    key_value_pairs[key] = value

    return duplicate_keys

if __name__ == '__main__':
    if len(sys.argv) != 3 or sys.argv[1] != '-p':
        print("Usage: python script.py -p <file_path>")
        sys.exit(1)

    file_path = sys.argv[2]
    print("Processing file:", file_path)

    duplicates = find_duplicate_keys(file_path)

    if duplicates:
        print("Duplicate keys found:")
        for key in duplicates:
            print(key)
    else:
        print("No duplicate keys found.")
