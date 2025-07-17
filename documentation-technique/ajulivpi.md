Nom : ajulivpi.cbl

But : Sous-programme prend en paramètre les données nécessaires à l’insertion d’une livraison_piece.

Auteur : Anaisktl

Appelé par : ecrajliv

Paramètres d’entrée : LK-IDF-LIV LK-IDF-PI LK-QTE-PI

Paramètres de sortie : LK-AJU-RET-OK LK-AJU-RET-ERR

Fichiers utilisés : ajuret.cpy

Traitement :
1) Initialisation des variables 
2) Déplacement des variables de la LINKAGE SECTION dans la WORKING-STORAGE SECTION.
3) Réquête SQL pour insérer les données dans la BDD  

Codes retour : LK-AJU-RET-OK LK-AJU-RET-ERR