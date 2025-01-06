import sys

def find_duplicate_values(file_path):
    key_value_pairs = {}
    duplicate_values = []

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

                if value in key_value_pairs:
                    if value not in duplicate_values:
                        duplicate_values.append(value)
                else:
                    key_value_pairs[value] = key

    return duplicate_values

if __name__ == '__main__':
    if len(sys.argv) != 3 or sys.argv[1] != '-p':
        print("Usage: python script.py -p <file_path>")
        sys.exit(1)

    file_path = sys.argv[2]
    print("Processing file:", file_path)

    duplicates = find_duplicate_values(file_path)

    if duplicates:
        print("Duplicate value found:")
        for value in duplicates:
            print(value)
    else:
        print("No duplicate value found.")
