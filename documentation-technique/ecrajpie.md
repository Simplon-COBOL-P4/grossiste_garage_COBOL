Nom : ajupie.cbl

But : Ce programme permet d’ajouter une nouvelle pièce dans la base de données.

Auteur : Siboryg

Appelé par : ecragspie

Paramètres d’entrée : LK-PIE-NOM : nom de la pièce

                      LK-PIE-QTE : quantité

                      LK-PIE-MIN : seuil minimum 

                      LK-ID-FOU : identifiant du fournisseur 

Paramètres de sortie : LK-AJU-RET : code retour 

Fichiers utilisés : Aucun

Traitement : 1. Affiche un écran avec les champs à remplir.

             2. Attend la saisie des données par l’utilisateur.

             3. Vérifie que la quantité, le seuil minimum, et l’ID fournisseur sont bien des nombres.

             4. Si les données sont valides, appelle le sous-programme ajupie pour insérer la pièce dans la base.

             5. Affiche un message selon le résultat (succès, erreur SQL, erreur fournisseur).

             6. Si les données sont invalides, affiche un message d’erreur.

             7. Permet de quitter le formulaire à tout moment.