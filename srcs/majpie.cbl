      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * majpie                                                         *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * MISE À JOUR=MAJ; PIÈCE=PIE                                     *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID.majpie .
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT           PIC 9(10).
       01 QUANTITE              PIC 9(10).
       01 TYPE                  PIC 9(01).
           88 AJOUT                       VALUE 0.
           88 ENLEVER                     VALUE 1.

       PROCEDURE DIVISION USING IDENTIFIANT,
                                QUANTITE,
                                TYPE.

           EXIT PROGRAM.