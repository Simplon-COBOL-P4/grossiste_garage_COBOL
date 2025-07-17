Nom : ecrgspie.cbl

But : Ce programme affiche le menu de gestion des pièces pour tous les utilisateurs, avec des options supplémentaires si l’utilisateur est un administrateur (G-UTI-RLE = "ADMIN").

Auteur : Yassine

Appelé par : ecrmnprn

Paramètres d’entrée : WS-CHX-MNU

Paramètres de sortie : Aucun

Fichiers utilisés : Aucun

Traitement : 1. Affiche l’écran de menu de gestion des pièces

             2. Si l’utilisateur est administrateur (G-UTI-RLE = "ADMIN"), les options 4 et 5 sont aussi affichées

             3. Accepte le choix utilisateur

             4. Redirige vers les sous-programmes suivants selon le choix :

                1 → ecrajpie : Ajouter une pièce
                
                2 → ecrchpie : Afficher une pièce
                
                3 → ecrmjinf : Modifier une pièce
                
                4 → ecrsppie : Supprimer une pièce (admin uniquement)
                
                5 → ecrmjpie : Ajouter entrée/sortie (admin uniquement)
                
                0 → Sortie du programme 



    