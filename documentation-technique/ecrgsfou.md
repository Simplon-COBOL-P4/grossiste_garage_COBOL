Nom : ecrgsfou.cbl

But : permet de choisir l’action à effectuer vis-à-vis des fournisseur. Il affiche des lignes différentes en fonction de l’argument principal (Role), car ce n’est pas les mêmes options selon si c'est un utilisateur 'STANDARD', ou 'ADMIN'.    

Auteur : Benoit Zeinati

Appelé par : ecrmnprn.cbl

Paramètres d’entrée : LK-ROL

Paramètres de sortie : 

Fichiers utilisés : Aucun

Traitement : Le programme propose 4 choix  
1 - Ajouter un fournisseur  
2 - Afficher un fournisseur  
3 - Modifier un fournisseur (résérvé à l'administrateur)  
4 - Supprimer un fournisseur (résérvé à l'administrateur)   
0 - Retour au menu  
En fonction du choix saisi, le programme correspondant est appelé:
Choix  Programme appelé
-----  ----------------
1      ecrajfou.cbl
2      ecrchfou.cbl
3      ecrmjfou.cbl
4      ecrspfou.cbl
0      Retour auprogramme appelant ecrmnprn.cbl

