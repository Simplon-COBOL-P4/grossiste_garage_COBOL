Nom : supfou.cbl

But : Suppression d'un fournisseur par son id

Auteur : Thomas Baudrin

Appelé par : ecrspfou.cbl

Paramètres d’entrée : LK-ID-FOU pour l'id du fournisseur a supprimé

Paramètres de sortie : LK-SUP-RET pour le code retour de la suppression

Fichiers utilisés : supret.cpy pour les codes retours de la suppression, crelog.cbl pour la création de log à la suppression

Traitement : 
1) Initialisation de l'id
2) Exécution de la requête sql pour la suppression
3) Si aucune erreur modification et crétion du log de suppression et code retour mis en WS-SUP-RET-OK
4) Sinon code retour S-SUP-RET-ERR

Codes retour : WS-SUP-RET-OK, WS-SUP-RET-ERR