      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; PG=PAGE; FOU=FOURNISSEUR;                           *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpgfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Arguments d'entrée.
       77 LK-PAGE                         PIC 9(02).
       77 NOMBRE                          PIC 9(02).
      * Arguments de sortie.
       01 TABLEAU.
           05 FOURNISSEUR OCCURS 25 TIMES.
               10 NOM                     PIC X(50).
               10 ADRESSE                 PIC X(50).
               10 VILLE                   PIC X(50).
               10 CODE-POSTAL             PIC 9(05).
               10 INDICATIF               PIC 9(03).
               10 TELEPHONE               PIC 9(10).
               10 EMAIL                   PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.

           CALL "lirpgfou"
               USING
      * Arguments d'entrée
               LK-PAGE
               NOMBRE
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               TABLEAU
               LK-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

           EXIT PROGRAM.