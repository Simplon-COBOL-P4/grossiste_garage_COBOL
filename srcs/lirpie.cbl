      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * lirpie lis la database pour récupèrer les pièces et fournisseur*
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * LIRE=LIR; PIE=PIECE                                            *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpie.
       AUTHOR. lucas.
       DATE-WRITTEN. 26-06-25 (fr).

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-TRI                 PIC 9(01).
           88 LK-TRI-NOM                   VALUE 0.
           88 LK-TRI-QUANTITE              VALUE 1.
           88 LK-TRI-FOURNISSEUR           VALUE 2.
       
       01 LK-SENS-TRI            PIC 9(01).
           88 LK-ASCENDANT                 VALUE 0.
           88 LK-DESCENDANT                VALUE 1.

       01 LK-QUANTITE            PIC 9(02). *> Min 1 - Max 25.

       01 LK-PAGE-P              PIC 9(10). *> Min 0 - Max 1,000,000,000.

      * Arguments de sortie.
       01 LK-TABLEAU. 
           05 LK-TABLEAU-ARGUMENT OCCURS 25 TIMES. *> Max quantité.
              10 LK-IDENTIFIANT       PIC 9(10).
              10 LK-NOM               PIC X(80).
              10 LK-T-QUANTITE        PIC 9(10).
              10 LK-SEUIL             PIC 9(10).
              10 LK-NOM-FOURNISSEUR   PIC X(80).

       PROCEDURE DIVISION USING LK-TRI,
                                LK-SENS-TRI,
                                LK-QUANTITE,
                                LK-PAGE-P,
                                LK-TABLEAU.


           EXEC SQL
                CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
           END-EXEC.

           EXIT PROGRAM.