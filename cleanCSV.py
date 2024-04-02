import pandas as pd
import csv

def correct_csv_line(line):
    in_quote = False
    corrected_line = []
    for char in line:
        if char == '"':
            in_quote = not in_quote  # Toggle the in-quote state
            corrected_line.append(char)
        elif char == ',' and not in_quote:
            corrected_line.append(char)
        elif in_quote or char not in [',', '\r', '\n']:
            corrected_line.append(char)
    if in_quote:
        corrected_line.append('"')  # Close the open quote if needed
    return ''.join(corrected_line)

def correct_and_standardize_csv(input_file_path, output_file_path):
    with open(input_file_path, 'r', encoding='utf-8') as infile, open(output_file_path, 'w', newline='', encoding='utf-8') as outfile:
        for line in infile:
            # Apply line corrections for quotes and commas
            corrected_line = correct_csv_line(line)
            # Write the corrected lines with standardized line breaks (CR-LF)
            outfile.write(corrected_line + '\r\n')

def count_defects_csv(file_path):
    defects = 0
    with open(file_path, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        for row in reader:
            try:
                parsed_row = list(csv.reader([','.join(row)], skipinitialspace=True))[0]
                if any(contains_special_characters(field) for field in parsed_row):
                    defects += 1
            except csv.Error:
                defects += 1
    return defects

def contains_special_characters(value):
    if pd.isnull(value):
        return False
    if ',' in value or '"' in value or value.strip().startswith('='):
        return True
    return False

# Specify your file paths
input_file_path = '/Users/dionedge/gs-uploads/tickets-edge_2024-03-25T0002.csv'
corrected_file_path = '/Users/dionedge/gs-uploads/fixed-tickets-edge.csv'

# Run the combined correction process
correct_and_standardize_csv(input_file_path, corrected_file_path)

# Optionally, count defects in the corrected file to verify improvements
defects_after_correction = count_defects_csv(corrected_file_path)
print(f"Defects after correction: {defects_after_correction}")
