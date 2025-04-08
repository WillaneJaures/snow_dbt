# Bookshop Dashboard

Ce dashboard permet de visualiser les données de ventes de la librairie Bookshop.

## Configuration

1. Installez les dépendances :
```bash
pip install -r requirements.txt
```

2. Configurez les variables d'environnement dans le fichier `.env` :
```
SNOWFLAKE_ACCOUNT=votre_compte
SNOWFLAKE_USER=votre_utilisateur
SNOWFLAKE_PASSWORD=votre_mot_de_passe
SNOWFLAKE_DATABASE=BOOKSHOP
SNOWFLAKE_WAREHOUSE=COMPUTE_WH
```

## Lancement de l'application

Pour lancer l'application, exécutez la commande suivante :
```bash
streamlit run app/app.py
```

## Fonctionnalités

Le dashboard affiche :
- Les ventes totales par catégorie de livres
- L'évolution des ventes par mois
- Le top 10 des livres les plus vendus
- Un tableau détaillé des ventes par catégorie

## Structure du projet

```
├── app/
│   └── app.py           # Application Streamlit
├── .env                 # Variables d'environnement
├── requirements.txt     # Dépendances Python
└── README.md           # Documentation
``` 