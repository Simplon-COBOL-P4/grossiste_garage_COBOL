Nom : liridpie.cbl

But : Lire une pièce depuis la base de données PostgreSQL à partir de son identifiant (ID) et retourner ses informations (nom, quantité, seuil, fournisseur) via la LINKAGE SECTION.

Auteur : Yassine

Appelé par : ecrmjinf, ecrrepie

Paramètres d’entrée : LK-ID-PIE

Paramètres de sortie : LK-NOM-PIE, LK-QNT-PIE, LK-SEU-PIE, LK-ID-FOR, LK-NOM-FOR 

Fichiers utilisés :  Aucun 

Traitement : 1. Copier l’identifiant de la pièce (LK-ID-PIE) vers PG-ID-PIE.

             2. Exécuter une requête SQL SELECT avec JOIN entre les tables piece et fournisseur.

             3. Si SQLCODE = 0, transférer les données récupérées dans les variables de la LINKAGE SECTION. 