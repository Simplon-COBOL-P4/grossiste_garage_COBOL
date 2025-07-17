Nom : majfou.cbl

But : Le programme met un fournisseur dans la base de donnée, on reçoit tous les paramètres nécessaires pour la mise à jour dans la base de donnée.

Auteur : Thomas Baudrin

Appelé par : ecrmjfou.cbl

Paramètres d’entrée : LK-ID, LK-NOM, LK-ADR, LK-VI, LK-CP, LK-INF, LK-TEL,LK-EMA pour les paramètres d'un fournisseur, LK-UTI-ID pour enregistrer le log lié à l'utilisateur

Paramètres de sortie : LK-MAJ-RET pour le code de retour du sous programme

Fichiers utilisés : crelog afin de créer un log à la modification d'un fournisseur

Traitement : 
1) Initialisation des variables
2) Exécution de la requête sql pour la mise à jour
3) Si aucune erreur on créer un log et retourne le code LK-MAJ-RET-OK
4) Sinon on retourne le code LK-MAJ-RET-ERR

Codes retour : LK-MAJ-RET-OK, LK-MAJ-RET-ERR