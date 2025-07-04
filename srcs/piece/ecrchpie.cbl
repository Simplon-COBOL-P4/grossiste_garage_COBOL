      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN ; CH=CHOIX; PIE=PIECE;                               *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.

       PROCEDURE DIVISION.
           
           EVALUATE
               WHEN
                   CALL "ecrrepie"
                   END-CALL

               WHEN
                   CALL "affpie"
                   END-CALL

           END-EVALUATE.
           
           EXIT PROGRAM.