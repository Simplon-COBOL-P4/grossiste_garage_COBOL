Nom : lirnmpie.cbl

But : Lire une pièce depuis la base de données PostgreSQL à partir de son nom (nom_pie) et retourner toutes ses informations (ID, quantité, seuil, fournisseur) via la LINKAGE SECTION..

Auteur : Yassine

Appelé par : ecrrepie

Paramètres d’entrée : LK-NOM-PIE

Paramètres de sortie : LK-ID-PIE, LK-QNT-PIE, LK-SEU-PIE, LK-ID-FOR, LK-NOM-FOR

Fichiers utilisés : Aucun

Traitement : 1. Copier le nom de la pièce (LK-NOM-PIE) vers la variable SQL PG-NOM-PIE.

             2. Effectuer une requête SQL SELECT pour chercher une pièce par son nom dans la base, avec jointure sur le fournisseur.

             3. Si SQLCODE = 0, copier les données retournées dans les variables de la LINKAGE SECTION. 
                   