Nom : ajuliv.cbl

But : Sous-programme qui ajoute une livraison à la base de données

Auteur : Lucas Jourdain

Appelé par : ecrajliv 

Paramètres d’entrée : LK-DAT-DEB, LK-DAT-FIN, LK-STA, LK-TYP, LK-IDN

Paramètres de sortie : Aucun

Fichiers utilisés : aucun

Traitement : 
1. on commence par move les paramètres de la linkage dans la working
2. on insère les données via une requête SQL
3. si cela réussi, on créer un log

Codes retour : LK-AJU-RET