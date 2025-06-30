      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SUP/SP=SUPPRESSION; PIE=PIECE;                      *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrsppie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT-PIECE   PIC 9(10).

       PROCEDURE DIVISION.

           CALL "suppie"
               USING
               IDENTIFIANT-PIECE
           END-CALL.

           EXIT PROGRAM.