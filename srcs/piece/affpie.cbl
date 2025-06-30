      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AFF=AFFICHER; PIE=PIECE;                                       *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. affpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TRI                 PIC 9(01).
           88 TRI-NOM                   VALUE 0.
           88 TRI-QUANTITE              VALUE 1.
           88 TRI-FOURNISSEUR           VALUE 2.
       
       01 SENS-TRI            PIC 9(01).
           88 ASCENDANT                 VALUE 0.
           88 DESCENDANT                VALUE 1.

       01 QUANTITE            PIC 9(02). *> Min 1 - Max 25.

       01 PAGE-P              PIC 9(10). *> Min 0 - Max 1,000,000,000.

      * Arguments de sortie.
       01 TABLEAU 
           05 PIECE OCCURS 25 TIMES. *> Max quantité.
               10 IDENTIFIANT     PIC 9(10).
               10 NOM             PIC X(80).
               10 QUANTITE        PIC 9(10).
               10 SEUIL           PIC 9(10).
               10 NOM-FOURNISSEUR PIC X(80).

       PROCEDURE DIVISION.
           
           CALL "lirpie"
               USING
               TRI,
               SENS-TRI,
               QUANTITE,
               PAGE-P,
               TABLEAU
           END-CALL.

           EXIT PROGRAM.
           