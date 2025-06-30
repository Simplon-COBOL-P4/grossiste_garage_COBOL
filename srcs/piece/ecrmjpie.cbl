      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN;MJ=MISE A JOUR; PIE=PIECE;                           *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT           PIC 9(10).
       01 QUANTITE              PIC 9(10).
       01 TYPE                  PIC 9(01).
           88 AJOUT                       VALUE 0.
           88 ENLEVER                     VALUE 1.

       PROCEDURE DIVISION.

           CALL "majpie"
               USING
               IDENTIFIANT
               QUANTITE
               TYPE
           END-CALL.

           EXIT PROGRAM.