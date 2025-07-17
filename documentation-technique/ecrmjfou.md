Nom : ecrmjfou.cbl

But : Ce programme permet la mise à jour d'un fournisseur.

Auteur : Benoit Zeinati

Appelé par : ecrgsfou.cbl

Paramètres d’entrée :  
               WS-NOM-FOU
               WS-ADR-FOU
               WS-VIL-FOU
               WS-CDP-FOU
               WS-ITL-FOU
               WS-TEL-FOU
               WS-EML-FOU
               WS-LIR-RET

Paramètres de sortie :  WS-IDT-FOU-ARG

Fichiers utilisés : Aucun

Traitement : Ce programme appel le programme 'liridfou.cbl' en incluant l'id du fournisseur WS-IDT-FOU-ARG comme paramètre. Le programme 'liridfou.cbl' renvoie les informations du fournisseur à condition que le code retour soit égal à zero. Une fois la mise à jour terminée et confirmée, le programme 'majfou.cbl' est appelé pour sauvgarder la mise à jour dans la base de donnée fournisseur.

