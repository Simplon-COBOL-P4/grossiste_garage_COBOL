Nom : ecrspliv.cbl

But : Programme d'affichage de l'écran permettant la suppression.

Auteur : Thomas Baudrin

Appelé par : ecrgsliv.cbl

Paramètres d’entrée :

Paramètres de sortie :

Fichiers utilisés : ecrprn.cpy pour l'affichage de l'écran, lirret.cpy pour les codes retour de lecture, supret.cpy pour le code retour de suppression, liridliv.cbl pour lire livraison par id, fetlivpie.cbl pour récupérer l'id d'une pièce et sa quantité, majpie pour mettre à jour la quantité de pièce, supliv pour supprimer les livraisons 

Traitement : 
1) Affichage de l'écran
2) Boucle jusqu'à la saisi 0 de l'utilisateur
3) Si utilisateur saisi 1 appel de liridliv pour récupérer le statut et type de la livraison
4) Si le statut est terminé on ne le supprime pas
5) Si le statut est en cours et qu'il est de tye sortante on va chercher l'id de la pièce et sa quantité via fetlivpi.cbl puis si tout est bon on met à jour le stock de la pièce via majpie.cbl
6) Puis on supprime la livraison par son id via supliv.cbl
7) Si l'utilisateur a saisi une autre valeur que 1 ou zero affichage d'erreur

Codes retour : WS-LIR-RET-OK, WS-LIR-RET-ERR, WS-SUP-RET-OK, WS-SUP-RET-ERR