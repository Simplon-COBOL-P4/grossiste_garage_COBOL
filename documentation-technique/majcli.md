Nom : majcli.cbl

But : Le programme met un client dans la base de donnée, on reçoit tous les paramètres nécessaires pour la mise à jour dans la base de donnée.

Auteur : lucas

Appelé par : ecrmjcli.cbl

Paramètres d’entrée : LK-IDN, LK-NOM, LK-EMA, LK-INF, LK-TEL, LK-CP, LK-VI,LK-ADR pour les paramètres d'un client

Paramètres de sortie : 

Fichiers utilisés : 

Traitement : 
1) Initialisation des variables
2) Exécution de la requête sql pour la mise à jour
3) Si aucune erreur exécute le commit
4) Sinon on rollback

Codes retour :