Nom : ecrajcli.cbl

But : Sous-programme permettant à l'utilisateur de rentrer les paramètres nécessaires à la création d'un client. Il appelle le sous programme verema et ajucli.

Auteur : Thomas Durizot

Appelé par : ecrgscli

Paramètres d’entrée : WS-VLR-RTR (booléen, WS-RTR-OK, WS-RTR-TRO-DE-ARO, WS-RTR-PAS-DE-ARO, WS-RTR-PAS-DE-PNT)

Paramètres de sortie : aucun

Fichiers utilisés : ecrprn.cpy pour le fond de l'écran.  

Traitement :

1. Boucle d'affichage de l'écran S-ECR-AJ-CLI.
2. Evaluation des choix (WS-CHX) de l'utilisateur (créer ou annuler).  
3. Lors de la création de client, vérification de l'email saisi en appelant le sous-programme verema
4. Génération du message de retour selon le code retour VLR-RTR
5. Appel du sous-programme ajucli pour insérer le client dans la table `client` de la base de donnée si l'email est valide