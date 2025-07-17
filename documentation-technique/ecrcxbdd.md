Nom : ecrcxbdd.cbl

But : Ce programme sert à connecter un utilisateur à la base de donnée. 

Auteur : Benoit Zeinati

Appelé par : pntntr.cbl

Paramètres d’entrée : LK-STT

Paramètres de sortie : 

Fichiers utilisés : 

Traitement : Ce programme appel un sous-programme dont le role est de connecter un utilisateur à la base de donnée et d'envoyer' un  code retour au prgramme appelant 'ecrcxbdd.cbl'. Il vérifie ensuite le code retour et affiche un message informatif qui indique si la connexion a réussi ou non, puis transfère le contrôle au programme appelant 'pntnte.cbl'.               

