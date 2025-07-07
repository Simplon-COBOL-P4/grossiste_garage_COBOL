      ******************************************************************
      *                             ENTÊTE                             *
      * C'est un sous-programme pour choisir quel affichage de piece,  *
      * par affichage unique ou la liste complète.                     *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN ; CH=CHOIX; PIE=PIECE; CHX=CHOIX; MEN=MENU;          *
      * AFF=AFFICHER;                                                  *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchpie.
       AUTHOR. siboryg.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CHX PIC X(01).
       
       SCREEN SECTION.
      *    Voir maquette ecran choix lecture piece
       COPY ecrprn.

       01  S-ECRCHPIE.
        05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : ".

        05 LINE 09 COLUMN 30 VALUE "Afficher :".
        05 LINE 13 COLUMN 30 VALUE "1 - Une piece".
        05 LINE 14 COLUMN 30 VALUE "2 - La liste complete".
        05 LINE 19 COLUMN 30 VALUE "0 - Retour au menu".
        05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : [".
        05 LINE 22 COLUMN 53 VALUE "]".

        05 LINE 22 COLUMN 52 TO WS-CHX.


       PROCEDURE DIVISION.
           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-CHX-MEN-DEB
              THRU 0200-CHX-MEN-FIN.

           EXIT PROGRAM.

      *    Affichage de l'ecran et demande à l'utilisateur sa commande.
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECRCHPIE.

       0100-AFF-ECR-FIN.
           EXIT.

      *    Traitement de la commande entree par l'utilisateur.
       0200-CHX-MEN-DEB.
           PERFORM UNTIL WS-CHX EQUAL 0
           ACCEPT S-ECRCHPIE
           EVALUATE WS-CHX
               WHEN "1"
                   CALL "ecrrepie"
                   END-CALL

               WHEN "2"
                   CALL "affpie"
                   END-CALL

               WHEN 0
                   EXIT PROGRAM

               WHEN OTHER
                   DISPLAY "Entrer 1 ou 2"
                   AT LINE 21 COLUMN 3
           END-EVALUATE
           END-PERFORM.

       0200-CHX-MEN-FIN.
           EXIT.
           