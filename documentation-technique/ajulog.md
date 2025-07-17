Nom : ajulog.cbl

But : Sous-programme permettant d'insérer les informations de la création d'un log dans la table associée.

Auteur : Anaisktl

Appelé par : ajuliv, ecrcxuti, majfou, majpie,supliv, mjinfpie, supfou

Paramètres d’entrée : LK-DTL-LG LK-TYP-LG LK-UTI-ID

Paramètres de sortie : LK-AJU-RET-OK LK-AJU-RET-ERR

Fichiers utilisés : Aucun

Traitement :
1) Initialisation des variables 
2) Déplacement des variables de la LINKAGE SECTION dans la WORKING-STORAGE SECTION
3) Réquête SQL pour insérer les données dans la BDD  

Codes retour : LK-AJU-RET-OK LK-AJU-RET-ERR