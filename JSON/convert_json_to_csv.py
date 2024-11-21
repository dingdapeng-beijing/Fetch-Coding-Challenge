import json
import csv

# Input and output file paths
input_file = 'users.json'
output_file = 'users_1.csv'

# Read the JSON file line by line
data = []
with open(input_file, 'r') as json_file:
    for line in json_file:
        data.append(json.loads(line.strip()))

# Open CSV file for writing
with open(output_file, 'w', newline='') as csv_file:
    if isinstance(data, list):
        writer = csv.DictWriter(csv_file, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)
    else:
        raise ValueError("Unexpected JSON structure")

print(f"CSV file '{output_file}' has been created.")
