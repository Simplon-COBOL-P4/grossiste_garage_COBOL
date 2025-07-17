Nom : ecrchcli.cbl

But : Afficher un écran pour permettre à l'utilisateur de choisir comment lire les clients :

soit un seul client (par ID ou nom), soit toute la liste, affichée page par page.

Auteur : lucas

Appelé par : ecrgscli

Paramètres d’entrée : Aucun

Paramètres de sortie : Aucun

Fichiers utilisés : Aucun

Traitement : 1. Affiche un écran d’accueil avec trois choix possibles :

                1 → voir un client,

                2 → voir la liste complète des clients,

                0 → retour au menu.

             2. L’utilisateur saisit son choix dans un champ prévu à cet effet (WS-CON).

             3. Le programme répète l’affichage jusqu’à ce que l’utilisateur tape 0 (retour au menu).

             4. En fonction du choix :

                Si 1 → appel du sous-programme ecrrecli pour lire un client,

                Si 2 → appel du sous-programme ecrpgcli pour afficher tous les clients,


