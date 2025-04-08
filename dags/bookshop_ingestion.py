from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
import sys
import os

sys.path.append('/opt/airflow/scripts')
from ingest_to_snowflake import ingest_data

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'bookshop_ingestion',
    default_args=default_args,
    description='Ingestion des données Bookshop de PostgreSQL vers Snowflake',
    schedule_interval='@daily',
    catchup=False,
    tags=['bookshop', 'ingestion']
)

ingest_task = PythonOperator(
    task_id='ingest_to_snowflake',
    python_callable=ingest_data,
    dag=dag,
    retries=0
)

ingest_task 