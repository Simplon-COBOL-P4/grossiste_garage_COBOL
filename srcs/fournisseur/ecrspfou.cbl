      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRESSION; FOU=FOURNISSEUR;                    *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT           PIC 9(10).

       COPY supret REPLACING ==:PREFIX:== BY ==WS==.

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.
           
           CALL "supfou"
               USING
               IDENTIFIANT
               WS-SUP-RET
           END-CALL.

           EXIT PROGRAM.