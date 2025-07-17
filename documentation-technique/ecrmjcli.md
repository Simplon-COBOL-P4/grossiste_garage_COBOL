Nom : ecrmjcli.cbl

But : Ce programme permet à un administrateur de rechercher un client par son identifiant, d’afficher ses informations, puis les modification et les valider.

Auteur : Yassine

Appelé par : ecrgscli

Soue-programme appelé : liridcli, majcli 

Paramètres d’entrée : Aucun

Paramètres de sortie : LK-NOM-CLI, LK-EML-CLI, LK-IND-CLI, LK-TEL-CLI, LK-CP-CLI, LK-VIL-CLI, LK-ADR-CLI

Fichiers utilisés : Aucun

Traitement : 1. Affiche l’écran de recherche client (S-ECR-CLI)

             2. Accepte l’identifiant du client et le choix de recherche

             3. Appelle liridcli pour récupérer les données du client

             4. Affiche l’écran de confirmation des informations (S-ECR-AFG)

             4. Si validation via choix = "1", appelle majcli pour modifier le client

             5. Sinon, fin du programme