# Documentation technique du projet 

## Informations générales 
**Nom du projet :** Logiparts Solutions Management

**Objectif global :** Développer une application COBOL pour gérer un inventaire de pièces, une base de clients, une base de fournisseurs et une gestion des livraisons.

**Equipe** : HIMYC (How I Met Your COBOL)
- Chef de projet : Terry Serretta
- Tech Lead : Léo Calendini
- Admin base de données : Thomas Baudrin
- Développeurs :   
Anaïs Bracq    
Benoit Zeinati  
Lucas Jourdain  
Sibory Gueye  
Thomas Durizot   
Yassine Ramazan 


**Date** : Du 23 juin 2025 au 18 juillet 2025

**Contexte fonctionnel** : Remplacer un système papier vieillissant par une application informatique simple et fiable.

**Environnement technique** : 
- Langage : COBOL avec le compilateur GnuCOBOL
- Interface : `SCREEN SECTION` pour menus et affichages
- Base de données : PostgreSQL  


## Architecture du projet

**Organigramme des programmes**

| Programme appelant | Programme appelé | Description                         |
|--------------------|------------------|-------------------------------------|
| PGMAIN             | PGTOT            | Calcule les totaux                  |
| PGMAIN             | PGCALC           | Fait les calculs de taux            |
| PGMAIN             | PGGEN            | Génère les fichiers finaux          |
| PGGEN              | PGSUBGEN         | Gère les détails de formatage       |

