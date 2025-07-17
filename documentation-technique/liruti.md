Nom : liruti.cbl

But : Sous-programme permettant de prendre en argument le nom d’un utilisateur et de retourner ses données.

Auteur : Anaisktl

Appelé par : ecrcxuti

Paramètres d’entrée : LK-NOM-UTL

Paramètres de sortie : LK-MDP-UTL LK-RLE-UTL LK-ID-UTL

Fichiers utilisés : lirret.cpy

Traitement :
1) Initialisation des variables 
2) Réquête SQL pour retouner les données 
3) Déplacement des variables de la WORKING-STORAGE SECTION dans la LINKAGE SECTION.

Codes retour : LK-LIR-RET-OK LK-LIR-RET-ERR