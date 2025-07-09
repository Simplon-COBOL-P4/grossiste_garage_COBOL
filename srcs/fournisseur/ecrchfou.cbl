      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN ; CH=CHOIX; FOU=FOURNISSEUR;                         *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.

       PROCEDURE DIVISION.
           
           CALL "ecrrefou"
           END-CALL

           CALL "ecrpgfou"
           END-CALL
           
           EXIT PROGRAM.