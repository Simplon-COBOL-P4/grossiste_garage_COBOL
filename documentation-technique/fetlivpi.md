Nom : fetlivpi.cbl

But : Programme pour recupérer les id pièces et leur quantités associés liès à une livraison ligne par ligne

Auteur : Thomas Baudrin

Appelé par : ecrspliv.cbl

Paramètres d’entrée : LK-ID-LIV pour l'id de la livraison

Paramètres de sortie : LK-ID-PIE pour l'id de la pièce, LK-QTE pour la quantité de pièce présent dans la livraison, LK-ETA-LEC pour l'etat de la lecture si elle est ouverte ou fermé

Fichiers utilisés : 

Traitement : 
1) Si le curseur est fermé, déclaration du curseur et ouverture de celui ci
2) Ensuite exécution du fetch avec le curseur afin de récupérer une ligne de la requête
3) Si l'exécution de sql est correcte association des LK-ID-PIE, LK-QTE et LK-ETA-LEC-OK
4) Sinon LK-ETA-LEC-ERR et fermeture du curseur

Codes retour :