import os
import csv

def remove_line_from_files(directory, csv_file, log_file):
    line_to_remove = "@               IN A            136.147.129.27"  # Line to be removed
    
    # Check if the directory exists
    if not os.path.isdir(directory):
        print(f"The directory {directory} does not exist.")
        return
    
    # Check if the CSV file exists
    if not os.path.isfile(csv_file):
        print(f"The CSV file {csv_file} does not exist.")
        return
    
    # Open the log file to record failures
    with open(log_file, 'w') as log:
        log.write('Failed Files Log\n')
        log.write('----------------\n')

        # Read the CSV file
        with open(csv_file, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                file_name = row['file_name']

                file_path = os.path.join(directory, file_name)

                # Check if the file exists before trying to modify it
                if os.path.isfile(file_path):
                    try:
                        # Read the current file contents
                        with open(file_path, 'r') as file:
                            lines = file.readlines()

                        # Write back all lines except the line to remove
                        with open(file_path, 'w') as file:
                            for line in lines:
                                if line.strip() != line_to_remove:
                                    file.write(line)
                            print(f"Removed line from {file_name}")
                    except Exception as e:
                        log.write(f"{file_name} - Error: {e}\n")
                        print(f"Could not remove line from {file_name}: {e}")
                else:
                    log.write(f"{file_name} - Error: File does not exist\n")
                    print(f"File {file_name} does not exist in the directory {directory}.")

# Example usage:
directory_path = './'  # Replace with the path to your directory
csv_file_path = './file_lines.csv'  # Replace with the path to your CSV file
log_file_path = './failed_files.log'  # Replace with the path for the log file

remove_line_from_files(directory_path, csv_file_path, log_file_path)
