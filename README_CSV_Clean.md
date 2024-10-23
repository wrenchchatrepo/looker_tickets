# clean_csv

This repository provides tools for cleaning, validating, and processing CSV files. It automates tasks such as sampling, defect detection, and validation through the CSVLint API, with plans for future integration with the Gemini Function Calling API to resolve defects dynamically.

## Repository Structure

/home/clean_csv/           			# Local repository
├── cloud_sdk/             			# Contains .gitignore, and Google Cloud SDK commands (gcloud, gsutil, bq)
├── csvlint_api/
│   └── CSVLint_API.md 			    # Documentation for using the CSVLint API
├── data/                			# Directory for storing CSV files (included in .gitignore)
├── output_mkdn/
│   └── defect_stats_example.md 	# Example output of errors before running clean_csv.py
├── scripts/                		# Contains Python scripts for various tasks
│   ├── clean_csv.py        		# Main script for cleaning CSV files
│   ├── defect_stats.py     		# Script to count defects before cleaning
│   ├── extract_error_rows.py  		# Extract rows with errors from CSVLint JSON
│   ├── sample_csv.py       		# Generates a sample CSV (e.g., filename_sample.csv)
│   └── serve_file.py       		# Starts a local server for CSVLint API
├── venv/                   		# Python virtual environment (included in .gitignore)
├── config.yaml             		# config file for all scripts
├── README.md               		# This is the README file
├── install.sh              		# Installation script for dependencies
├── invoke.py 	            		# Orchestrates the execution of other scripts
└── requirements.txt        		# Python package dependencies

## Instructions for Setup

```bash
# Navigate to the directory of the CSV to clean
cd /path/to/file-to-clean.csv

# Clone the repo
git clone https://github.com/your-organization/clean_csv.git
cd clean_csv

# Run the installation script
chmod +x install.sh
./install.sh
```
The install.sh script performs the following actions:

+ Installs yq based on the operating system
**+ Prompts the user for the path and filename of the CSV file**
+ Updates config.yaml with the provided values
+ Constructs the full path for the CSV file
+ Retrieves the file size and row count
+ Checks if sampling is needed (based on a 200MB threshold)
+ Updates config.yaml with the results using yq
+ Ensures pip is installed and up to date
+ Sets up a Python virtual environment
+ Installs Python dependencies from requirements.txt
+ Ensures the data/ directory exists and moves the CSV file into it

## Instructions for Cleaning the CSV

`python invoke.py`

The invoke.py script reads from config.yaml and executes the following tasks:

+ Runs sample_csv.py if sampling is needed, generating a sample CSV (e.g., filename_sample.csv)
+ Runs clean_csv.py to clean either the original or sampled CSV; generates filename_cleaned.csv or filename_sample_cleaned.csv in the /data/ direcotry
+ Runs validate_csv.py to submit the cleaned CSV to the CSVLint API and handles the response

### Error Handling

If there are still errors detected by the CSVLint API, you can manually run the following script:

`python scripts/extract_error_rows.py`

This will extract problematic rows and generate input for the Gemini Function Calling API, which will help update clean_csv.py to automatically resolve defects (to be developed).

## Future Development

Gemini Function Calling API Integration: We plan to integrate the Gemini Function Calling API to dynamically resolve issues detected by the CSVLint API.