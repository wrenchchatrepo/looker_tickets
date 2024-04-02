import csv

def correct_csv_errors(input_file_path, output_file_path):
    with open(input_file_path, 'r', encoding='utf-8') as infile, open(output_file_path, 'w', newline='', encoding='utf-8') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile, quoting=csv.QUOTE_ALL, doublequote=True)
        row_number = 0

        for row in reader:
            row_number += 1
            # Initial defect count for the row is 0
            defect_count = 0
            
            corrected_row = []
            for field in row:
                # Count quotes to find unbalanced ones as defects
                quote_count = field.count('"')
                if quote_count % 2 != 0:  # Unbalanced quotes in a field
                    defect_count += 1
                # Correct the field by replacing a single instance of " with ""
                corrected_field = field.replace('"', '""')
                corrected_row.append(corrected_field)
                
            writer.writerow(corrected_row)
            
            if defect_count > 0:
                print(f"Row {row_number} defects: {defect_count}")

# Specify the original and corrected file paths
input_file_path = '/Users/dionedge/gs-uploads/tickets-edge_2024-03-25T0002.csv'
output_file_path = '/Users/dionedge/gs-uploads/corrected-tickets-edge.csv'

# Correct the CSV file using the defined function
correct_csv_errors(input_file_path, output_file_path)

print("Correction applied. Please check the corrected file.")
