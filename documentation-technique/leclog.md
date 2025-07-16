Nom : leclog.cbl

But : Sous-programme permettant récupérer les logs en BDD 

Auteur : Thomas Baudrin

Appelé par : ecrlog

Paramètres d’entrée : 

Paramètres de sortie : LK-LOG-TAB LK-MAX-LIN

Fichiers utilisés : Aucun

Traitement : 1) Initialisation des variables
             2) Déclaration du curseur
             3) Ouverture du curseur
             4) Fetch chaque ligne de la requete et association dans un tableau
             5) Fermeture du curseur

Codes retour : LIR-RET-OK, LIR-RET-ERR