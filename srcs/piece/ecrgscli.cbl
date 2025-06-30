      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; GS=GESTION; CLI=Client;                             *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgscli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.

       LINKAGE SECTION.
      * Arguments d'entrée.
      * Rôle de l'utilisateur, ADMIN ou STANDARD actuellement.
       01 ROLE                  PIC X(14).

       PROCEDURE DIVISION USING ROLE.
           
           EVALUATE
           WHEN
               CALL "ecrajcli"

               END-CALL
           WHEN
               CALL "ecrchcli"

               END-CALL
           WHEN
               CALL "ecrmjcli"

               END-CALL
           WHEN
               CALL "ecrspcli"

               END-CALL
           END-EVALUATE.

           EXIT PROGRAM.