      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; CH=CHOISIR; LIVRAISON;                              *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.

      *SCREEN SECTION.
      *COPY ecrprn.
      
       PROCEDURE DIVISION.
            
           CALL "ecridliv"
           END-CALL.
           CALL "ecrpgliv"
           END-CALL.

           EXIT PROGRAM.