Nom : ajufou.cbl

But : Sous-programme permettant d'ajouter un fournisseur à la BDD

Auteur : Anaisktl

Appelé par : ecrajfou

Paramètres d’entrée : LK-NOM LK-ADR LK-VIL LK-CDP LK-IND LK-TEL LK-EML

Paramètres de sortie : LK-AJU-RET-OK LK-AJU-RET-ERR

Fichiers utilisés : ajuret.cpy

Traitement :
1) Initialisation des variables 
2) Déplacement des variables de la LINKAGE SECTION dans la WORKING-STORAGE SECTION.
3) Réquête SQL pour insérer les données dans la BDD

Codes retour : LK-AJU-RET-OK LK-AJU-RET-ERR