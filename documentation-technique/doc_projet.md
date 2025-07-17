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

| Nom du programme   | Programme appelant | Programme appelé | Description                                  |
|--------------------|--------------------|------------------|----------------------------------------------|
| ajucli             |                    | aucun            | Ajout de clients dans la base de données     |
| ajulog             |                    | aucun            | Création et ajout des logs à la base de données |
| ajuliv             |                    | ajulog           | Ajout de livraison à la base de données      |
| ajulivpi           |                    | aucun            | Ajout des pièces à inclure dans une livraison dans la base de données |
| ajupie             |                    | aucun            | Ajout de pièces dans la base de données      |
| ajufou             |                    | aucun            | Ajout de fournisseur                         |
| ajuuti             |                    | aucun            | Ajout d'un utilisateur                       |
| conbdd             |                    | aucun            | Connexion à la base de données               |
| ecrajcli           |                    | verema, ajucli   | Ecran de création de client                  |
| ecrajfou           |                    | ajufou           | Ecran d'ajout de fournisseur                 |
| ecrajliv           |                    | ajuliv, liridpie, ajulivpi | Ecran d'ajout de livraison à la base de données |
| ecrajpie           |                    | ajupie           | Ecran d'ajout de pièces                      |
| ecrajuti           |                    | ajuuti           | Ecran d'ajout utilisateur                    |
| ecrcxbdd           |                    | conbdd           | Ecran d'accueil du logiciel                  |
| ecrchcli           |                    | ecrrecli, ecrpgcli | Ecran de choix de lecture des clients     |
| ecrchfou           |                    | ecrrefou, ecrpgfou | Ecran de choix de lecture de fournisseur  |
| ecrchliv           |                    | ecridliv, ecrpgliv | Ecran de choix de lecture de livraison    |
| ecrchpie           |                    | ecrrepie, ecrpgpie | Ecran de choix de lecture des pièces      |
| ecrcxuti           |                    | liruti, ajulog   | Ecran de connexion utilisateur               |
| ecrgsccli          |                    | ecrgsccli, ecrgsccli | Ecran de gestion de clients               |
| ecrgscli           |                    | ecrajcli, ecrchcli, ecrmjcli, ecrspcli | Ecran de gestion de client |
| ecrgsfou           |                    | ecrajfou, ecrchfou, ecrmjfou, ecrspfou | Ecran de gestion des fournisseurs |
| ecrgsliv           |                    | ecrajliv, ecrchliv, ecrmjliv, ecrspliv | Ecran de gestion des livraisons |
| ecrgspie           |                    | ecrajpie, ecrchpie, ecrmjinf, ecrsppie, ecrmjpie | Ecran menu de gestion des pièces |
| ecridliv           |                    | liridliv         | Ecran de lecture d'une livraison par ID      |
| ecrmnprn           |                    | ecrgspie, ecrgscli, ecrgsfou, ecrgsliv, ecrpglog, ecrajuti | Ecran du menu principal |
| ecrpgcli           |                    | lirpgcli         | Ecran de lecture des informations de clients par page |
| ecrpgfou           |                    | lirpgfou         | Ecran de lecture des informations de fournisseurs par page |
| ecrpglog           |                    | lirpglog         | Ecran de lecture des logs                    |
| ecrpgpie           |                    | lirpgpie         | Ecran de lecture des informations des pièces par page |
| ecrpgliv           |                    | lirpgliv         | Ecran de lecture d'une livraison par page et par filtre |
| ecrrecli           |                    | liridcli, lirnmcli | Ecran de recherche de client par ID ou par nom et de lecture des informations du client correspondant |
| ecrrefou           |                    | liridfou, lirnmfou | Ecran de recherche de fournisseur par ID ou par nom et de lecture des informations du fournisseur correspondant |
| ecrrepie           |                    | liridpie, lirnmpie | Ecran de recherche de pièce par ID ou par nom et de lecture des informations de la pièce correspondante |
| ecrsppie           |                    | suppie           | Ecran de suppression de pièces               |
| ecrspcli           |                    | supcli           | Ecran de suppression de client               |
| ecrspfou           |                    | supfou           | Ecran de suppression de fournisseur          |
| ecrspliv           |                    | liridliv, fetlivpi, majpie, supliv | Ecran de suppression de livraison      |
| ecrmjcli           |                    | liridcli, majcli | Ecran de mise à jour des informations d'un client |
| ecrmjfou           |                    | liridfou, majfou | Ecran de mise à jour d'un fournisseur        |
| ecrmjinf           |                    | liridpie, mjinfpie | Ecran de mise à jour des informations d'une pièce |
| ecrmjliv           |                    | liridliv, majliv, fetlivpi, majpie | Ecran de mise à jour des livraisons     |
| ecrmjpie           |                    | majpie           | Ecran de modifications d'une pièce           |
| liridcli           |                    | aucun            | Lecture des informations d'un client         |
| liridfou           |                    | aucun            | Lecture des informations d'un fournisseur    |
| liridliv           |                    | aucun            | Lecture d'une livraison par ID               |
| liridpie           |                    | aucun            | Lecture des pièces par ID                    |
| lirnmcli           |                    | aucun            | Récupération des informations d'un client par nom |
| lirnmfou           |                    | aucun            | Récupération des informations d'un fournisseur par nom |
| lirnmpie           |                    | aucun            | Récupération des informations d'une pièce par nom |
| lirpgcli           |                    | aucun            | Récupération des informations sur les clients par page |
| lirpgfou           |                    | aucun            | Récupération des informations sur les fournisseurs par page |
| lirpglog           |                    | aucun            | Récupération des logs                        |
| lirpgpie           |                    | aucun            | Récupération des informations sur les pièces par page |
| lirpgliv           |                    | aucun            | Récupération des informations sur les livraisons par page |
| liruti             |                    | aucun            | Lecture des informations d'un utilisateur    |
| majcli             |                    | aucun            | Mise à jour des informations d'un client     |
| majfou             |                    | ajulog           | Mise à jour des informations d'un fournisseur|
| majliv             |                    | aucun            | Mise à jour du statut de livraison           |
| majpie             |                    | ajulog           | Gestion des entrées et sorties des pièces    |
| mjinfpie           |                    | ajulog           | Mise à jour des informations d'une pièce     |
| supliv             |                    | ajulog           | Suppression de livraison                     |
| supcli             |                    | aucun            | Suppression de client                        |
| supfou             |                    | ajulog           | Suppression de fournisseur                   |
| suppie             |                    | aucun            | Suppression de pièces                        |
| verema             |                    | aucun            | Vérification du format de l'email            |



