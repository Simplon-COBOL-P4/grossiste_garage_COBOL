      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * lirpie lis                                                     *
      * Toutes les variables sont à renommer                           *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * LIRE=LIR; PIE=PIECE                                            *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
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
       01 TABLEAU OCCURS 25 TIMES. *> Max quantité.
           05 IDENTIFIANT     PIC 9(10).
           05 NOM             PIC X(80).
           05 QUANTITE        PIC 9(10).
           05 SEUIL           PIC 9(10).
           05 NOM-FOURNISSEUR PIC X(80).

       PROCEDURE DIVISION USING TRI,
                                SENS-TRI,
                                QUANTITE,
                                PAGE-P,
                                TABLEAU.

           EXIT PROGRAM.