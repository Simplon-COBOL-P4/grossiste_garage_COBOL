      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; CH=CHOIX; CLI=CLIENT                                *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.

       PROCEDURE DIVISION.

           EVALUATE
               CALL "ecrrecli"
               END-CALL

               CALL "ecrpgcli"
               END-CALL
           END-EVALUATE.
           
           EXIT PROGRAM.