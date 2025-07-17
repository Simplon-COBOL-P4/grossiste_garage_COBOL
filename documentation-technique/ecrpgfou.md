Nom : ecrpgfou.cbl

But : Ce programme permet d'afficher une liste de fournisseurs selon le numéro de page saisi. 

Auteur : Benoit Zeinati

Appelé par : ecrchfou.cbl

Paramètres d’entrée : 

Paramètres de sortie : 

Fichiers utilisés : Aucun

Traitement : Ce programme appel le programme 'lirpgfou.cbl' en incluant deux paramètres, le numéro de page (WS-PGE) et le nombre de lignes d'affichage (WS-QTE). Lors du retour au programme 'ecrpgfou.cbl', les données à afficher se trouve dans le tableau WS-TBL à condition que le code retour soit égal à zero. Si c'et le cas, les informations fournisseur dans le tableau WS-TBL s'afficheront.

