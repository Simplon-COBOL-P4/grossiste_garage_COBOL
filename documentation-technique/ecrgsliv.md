Nom : ecrgsliv.cbl

But : permet de choisir l’action à effectuer vis-à-vis des livraisons. Il affiche des lignes différentes en fonction de l’argument principal (Role), car ce n’est pas les mêmes options selon si c'est un utilisateur 'STANDARD', ou 'ADMIN'.    

Auteur : Benoit Zeinati

Appelé par : ecrmnprn.cbl

Paramètres d’entrée : LK-ROL

Paramètres de sortie : 

Fichiers utilisés : Aucun

Traitement : Le programme propose 4 choix  
1 - Ajouter une livraison  
2 - Afficher une livraison  
3 - Modifier une livraison (résérvé à l'administrateur)  
4 - Supprimer une livraison (résérvé à l'administrateur)   
0 - Retour au menu  
En fonction du choix saisi, le programme correspondant est appelé:
Choix  Programme appelé
-----  ----------------
1      ecrajliv.cbl
2      ecrchliv.cbl
3      ecrmjliv.cbl
4      ecrspliv.cbl
0      Retour auprogramme appelant ecrmnprn.cbl

Codes retour : 