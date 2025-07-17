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
       01  WS-CHX PIC 9(01).

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.
       
       01 WS-OPT-IVL            PIC X(76) VALUE
           "Cette option n'existe pas".

       COPY ctxerr.

       COPY utiglb.

       SCREEN SECTION.
      *    Voir maquette ecran choix lecture piece
       COPY ecrprn.

       01  S-ECR-CHX-PIE.
           COPY ecrutlin.
      
           05 LINE 09 COLUMN 30 VALUE "Afficher :".
           05 LINE 13 COLUMN 30 VALUE "1 - Une piece".
           05 LINE 14 COLUMN 30 VALUE "2 - La liste complete".
           05 LINE 19 COLUMN 30 VALUE "0 - Retour au menu".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : [".
           05 LINE 22 COLUMN 53 VALUE "]".
      
           05 LINE 22 COLUMN 52 TO WS-CHX.

       01 S-MSG-ERR.
           05 LINE 23 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0100-BCL-DEB
              THRU 0100-BCL-FIN.

           EXIT PROGRAM.

       0100-BCL-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN
               PERFORM 0200-AFF-ECR-DEB
                  THRU 0200-AFF-ECR-FIN

               PERFORM 0300-CHX-MEN-DEB
                  THRU 0300-CHX-MEN-FIN
           END-PERFORM.
       0100-BCL-FIN.

      *    Affichage de l'ecran et demande à l'utilisateur sa commande.
       0200-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.

           PERFORM 0400-AFF-ERR-CND-DEB
              THRU 0400-AFF-ERR-CND-FIN.

           ACCEPT S-ECR-CHX-PIE.
       0200-AFF-ECR-FIN.

      *    Traitement de la commande entree par l'utilisateur.
       0300-CHX-MEN-DEB.
           EVALUATE WS-CHX
               WHEN 1
                   CALL "ecrrepie"
                   END-CALL

               WHEN 2
                   CALL "affpie"
                   END-CALL

               WHEN 0
                   SET WS-ETT-BCL-FIN TO TRUE

               WHEN OTHER
                   PERFORM 0500-ERR-OPT-IVL-DEB
                      THRU 0500-ERR-OPT-IVL-FIN
           END-EVALUATE.
       0300-CHX-MEN-FIN.

       0400-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0400-AFF-ERR-CND-FIN.

       0500-ERR-OPT-IVL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-OPT-IVL TO WS-MSG-ERR.
       0500-ERR-OPT-IVL-FIN.
           