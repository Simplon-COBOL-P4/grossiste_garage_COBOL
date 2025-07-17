Nom : ajuuti.cbl

But : Sous-programme prenant en argument les informations nécessaires à la création d'un utilisateur dans la base de données.

Auteur : Thomas Durizot

Appelé par : ecrajuti.cbl

Paramètres d’entrée : LK-NOM-UTI, LK-MDP-UTI, LK-ROL-UTI, LK-AJU-RET

Paramètres de sortie : LK-AJU-RET

Fichiers utilisés : ajuret.cpy pour récupérer le code retour.  

Traitement :

1. Affectation des variables PG-NOM-UTI, PG-MDP-UTI, PG-ROL-UTI à utiliser dans la requête SQL avec les arguments d'entrée correspondant.
2. Insertion des valeurs reçues dans la table `utilisateur` de la base de données.  
3. COMMIT ou ROLLBACK de la requête SQL selon le code retour AJU-RET-OK ou AJU-RET-ERR.