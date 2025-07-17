Nom : liridliv.cbl

But : Lire une livraison à partir de son identifiant, retourner ses informations principales : date, statut (en cours / terminée), type (entrée / sortie), identifiant et nom du fournisseur ou client selon le type.

Auteur : Yassine

Appelé par : ecridliv, ecrmjliv, ecrspliv

Paramètres d’entrée : LK-IDT-LIV

Paramètres de sortie : LK-IDT-LIV, LK-DAT-LIV, LK-STA-LIV, LK-TYP-LIV, LK-IDT-SOR, LK-NOM-SOR, LK-LIR-RET

Fichiers utilisés : Connexion à base de données via SQL Embedded. Tables utilisées : livraison, fournisseur, client

Traitement : 1. Copier l’identifiant de livraison reçu en paramètre.

             2. Rechercher dans la table livraison les informations de la livraison (date, statut, type).

             3. Si trouvée : Déterminer le statut (en cours / terminée) via la colonne statut_liv.

             4. Si aucun livraison n’est trouvé ou en cas d’erreur, retourner un code d’erreur via LK-LIR-RET.
             
                Codes retour : LIR-RET-OK, LIR-RET-ERR