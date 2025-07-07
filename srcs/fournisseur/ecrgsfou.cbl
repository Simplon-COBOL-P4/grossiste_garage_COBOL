      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; GS=GESTION; FOU=FOURNISSEUR;                        *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgsfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 ROLE                  PIC X(14).

       SCREEN SECTION.
       COPY ecrprn.

       PROCEDURE DIVISION USING ROLE.
            
           CALL "ecrajfou"
           END-CALL.
           CALL "ecrchfou"
           END-CALL.
           CALL "ecrmjfou"
           END-CALL.
           CALL "ecrspfou"
           END-CALL.

           EXIT PROGRAM.