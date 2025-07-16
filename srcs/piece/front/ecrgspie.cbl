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

       LINKAGE SECTION.
      * Arguments d'entrée.
      * Rôle de l'utilisateur, ADMIN ou STANDARD actuellement.
       01 LK-RLE                PIC X(14).

       SCREEN SECTION.
       COPY ecrprn.
       01 S-MNU-STD.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : " .
           05 LINE 04 COLUMN 26 FROM LK-RLE.
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
           

      ******************************************************************     
       PROCEDURE DIVISION USING LK-RLE.

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

               IF LK-RLE EQUAL "ADMIN" THEN
                   DISPLAY S-MNU-ADM
               END-IF

               ACCEPT S-MNU-STD

               EVALUATE WS-CHX-MNU
                   WHEN 1
                        CALL "ecrajpie" 
                        END-CALL  

                   WHEN 2
                        CALL "affpie"
                        END-CALL 

                   WHEN 3
                        CALL "ecrmjpie"
                        END-CALL 

                   WHEN 0
                       EXIT PROGRAM

                   WHEN OTHER
                       IF LK-RLE EQUAL "ADMIN" THEN
                           PERFORM 0200-EVA-ADM-CHX-DEB
                              THRU 0200-EVA-ADM-CHX-FIN
                       END-IF
               END-EVALUATE
           END-PERFORM.
       0100-AFF-MNU-STD-FIN.
           EXIT.

       0200-EVA-ADM-CHX-DEB.
           EVALUATE WS-CHX-MNU
               WHEN 4
                   CALL "ecrsppie"
                   END-CALL
           END-EVALUATE.
       0200-EVA-ADM-CHX-FIN.
           EXIT.
