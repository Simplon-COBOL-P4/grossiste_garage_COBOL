Nom : liridfou.cbl

But : Sous programme lisant un fournisseur par l'id

Auteur : Thomas Baudrin

Appelé par : ecrrefou.cbl

Paramètres d’entrée : LK-ID pour rechercher le fournisseur

Paramètres de sortie : LK-NOM, LK-ADR, LK-VIL, LK-CP, LK-IND, LK-TEL,LK-EMA pour les paramètres d'un fournisseur, LK-LIR-RET pour le paramètre de retour

Fichiers utilisés : lirret pour les code de retour de lecture

Traitement : 
1) Initialisation de l'id
2) Exécution de la requête SELECT
3) Association des résultats à chaque argument de sortie
4) Association du code retour selon la réussite ou l'erreur

Codes retour : LIR-RET-OK, LIR-RET-ERR