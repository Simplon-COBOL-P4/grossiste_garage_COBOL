      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; PG=PAGE; LIV=LIVRAISON;                             *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpgliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Arguments d'entrée.
       77 LK-PAGE                         PIC 9(10).
       77 NOMBRE                          PIC 9(02).
       77 IDENTIFIANT-FOUR-CLIENT-PIECE   PIC 9(10).
       01 FILTRE                          PIC 9(01).
           88 FILTRE-VIDE                           VALUE 0.
           88 FILTRE-FOURNISSEUR                    VALUE 1.
           88 FILTRE-CLIENT                         VALUE 2.
           88 FILTRE-PIECE                          VALUE 3.
      * Arguments de sortie.
       01 TABLEAU.
           05 LIVRAISON OCCURS 25 TIMES.
               10 IDENTIFIANT-LIVRAISON   PIC 9(10).
               10 DATE-LIVRAISON          PIC X(10).
               10 STATUT-LIVRAISON        PIC 9(01).
                   88 STATUT-EN-COURS               VALUE 0.
                   88 STATUS-TERMINE                VALUE 1.
               10 TYPE-LIVRAISON          PIC 9(01).
                   88 TYPE-ENTRANT                  VALUE 0.
                   88 TYPE-SORTANT                  VALUE 1.
               10 IDENTIFIANT-FOUR-CLIENT PIC 9(10).
               10 NOM-FOUR-CLIENT         PIC X(50).
      * Attention à l'ambivalance de cet argument, il peut etre le
      * nombre de variete de pieces dans une livraison, comme le nombre
      * de piece de l'ID demandé dans la livraison. 
               10 QUANTITE-PIECE          PIC 9(10).

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.

           CALL "lirpgliv"
               USING
      * Arguments d'entrée
               LK-PAGE
               NOMBRE
               IDENTIFIANT-FOUR-CLIENT-PIECE
               FILTRE
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               TABLEAU
               WS-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

           EXIT PROGRAM.