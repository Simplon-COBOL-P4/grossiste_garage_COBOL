      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; GS=GESTION; LIV=LIVRAISON;                          *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgsliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 ROLE                  PIC X(14).

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION USING ROLE.
            
           CALL "ecrajliv"
           END-CALL.
           CALL "ecrchliv"
           END-CALL.
           CALL "ecrmjliv"
           END-CALL.
           CALL "ecrspliv"
           END-CALL.

           EXIT PROGRAM.