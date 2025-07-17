Nom : lirnmcli.cbl

But : Lire un client dans la base de données PostgreSQL à partir de son nom et renvoyer les informations du client via la LINKAGE SECTION.

Auteur : Yassine

Appelé par : ecrrepie

Paramètres d’entrée : LK-NOM-CLI 

Paramètres de sortie : LK-IDT-CLI, LK-EML-CLI, LK-IND-CLI, LK-TEL-CLI, LK-CP-CLI, LK-VIL-CLI, LK-ADR-CLI

Fichiers utilisés : Aucun

Traitement : 1. Copier le nom reçu en paramètre dans WS-NOM-CLI.

             2. Effectuer une requête SQL SELECT sur la table (client) pour retrouver le client correspondant.

             3. Si SQLCODE = 0 (succès), transférer les résultats dans les variables de sortie de la LINKAGE SECTION.

                Codes retour : LIR-RET-OK, LIR-RET-ERR