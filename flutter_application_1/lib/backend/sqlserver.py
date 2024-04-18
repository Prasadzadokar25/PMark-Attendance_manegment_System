import pyodbc  as odbc
import pandas as pd

driver_name = 'SQL SERVER'
server_name = 'PRADSAD-25\SQLEXPRESS01'
database_name = 'bigbite'

connection_string = (
    "DRIVER = {ODBC Driver 17 for SQL Server};"
    "SERVER = PRADSAD-25\SQLEXPRESS01;"
    "DATABASE = bigbite;"
    "Trust_Connection = yes;")


conn =odbc.connect(connection_string)
cursor = conn.cursor()

cursor.execute("select * from userInfo")
df = pd.read_sql("select * from userInfo",conn)
print(df)

       