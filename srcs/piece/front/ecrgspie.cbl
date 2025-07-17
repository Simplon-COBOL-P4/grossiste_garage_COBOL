      ******************************************************************
      *                             ENTÊTE                             *
      * Ce programme affiche le menu de gestion des pièces.            *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; GS=GESTION; PIE=PIECE; STD=SANDARD; RLE=ROLE        *
      * MNU=MENU; ADM=ADMIN; CHX=CHOIX; UTL=UTILISATEUR; EVA=EVALUATE  *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgspie.
       AUTHOR. Yassine.
       DATE-WRITTEN. 30-06-2025(fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CHX-MNU            PIC 9(01).

       01 WS-OPT-IVL            PIC X(76) VALUE
           "Cette option n'existe pas".

       COPY ctxerr.

       COPY utiglb.

       SCREEN SECTION.
       COPY ecrprn.
       01 S-MNU-STD.
           COPY ecrutlin.
           05 LINE 10 COLUMN 30 VALUE "Gestion du stock".
           05 LINE 12 COLUMN 30 VALUE "1 - Ajouter une piece".
           05 LINE 13 COLUMN 30 VALUE "2 - Afficher une piece".
           05 LINE 14 COLUMN 30 VALUE "3 - Modifier une piece".
           05 LINE 20 COLUMN 30 VALUE "0 - Retour au menu".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : ".
           05 LINE 22 COLUMN 52 VALUE "[".
           05 LINE 22 COLUMN 54 VALUE "]".
           05 LINE 22 COLUMN 53 PIC X(01) TO WS-CHX-MNU.

       01 S-MNU-ADM.
           05 LINE 15 COLUMN 30 VALUE "4 - Supprimer une piece".
           
       01 S-MSG-ERR.
           05 LINE 23 COLUMN 03 FROM WS-MSG-ERR.

      ******************************************************************     
       PROCEDURE DIVISION.

           PERFORM 0100-AFF-MNU-STD-DEB
              THRU 0100-AFF-MNU-STD-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *    Affiche le menu principal commun à tous les utilisateurs.
      ******************************************************************
       0100-AFF-MNU-STD-DEB.
           PERFORM UNTIL 1 = 0
               DISPLAY S-FND-ECR
               DISPLAY S-MNU-STD

               IF G-UTI-RLE EQUAL "ADMIN" THEN
                   DISPLAY S-MNU-ADM
               END-IF

               PERFORM 0400-AFF-ERR-CND-DEB
                  THRU 0400-AFF-ERR-CND-FIN

               ACCEPT S-MNU-STD

               EVALUATE WS-CHX-MNU
                   WHEN 1
                        CALL "ecrajpie" 
                        END-CALL  

                   WHEN 2
                        CALL "ecrchpie"
                        END-CALL 

                   WHEN 3
                        CALL "ecrmjpie"
                        END-CALL 

                   WHEN 0
                       EXIT PROGRAM

                   WHEN OTHER
                       IF G-UTI-RLE EQUAL "ADMIN" THEN
                           PERFORM 0200-EVA-ADM-CHX-DEB
                              THRU 0200-EVA-ADM-CHX-FIN
                       ELSE
                           PERFORM 0500-ERR-OPT-IVL-DEB
                              THRU 0500-ERR-OPT-IVL-FIN
                       END-IF
               END-EVALUATE
           END-PERFORM.
       0100-AFF-MNU-STD-FIN.

       0200-EVA-ADM-CHX-DEB.
           EVALUATE WS-CHX-MNU
               WHEN 4
                   CALL "ecrsppie"
                   END-CALL
               WHEN OTHER
                   PERFORM 0500-ERR-OPT-IVL-DEB
                      THRU 0500-ERR-OPT-IVL-FIN
           END-EVALUATE.
       0200-EVA-ADM-CHX-FIN.

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
