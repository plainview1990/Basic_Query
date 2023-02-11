import pyodbc

con_string = "driver=ODBC Driver 17for SQL Server;server=WAREHOUSE;database=SiS_Cloud;trusted_connection=yes"

def create_table():
    sql = """
        create table test(
            id int identity(1,1) primary key,
            gender char(1),
            height real
            weight real,
        )
    """
with pyodbc.connect(con_string) as con:
    con.execute(sql)
