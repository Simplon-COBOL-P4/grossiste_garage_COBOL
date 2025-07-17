Nom : majpie.cbl

But : Sous-programme gérant les entrées et sorties de pièces dans le stock. Il prend en argument l'ID de la pièce, la quantité à ajouter/retirer et le mode de changement (Ajout/Retrait). Il appelle ensuite le sous-programme ajulog pour la création d'un log dans la base de données.

Auteur : Thomas Durizot

Appelé par : ecrspliv, ecrmjliv, ecrmjpie

Paramètres d’entrée : LK-IDF-PIE, LK-QTE-PIE, LK-TYP-CHG (booléen avec LK-AJT ou LK-RTI), LK-MAJ-RET

Paramètres de sortie : LK-MAJ-RET

Fichiers utilisés : majret.cpy pour récupérer le code retour.  

Traitement :

1. Affectation des variables PG-IDF-PIE, PG-QTE-PIE à utiliser dans la requête SQL avec les arguments d'entrée correspondants.
2. Branche conditionnelle sur le type de changement à effectuer sur les stocks (ajout si LK-AJT/retrait si LK-RTI).  
3. Requêtes (UPDATE) SQL contenant les opérations à effectuer sur la quantité en stock de la pièce sélectionnée selon le type de changement.
4. Génération du message de log selon l'opération effectuée
5. Appel du sous-programme ajulog pour l'insertion du log dans la base de données