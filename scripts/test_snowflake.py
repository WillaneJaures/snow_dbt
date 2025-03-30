import snowflake.connector
import os

def test_connection():
    try:
        conn = snowflake.connector.connect(
            account=os.environ['SNOWFLAKE_ACCOUNT'],
            user=os.environ['SNOWFLAKE_USER'],
            password=os.environ['SNOWFLAKE_PASSWORD'],
            warehouse=os.environ['SNOWFLAKE_WAREHOUSE'],
            database=os.environ['SNOWFLAKE_DATABASE'],
            role=os.environ['SNOWFLAKE_ROLE']
        )
        
        print("Connexion établie avec succès!")
        
        cur = conn.cursor()
        cur.execute('USE DATABASE BOOKSHOP')
        cur.execute('USE SCHEMA RAW')
        cur.execute('SHOW TABLES')
        
        print("\nTables dans le schéma RAW:")
        for row in cur.fetchall():
            print(row)
            
        print("\nTest des données:")
        tables = ['CATEGORY', 'BOOKS', 'CUSTOMERS', 'FACTURES', 'VENTES']
        for table in tables:
            cur.execute(f'SELECT COUNT(*) FROM {table}')
            count = cur.fetchone()[0]
            print(f"{table}: {count} lignes")
            
        cur.close()
        conn.close()
        
    except Exception as e:
        print(f"Erreur: {str(e)}")

if __name__ == '__main__':
    test_connection() 