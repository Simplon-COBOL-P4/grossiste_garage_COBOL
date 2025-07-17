Nom : ajupie.cbl

But : Ce programme ajoute une pièce dans la base de données PostgreSQL.

Il reçoit des informations (nom, quantité, seuil minimum, id du fournisseur), les enregistre dans la BDD, posibilitéde  valide ou annule l'opération.

Auteur : Siboryg

Appelé par : ecrajpie

Paramètres d’entrée : LK-PIE-NOM, LK-PIE-QTE, LK-PIE-MIN, LK-ID-FOU

Paramètres de sortie : LK-AJU-RET

Fichiers utilisés : Aucun

Traitement : 1. Copier les valeurs reçues dans des variables SQL. 

             2. Faire une commande SQL pour insérer la pièce dans la base.

             3. Vérifier si l’opération s’est bien passée :

                - Si oui → enregistrer définitivement (COMMIT) et retourner OK.

                - Si non à cause d’un ID fournisseur invalide** → annuler (ROLLBACK) et retourner une erreur de type clé étrangère.

                - Si autre erreur → annuler (ROLLBACK) et retourner une erreur.

                  LK-AJU-RET-OK → tout s’est bien passé, la pièce est ajoutée.
                 
                  LK-AJU-RET-ERR → un erreur lors de l’ajout. 