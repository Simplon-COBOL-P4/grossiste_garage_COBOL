      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; GS=GESTION; PIE=PIECE;                              *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgspie.
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
               CALL "ecrajpie"

               END-CALL
           WHEN
               CALL "affpie"

               END-CALL
           WHEN
               CALL "ecrmjpie"

               END-CALL
           WHEN
               CALL "ecrsppie"

               END-CALL
           END-EVALUATE.

           EXIT PROGRAM.