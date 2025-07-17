Nom : ecrmjcli.cbl

But : Affiche le menu principal de l’application et permet à l’utilisateur de sélectionner une fonctionnalité parmi plusieurs modules (stock, clients, fournisseurs, etc.), selon son rôle (utilisateur ou administrateur).

Auteur : Yassine

Appelé par :  Programme de démarrage de l'application (après authentification)

Paramètres d’entrée : Aucun

Paramètres de sortie : Aucun

Fichiers utilisés : Aucun

Traitement : 1. Affiche le menu général.

             2. Si l'utilisateur est ADMIN, affiche les options 6 et 7.

             3. Accepte un choix (WS-CHX) :

                1 → appel ecrgspie 
                
                2 → appel ecrgscli 
                
                3 → appel ecrgsfou 
                
                4 → appel ecrgsliv
                
                5 → appel du sous-programme de génération de document.
                
                6 → appel ecrpglog 
                
                7 → appel ecrajuti 
                
                0 → quitte le programme
