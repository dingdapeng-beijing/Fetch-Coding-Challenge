import pandas as pd
import json

# Load JSON data
with open('data.json') as f:
    data = json.load(f)

# Convert to DataFrame
df = pd.json_normalize(data)

# Export to CSV
df.to_csv('data.csv', index=False)

# Export to SQLite
import sqlite3
conn = sqlite3.connect('data.db')
df.to_sql('table_name', conn, if_exists='replace', index=False)
