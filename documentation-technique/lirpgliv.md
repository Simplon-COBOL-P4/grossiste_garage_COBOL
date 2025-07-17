Nom : lirpgliv.cbl

But : Sous-programme récupérant les livraisons par page et les retourne au programme appelant. Il est possible d'afficher différentes informations à l'aide de filtres.

Auteur : Thomas Durizot

Appelé par : ecrpgliv

Paramètres d’entrée : LK-PGE, LK-NBR-ELM, LK-IDF-FOU-CLI-PIE, LK-FIL (booléen : LK-FIL-VID, LK-FIL-FOU, LK-FIL-CLI, LK-FIL-PIE)

Paramètres de sortie : LK-TAB 

Fichiers utilisés : lirret.cpy pour récupérer le code retour.  

Traitement :

1. Affectation de la variable PG-IDF-FOU-CLI-PIE correspondant à l'ID saisi à l'écran.
2. Récupération de l'offset et du nombre d'éléments à afficher.
3. Evaluation du choix de filtre (aucun filtre, fournisseur, client, pièces).
4. Requêtes SQL (utilisation de CURSOR et de FETCH) afin de récupérer les informations correspondant au filtre sélectionné