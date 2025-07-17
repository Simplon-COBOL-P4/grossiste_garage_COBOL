Nom : ecrchpie.cbl

But : Ce sous-programme permet d’afficher un menu interactifà l’utilisateur afin qu’il choisisse :  d’afficher une seule pièce d’afficher a liste complète des pièces retourner au menu principal

Auteur : Siboryg

Appelé par : ecrgspie

Paramètres d’entrée : Aucun

Paramètres de sortie : Aucun

Fichiers utilisés : Aucun

Traitement : 1. Affichage du menu de choix à l’écran (S-ECR-CHX-PIE)  

             2. Lecture de l’entrée utilisateur (ACCEPT WS-CHX)

             3. Évaluation du choix (EVALUATE) :

                1 → Appel du sous-programme ecrrepie (affichage d'une seule pièce)

                2 → Appel du sous-programme ecrpgpie (liste complète des pièces)

                0 → Retour au menu (sortie de boucle)
             