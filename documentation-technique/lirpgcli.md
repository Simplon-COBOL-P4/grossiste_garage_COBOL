Nom : lirpgcli.cbl

But : Sous-programme permettant récupérer les clients en BDD avec le nombre d'entrée et la page voulu 

Auteur : Thomas Baudrin

Appelé par : ecrpgcli.cbl

Paramètres d’entrée : LK-PAG pour le numéro de la page demandé, LK-NBE pour le nombre d'entrée par page

Paramètres de sortie : LK-TAB-CLI pour récupérer les clients dans un tableau

Fichiers utilisés : Aucun

Traitement : 
1) Initialisation des variables
2) Déclaration du curseur
3) Ouverture du curseur
4) Fetch chaque ligne de la requete et association dans un tableau LK-TAB-CLI dans une boucle s'arretant à l'index égal à LK-NBE
5) Fermeture du curseur

Codes retour : LIR-RET-OK, LIR-RET-ERR