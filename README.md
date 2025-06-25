# grossiste_garage_COBOL
## Guide de développement
Avant d'utiliser le projet, utiliser la commande `make install`, cela créera la structure du repo si elle n'existe pas déjà, et copiera la convention de commit dans le .git.<br>
Tous les fichiers sources (.cbl), doivent être placés dans le dossier `srcs/`, des sous-dossiers peuvent être créés au besoin, ils seront pris en compte par le Makefile.<br>
Pour compiler ET lancer le programme, une seule commande est nécessaire : `make`. <br>
Il est totalement possible de copier le Makefile dans un autre dossier, et de s'en servir à part du reste du code, pour effectuer des tests/développer plus efficacement.

Si la commande `make` n'existe pas, l'installer avec apt : `sudo apt install make`,