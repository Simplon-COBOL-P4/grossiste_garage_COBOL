Nom : ecrpglog.cbl

But : Sous-programme permettant d'appeler un sous programme pour récupérer les logs en BDD de les afficher  

Auteur : Thomas Baudrin

Appelé par : ecradm.cbl

Paramètres d’entrée : Aucun

Paramètres de sortie : Aucun

Fichiers utilisés : ecrpn pour l'écran, leclog pour récupérer les logs

Traitement : 
1) Récupération des logs en BDD dans le tableau WS-LOG-TAB via l'appel leclog.cbl
2) Affichage de l'écran
3) Boucle sur le tableau WS-LOG-TAB permettant l'affichage des logs ligne par ligne
4) Accept d'une variable pour quiter l'écran

Codes retour : LIR-RET-OK, LIR-RET-ERR