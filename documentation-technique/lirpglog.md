Nom : lirpglog.cbl

But : Sous-programme permettant récupérer les logs en BDD 

Auteur : Thomas Baudrin

Appelé par : ecrlog

Paramètres d’entrée : 

Paramètres de sortie : LK-LOG-TAB pour le tableau des logs, LK-MAX-LIN le nombre de lignes reçus

Fichiers utilisés : Aucun

Traitement : 
1) Initialisation des variables
2) Déclaration du curseur
3) Ouverture du curseur
4) Fetch chaque ligne de la requete et association dans un tableau LK-LOG-TAB
5) Association de LK-MAX-LIN à la fin des requêtes.
6) Fermeture du curseur

Codes retour : LIR-RET-OK, LIR-RET-ERR