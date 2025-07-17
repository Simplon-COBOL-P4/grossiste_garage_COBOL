Nom : lirpgfou.cbl

But : Sous-programme qui récupère les fournisseurs par pages et les renvoie au programme appelant

Auteur : Lucas Jourdain

Appelé par : ecrpgfou

Paramètres d’entrée : LK-PG, LK-NB

Paramètres de sortie : LK-TAB

Fichiers utilisés : aucun

Traitement : 
1. on commence par calculer l'offet pour la requête SQL
2. on réalise la requête en pensant à utiliser un curseur
3. on déplace les données du curseur dans un tableau
4. on renvoie le tableau au programme appelant

Codes retour : LK-LIR-RET