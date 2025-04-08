import os
import pandas as pd
from sqlalchemy import create_engine
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
import logging
from datetime import datetime

def ingest_data():
    # Configuration du logging
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)
    
    try:
        # Configuration PostgreSQL
        pg_user = os.environ['POSTGRES_USER']
        pg_password = os.environ['POSTGRES_PASSWORD']
        pg_host = os.environ['POSTGRES_HOST']
        pg_db = os.environ['POSTGRES_DB']
        
        logger.info(f"Configuration PostgreSQL - Host: {pg_host}, DB: {pg_db}, User: {pg_user}")

        # Configuration Snowflake
        snowflake_account = os.environ['SNOWFLAKE_ACCOUNT']
        snowflake_user = os.environ['SNOWFLAKE_USER']
        snowflake_password = os.environ['SNOWFLAKE_PASSWORD']
        snowflake_role = os.environ['SNOWFLAKE_ROLE']
        snowflake_database = os.environ['SNOWFLAKE_DATABASE']
        snowflake_warehouse = os.environ['SNOWFLAKE_WAREHOUSE']
        
        logger.info(f"Configuration Snowflake - Account: {snowflake_account}, DB: {snowflake_database}, User: {snowflake_user}")

        # Connexion à PostgreSQL
        pg_engine = create_engine(f'postgresql://{pg_user}:{pg_password}@{pg_host}:5432/{pg_db}')
        logger.info("Connexion à PostgreSQL établie")

        # Test de la connexion PostgreSQL
        with pg_engine.connect() as conn:
            result = conn.execute("SELECT 1").fetchone()
            logger.info("Test de connexion PostgreSQL réussi")

        # Connexion à Snowflake
        snow_conn = snowflake.connector.connect(
            account=snowflake_account,
            user=snowflake_user,
            password=snowflake_password,
            role=snowflake_role,
            database=snowflake_database,
            warehouse=snowflake_warehouse
        )
        logger.info("Connexion à Snowflake établie")

        # Test de la connexion Snowflake
        cursor = snow_conn.cursor()
        
        # Création et utilisation de la base de données
        cursor.execute(f'CREATE DATABASE IF NOT EXISTS {snowflake_database}')
        cursor.execute(f'USE DATABASE {snowflake_database}')
        logger.info(f"Base de données {snowflake_database} créée et sélectionnée")
        
        # Création et utilisation du warehouse
        cursor.execute(f'CREATE WAREHOUSE IF NOT EXISTS {snowflake_warehouse}')
        cursor.execute(f'USE WAREHOUSE {snowflake_warehouse}')
        logger.info(f"Warehouse {snowflake_warehouse} créé et sélectionné")
        
        # Création et utilisation du schéma RAW
        cursor.execute('CREATE SCHEMA IF NOT EXISTS RAW')
        cursor.execute('USE SCHEMA RAW')
        logger.info("Schéma RAW créé et sélectionné")

        # Tables à migrer
        tables = ['category', 'books', 'customers', 'factures', 'ventes']

        # Migration des données
        for table in tables:
            try:
                logger.info(f'Début de la migration de la table {table}...')
                
                # Lecture depuis PostgreSQL
                df = pd.read_sql(f'SELECT * FROM {table}', pg_engine)
                logger.info(f'Lecture de {len(df)} lignes depuis PostgreSQL pour {table}')
                
                # Renommer les colonnes pour Snowflake (majuscules)
                df.columns = [col.upper() for col in df.columns]
                
                # Suppression de la table si elle existe
                cursor.execute(f'DROP TABLE IF EXISTS RAW.{table.upper()}')
                logger.info(f'Table RAW.{table.upper()} supprimée si elle existait')
                
                # Écriture dans Snowflake
                success, nchunks, nrows, _ = write_pandas(
                    snow_conn,
                    df,
                    table.upper(),
                    schema='RAW',
                    auto_create_table=True,
                    quote_identifiers=False
                )
                
                if success:
                    logger.info(f'Migration réussie de {nrows} lignes en {nchunks} chunks pour {table}')
                    
                    # Vérification de la table créée
                    cursor.execute(f"SELECT COUNT(*) FROM RAW.{table.upper()}")
                    count = cursor.fetchone()[0]
                    logger.info(f'Vérification de la table {table}: {count} lignes trouvées')
                    
                    # Vérification de la structure de la table
                    cursor.execute(f"DESC TABLE RAW.{table.upper()}")
                    columns = cursor.fetchall()
                    logger.info(f'Structure de la table {table}:')
                    for col in columns:
                        logger.info(f'  - {col[0]}: {col[1]}')
                else:
                    raise Exception(f"Échec de l'écriture dans Snowflake pour la table {table}")
                
            except Exception as e:
                logger.error(f'Erreur lors de la migration de la table {table}: {str(e)}')
                raise

        # Vérification finale des tables
        cursor.execute("SHOW TABLES IN SCHEMA RAW")
        tables_in_raw = cursor.fetchall()
        logger.info("Tables dans le schéma RAW:")
        for table_info in tables_in_raw:
            logger.info(f"  - {table_info[1]}")

        logger.info('Migration terminée avec succès !')
        
    except Exception as e:
        logger.error(f'Erreur lors de la migration: {str(e)}')
        raise
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'snow_conn' in locals():
            snow_conn.close()

if __name__ == '__main__':
    ingest_data() 