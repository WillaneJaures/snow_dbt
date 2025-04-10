import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv
import plotly.express as px

# Chargement des variables d'environnement
load_dotenv()

# Configuration de la connexion Snowflake
snowflake_account = os.getenv('SNOWFLAKE_ACCOUNT')
snowflake_user = os.getenv('SNOWFLAKE_USER')
snowflake_password = os.getenv('SNOWFLAKE_PASSWORD')
snowflake_database = os.getenv('SNOWFLAKE_DATABASE')
snowflake_warehouse = os.getenv('SNOWFLAKE_WAREHOUSE')

# Création de la connexion
engine = create_engine(
    f'snowflake://{snowflake_user}:{snowflake_password}@{snowflake_account}/{snowflake_database}/{snowflake_warehouse}'
)

# Configuration de la page
st.set_page_config(page_title="Bookshop Dashboard", layout="wide")
st.title("Bookshop Dashboard")

# Fonction pour charger les données
@st.cache_data
def load_data():
    # Ventes totales par catégorie
    sales_by_category = pd.read_sql("""
        SELECT 
            v.book_intitule as category,
            COUNT(*) as total_sales,
            SUM(v.quantite) as total_quantity,
            SUM(v.prix_unitaire * v.quantite) as total_amount
        FROM MARTS.OBT_SALES v
        GROUP BY v.book_intitule
        ORDER BY total_amount DESC
    """, engine)
    
    # Ventes par mois
    sales_by_month = pd.read_sql("""
        SELECT 
            mois,
            COUNT(*) as total_sales,
            SUM(quantite) as total_quantity,
            SUM(prix_unitaire * quantite) as total_amount
        FROM MARTS.OBT_SALES
        GROUP BY mois
        ORDER BY total_amount DESC
    """, engine)
    
    # Top 10 des livres
    top_books = pd.read_sql("""
        SELECT 
            book_intitule,
            COUNT(*) as total_sales,
            SUM(quantite) as total_quantity,
            SUM(prix_unitaire * quantite) as total_amount
        FROM MARTS.OBT_SALES
        GROUP BY book_intitule
        ORDER BY total_amount DESC
        LIMIT 10
    """, engine)
    
    return sales_by_category, sales_by_month, top_books

try:
    # Chargement des données
    sales_by_category, sales_by_month, top_books = load_data()
    
    # Première rangée de graphiques
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("Ventes par Catégorie (Montant total)")
        st.bar_chart(sales_by_category.set_index('category')['total_amount'])
    
    with col2:
        st.subheader("Ventes par Mois (Montant total)")
        st.bar_chart(sales_by_month.set_index('mois')['total_amount'])
    
    # Deuxième rangée de graphiques complémentaires
    st.markdown("---")
    st.subheader("Graphiques complémentaires")
    col3, col4, col5 = st.columns(3)
    
    with col3:
        st.subheader("Répartition des ventes par Catégorie")
        # Graphique en secteurs avec Plotly Express
        fig_pie = px.pie(
            sales_by_category,
            names='category',
            values='total_amount',
            title="Répartition des ventes (Montant total)"
        )
        st.plotly_chart(fig_pie, use_container_width=True)
    
    with col4:
        st.subheader("Ventes par Mois (Quantité totale)")
        # Utilisation de bar_chart pour la quantité totale vendue par mois
        st.bar_chart(sales_by_month.set_index('mois')['total_quantity'])
    
    with col5:
        st.subheader("Top 10 des Livres (Nombre de ventes)")
        st.bar_chart(top_books.set_index('book_intitule')['total_sales'])
    
    # Affichage détaillé
    st.markdown("---")
    st.subheader("Détails des Ventes par Catégorie")
    st.dataframe(sales_by_category)

except Exception as e:
    st.error(f"Erreur lors du chargement des données : {str(e)}")

