Nom : ecrmjpie.cbl

But : Ce programme supprime une pièce du fichier 'piéce'

Auteur : Benoit Zeinati

Appelé par : ecrsuppie.cbl

Paramètres d’entrée : LK-ID-PIE

Paramètres de sortie : LK-SUP-RET

Fichiers utilisés : pièce

Traitement :  L'identité du pièce à supprimer est délivré par le programme appelant. Ensuite la requette SQL 'delete' est exécuté pour supprimer la pièce et le code retour est renvoyé au programme applant.                            

