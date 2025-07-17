Nom : ecrrefou.cbl

But : Ce programme permet à l’utilisateur de saisir soit l’identifiant (ID), soit le nom d’un fournisseur pour rechercher ses informations dans la base de données et les afficher à l’écran.

Auteur : Yassine

Appelé par : ecrmnprn

Paramètres d’entrée : Aucun

Paramètres de sortie : LK-NOM-CLI, LK-EML-CLI, LK-IND-CLI, LK-TEL-CLI, LK-CP-CLI, LK-VIL-CLI, LK-ADR-CLI

Fichiers utilisés : Aucun

Traitement : 1. Affiche l’écran principal (S-ECR-RE-FOU) avec le champ de saisie de l’ID ou du nom.

             2. Attend la saisie de l’utilisateur.
   
             3. Évalue le choix (WS-CHX-UTL) :

                Si 1 → effectue une recherche :

                       Si la saisie est numérique → appelle liridfou avec l’ID.

                       Sinon → appelle lirnmfou avec le nom.

             4. Affiche les informations du fournisseur via l’écran S-ECR-AFF.

             5. Si 0 → quitte le programme.

             6. Codes retour (dans WS-LIR-RET) : LIR-RET-OK : lecture réussie
                                
                                                 LIR-RET-ERR : erreur lors de la lecture ou fournisseur introuvable