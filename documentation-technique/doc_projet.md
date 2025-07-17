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
| [ajucli](ajucli.md)             | ecrajcli                   | aucun            | Ajout de clients dans la base de données     |
| [ajulog](ajulog.md)             | ajuliv, ecrcxuti, majfou, majpie,supliv, mjinfpie, supfou                   | aucun            | Création et ajout des logs à la base de données |
| [ajuliv](ajuliv.md)             | ecrajliv                    | ajulog           | Ajout de livraison à la base de données      |
| [ajulivpi](ajulivpi.md)           | ecrajliv                   | aucun            | Ajout des pièces à inclure dans une livraison dans la base de données |
| [ajupie](ajupie.md)             | ecrajpie                   | aucun            | Ajout de pièces dans la base de données      |
| [ajufou](ajufou.md)             | ecrajfou                   | aucun            | Ajout de fournisseur dans la base de données                        |
| [ajuuti](ajuuti.md)             | ecrajuti                    | aucun            | Ajout d'un utilisateur dans la base de données                      |
| [conbdd](conbdd.md)             | ecrcxbdd                   | aucun            | Connexion à la base de données               |
| [ecrajcli](ecrajcli.md)           | ecrgscli                   | verema, ajucli   | Ecran de création de client                  |
| [ecrajfou](ecrajfou.md)           | ecrgsfou                   | ajufou           | Ecran d'ajout de fournisseur                 |
| [ecrajliv](ecrajliv.md)           | ecrgsliv                   | ajuliv, liridpie, ajulivpi | Ecran d'ajout de livraison  |
| [ecrajpie](ecrajpie.md)           | ecrgspie                   | ajupie           | Ecran d'ajout de pièces                      |
| [ecrajuti](ecrajuti.md)           | ecrmnprn                   | ajuuti           | Ecran d'ajout utilisateur                    |
| [ecrcxbdd](ecrcxbdd.md)           | aucun                   | conbdd           | Ecran d'accueil du logiciel                  |
| [ecrchcli](ecrchcli.md)           | ecrgscli                   | ecrrecli, ecrpgcli | Ecran de choix de lecture des clients     |
| [ecrchfou](ecrchfou.md)           | ecrgsfou                   | ecrrefou, ecrpgfou | Ecran de choix de lecture de fournisseur  |
| [ecrchliv](ecrchliv.md)           | ecrgsliv                   | ecridliv, ecrpgliv | Ecran de choix de lecture de livraison    |
| [ecrchpie](ecrchpie.md)           | ecrgspie                   | ecrrepie, ecrpgpie | Ecran de choix de lecture des pièces      |
| [ecrcxuti](ecrcxuti.md)           | aucun                   | liruti, ajulog   | Ecran de connexion utilisateur               |
| [ecrgscli](ecrgscli.md)           | ecrmnprn                   | ecrajcli, ecrchcli, ecrmjcli, ecrspcli | Ecran de gestion de client |
| [ecrgsfou](ecrgsfou.md)           | ecrmnprn                   | ecrajfou, ecrchfou, ecrmjfou, ecrspfou | Ecran de gestion des fournisseurs |
| [ecrgsliv](ecrgsliv.md)           | ecrmnprn                   | ecrajliv, ecrchliv, ecrmjliv, ecrspliv | Ecran de gestion des livraisons |
| [ecrgspie](ecrgspie.md)           | ecrmnprn                   | ecrajpie, ecrchpie, ecrmjinf, ecrsppie, ecrmjpie | Ecran menu de gestion des pièces |
| [ecridliv](ecridliv.md)           | ecrchliv                   | liridliv         | Ecran de lecture d'une livraison par ID      |
| [ecrmnprn](ecrmnprn.md)           | aucun                   | ecrgspie, ecrgscli, ecrgsfou, ecrgsliv, ecrpglog, ecrajuti | Ecran du menu principal |
| [ecrpgcli](ecrpgcli.md)           | ecrchcli                   | lirpgcli         | Ecran de lecture des informations de clients par page |
| [ecrpgfou](ecrpgfou.md)           | ecrchfou                   | lirpgfou         | Ecran de lecture des informations de fournisseurs par page |
| [ecrpglog](ecrpglog.md)           | ecrmnprn                   | lirpglog         | Ecran de lecture des logs                    |
| [ecrpgpie](ecrpgpie.md)           | ecrchpie                   | lirpgpie         | Ecran de lecture des informations des pièces par page |
| [ecrpgliv](ecrpgliv.md)           | ecrchliv                   | lirpgliv         | Ecran de lecture d'une livraison par page et par filtre |
| [ecrrecli](ecrrecli.md)           | ecrchcli                   | liridcli, lirnmcli | Ecran de recherche de client par ID ou par nom et de lecture des informations du client correspondant |
| [ecrrefou](ecrrefou.md)           | ecrchfou                   | liridfou, lirnmfou | Ecran de recherche de fournisseur par ID ou par nom et de lecture des informations du fournisseur correspondant |
| [ecrrepie](ecrrepie.md)           | ecrchpie                   | liridpie, lirnmpie | Ecran de recherche de pièce par ID ou par nom et de lecture des informations de la pièce correspondante |
| [ecrsppie](ecrsppie.md)           | ecrgspie                   | suppie           | Ecran de suppression de pièces               |
| [ecrspcli](ecrspcli.md)           | ecrgscli                   | supcli           | Ecran de suppression de client               |
| [ecrspfou](ecrspfou.md)           | ecrgsfou                   | supfou           | Ecran de suppression de fournisseur          |
| [ecrspliv](ecrspliv.md)           | ecrgsliv                   | liridliv, fetlivpi, majpie, supliv | Ecran de suppression de livraison      |
| [ecrmjcli](ecrmjcli.md)           | ecrgscli                   | liridcli, majcli | Ecran de mise à jour des informations d'un client |
| [ecrmjfou](ecrmjfou.md)           | ecrgsfou                   | liridfou, majfou | Ecran de mise à jour d'un fournisseur        |
| [ecrmjinf](ecrmjinf.md)           | ecrgspie                   | liridpie, mjinfpie | Ecran de mise à jour des informations d'une pièce |
| [ecrmjliv](ecrmjliv.md)           | ecrgsliv                   | liridliv, majliv, fetlivpi, majpie | Ecran de mise à jour des livraisons     |
| [ecrmjpie](ecrmjpie.md)           | ecrgspie                   | majpie           | Ecran de modifications d'une pièce           |
| [liridcli](liridcli.md)           | ecrrecli, ecrmjcli                    | aucun            | Lecture des informations d'un client par ID        |
| [liridfou](liridfou.md)           | ecrrefou, ecrmjfou                  | aucun            | Lecture des informations d'un fournisseur par ID    |
| [liridliv](liridliv.md)           | ecridliv, ecrspliv, ecrmjliv                    | aucun            | Lecture d'une livraison par ID               |
| [liridpie](liridpie.md)           | ecrajliv, ecrrepie, ecrmjinf                   | aucun            | Lecture des pièces par ID                    |
| [lirnmcli](lirnmcli.md)           | ecrrecli                   | aucun            | Récupération des informations d'un client par nom |
| [lirnmfou](lirnmfou.md)           | ecrrefou                   | aucun            | Récupération des informations d'un fournisseur par nom |
| [lirnmpie](lirnmpie.md)           | ecrrepie                   | aucun            | Récupération des informations d'une pièce par nom |
| [lirpgcli](lirpgcli.md)           | ecrpgcli                   | aucun            | Récupération des informations sur les clients par page |
| [lirpgfou](lirpgfou.md)           | ecrpgfou                   | aucun            | Récupération des informations sur les fournisseurs par page |
| [lirpglog](lirpglog.md)           | ecrpglog                   | aucun            | Récupération des logs                        |
| [lirpgpie](lirpgpie.md)           | ecrpgpie                   | aucun            | Récupération des informations sur les pièces par page |
| [lirpgliv](lirpgliv.md)           | ecrpgliv                   | aucun            | Récupération des informations sur les livraisons par page |
| [liruti](liruti.md)             | ecrcxuti                   | aucun            | Récupération des informations d'un utilisateur par nom   |
| [majcli](majcli.md)             | ecrmjcli                   | aucun            | Mise à jour des informations d'un client     |
| [majfou](majfou.md)             | ecrmjfou                   | ajulog           | Mise à jour des informations d'un fournisseur|
| [majliv](majliv.md)             | ecrmjliv                   | aucun            | Mise à jour du statut de livraison           |
| [majpie](majpie.md)             | ecrspliv, ecrmjliv, ecrmjpie                    | ajulog           | Mise à jour des entrées et sorties des pièces    |
| [mjinfpie](mjinfpie.md)           | ecrmjinf                   | ajulog           | Mise à jour des informations d'une pièce     |
| [supliv](supliv.md)             | ecrspliv                   | ajulog           | Suppression de livraison                     |
| [supcli](supcli.md)             | ecrspcli                   | aucun            | Suppression de client                        |
| [supfou](supfou.md)             | ecrspfou                   | ajulog           | Suppression de fournisseur                   |
| [suppie](suppie.md)             | ecrsppie                   | aucun            | Suppression de pièces                        |
| [verema](verema.md)             | ecrajcli                   | aucun            | Vérification du format de l'email            |



