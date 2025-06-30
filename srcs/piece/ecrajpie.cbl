      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; AJ=AJOUT; PIE=PIECE;                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NOM                   PIC X(80).
       01 QUANTITE              PIC 9(10).
       01 SEUIL                 PIC 9(10).
       01 ID-FOURNISSEUR        PIC 9(10).

       PROCEDURE DIVISION.

           CALL "ajupie"
               USING
               NOM
               QUANTITE
               SEUIL
               ID-FOURNISSEUR
           END-CALL.

           EXIT PROGRAM.