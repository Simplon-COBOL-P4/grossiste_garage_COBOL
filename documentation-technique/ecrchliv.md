Nom : ecrchliv.cbl

But : C'est un sous-programme pour choisir quel affichage de livraison, par affichage unique ou la liste complète.

Auteur : Thomas Baudrin

Appelé par : ecrgsliv.cbl

Paramètres d’entrée :

Paramètres de sortie :

Fichiers utilisés : ecrprn.cpy pour l'affichage de l'écran, ecridliv.cbl pour l'écran d'affichage d'une livraison par id, ecrpgliv.cbl pour l'écran d'affichage des livraison par pages 

Traitement : 
1) Affichage de l'écran
2) Boucle jusqu'à la saisi 0 de l'utilisateur
3) Si utilisateur saisi 1 appel de ecridliv
4) Si utilisateur saisi 2 appel de ecrpgliv
5) Sinon affichage erreur

Codes retour :