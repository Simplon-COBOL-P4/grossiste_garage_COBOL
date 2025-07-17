Nom : ecrajuti.cbl

But : Sous-programme affichant un écran permettant de saisir les informations nécessaires à la création d'un utilisateur. Il appelle ensuite un sous-programme qui crée un utilisateur dans la base de données.

Auteur : Thomas Durizot

Appelé par : ecrmnprn.cbl

Paramètres d’entrée : Aucun

Paramètres de sortie : Aucun

Fichiers utilisés : ecrpn.cpy pour le fond de l'écran, ajuret.cpy pour récupérer le code retour, utiglb.cpy pour les informations de l'utilisateur connecté.

Traitement :

1. Boucle d'affichage de l'écran S-ECR-CRE-UTI.
2. Evaluation des choix de l'utilisateur (créer ou annuler).  
3. Confirmation du mot de passe saisi lors de la création. 
4. Appel du sous-programme [ajuuti](ajuuti.md) pour l'insertion de l'utilisateur créé dans la base de données. 
5. Affichage de messages de retour selon les codes retour : AJU-RET-OK, AJU-RET-ERR.