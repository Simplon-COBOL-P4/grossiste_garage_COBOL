Nom : liridcli.cbl

But : Lire un client dans la base de données PostgreSQL à partir de son identifiant (ID) et renvoyer les informations du client via la LINKAGE SECTION.

Auteur : Yassine

Appelé par : ecrcli, ecrmjcli

Paramètres d’entrée : LK-IDT-CLI

Paramètres de sortie : LK-NOM-CLI, LK-EML-CLI, LK-IND-CLI, LK-TEL-CLI, LK-CP-CLI, LK-VIL-CLI, LK-ADR-CLI

Fichiers utilisés : Aucun

Traitement :1. Copier l’identifiant reçu en paramètre dans WS-IDT-CLI.

            2. Effectuer une requête SQL SELECT sur la table (client) pour retrouver le client correspondant.

            3. Si (SQLCODE = 0) (succès), transférer les résultats dans les variables de sortie de la LINKAGE SECTION.

            Codes retour : LIR-RET-OK, LIR-RET-ERR