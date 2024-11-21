import sqlite3
import pandas as pd
import os

# Create SQLite database
conn = sqlite3.connect('my_database.db')

# List of CSV files to import
csv_files = ['users.csv', 'brands.csv', 'receipts.csv']

for csv_file in csv_files:
    if os.path.exists(csv_file):
        table_name = os.path.splitext(os.path.basename(csv_file))[0]  # Extract table name
        df = pd.read_csv(csv_file)
        print(f"Loaded {csv_file} with {len(df)} rows")
        df.to_sql(table_name, conn, if_exists='replace', index=False)
        print(f"Imported {csv_file} into table '{table_name}'")
    else:
        print(f"File not found: {csv_file}")

print("All valid CSV files have been imported!")
conn.close()
