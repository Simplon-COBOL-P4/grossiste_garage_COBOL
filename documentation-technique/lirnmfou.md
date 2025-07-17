Nom : lirnmfou.cbl

But : Lire un fournisseur dans la base de données PostgreSQL à partir de son nom et renvoyer toutes les informations le concernant via la LINKAGE SECTION.

Auteur : Yassine

Appelé par : ecrrefou

Paramètres d’entrée : LK-NOM-FOU

Paramètres de sortie : LK-IDT-FOU, LK-ADR-FOU, LK-VIL-FOU, LK-CP-FOU :LK-IND-FOU, LK-TEL-FOU, LK-EML-FOU

Fichiers utilisés : Aucun

Traitement : 1. Copier le nom du fournisseur reçu en LK-NOM-FOU vers la variable SQL PG-NOM-FOU

             2. Exécuter une requête SQL SELECT sur la table fournisseur où nom_fou = PG-NOM-FOU

             3. Si le fournisseur est trouvé (SQLCODE = 0), transférer les champs récupérés vers les variables de sortie de la LINKAGE SECTION

             4. Si aucun fournisseur n’est trouvé ou en cas d’erreur, retourner un code d’erreur via LK-LIR-RET.
             
                Codes retour : LIR-RET-OK, LIR-RET-ERR