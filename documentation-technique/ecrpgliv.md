Nom : ecrpgliv.cbl

But : Ecran d'affichage des livraisons par page et par filtre 

Auteur : Thomas Baudrin

Appelé par : ecrgsliv.cbl

Paramètres d’entrée : Aucun

Paramètres de sortie : Aucun

Fichiers utilisés : ecrpn pour l'écran, lirpgliv pour récupérer les livraisons par page

Traitement : 
1) Affichage de l'écran
2) Sélection du filtre
3) Accept de l'écran
4) Boucle jusqu'à ce que l'utilisateur quitte le programme
5) Appel du sous programme lirpgliv afin de récupérer les livraisons selon les différents paramètre
6) Réinitialisation de l'écran
7) Affichage ligne par ligne des résultats obtenus selon le filtre
8) Si erreur il y a eu affichage d'un message d'erreur et retour au menu

Codes retour : LIR-RET-OK, LIR-RET-ERR