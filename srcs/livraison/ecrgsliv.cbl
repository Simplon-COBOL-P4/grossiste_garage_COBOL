      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet de choisir l’action à effectuer vis-à-vis des *
      * livraisons.                                                  *
      * Il affiche des lignes différentes en fonction de l’argument    *
      * principal (Role), car ce n’est pas les mêmes options selon si  *
      * c'est un utilisateur 'STANDARD', ou 'ADMIN'.                   *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ACC=Accept                                                     *
      * ADM=Admin                                                      *
      * AFC=Affiche                                                    *
      * CHO=choix                                                      *
      * CMN=Commun                                                     *
      * DEB=ADebut                                                     *
      * ECR=ECRAN                                                      *
      * FIN=Fin                                                        *
      * FOU=Fournisseur                                                *
      * GS =Gestion                                                    *
      * UTL=Utilisateur                                                *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgsliv.
       AUTHOR. Benoit.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CHX                PIC 9(01).

       01 WS-ERR-OPT-IVL        PIC X(76) VALUE
           "Cette option n'existe pas".

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       COPY ctxerr.

       COPY utiglb.
       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-CMN.
           COPY ecrutlin.

           05 LINE 09 COL 30 VALUE 'Gestion des livraisons'.
           05 LINE 11 COL 30 VALUE '1 - Ajouter une livraison'.
           05 LINE 12 COL 30 VALUE '2 - Afficher une livraison'.
           05 LINE 19 COL 30 VALUE '0 - Retour au menu'.
           05 LINE 22 COL 30 VALUE 'Entrez votre choix : [ ]'.

       01  S-ECR-ADM.
           05 LINE 13 COL 30 VALUE '3 - Modifier uune livraison'.
           05 LINE 14 COL 30 VALUE '4 - Supprimer une livraison'.

       01  S-ECR-CHX.
           05 LINE 22 COL 52 PIC X(01) USING WS-CHX AUTO.

       01 S-MSG-ERR.
           05 LINE 23 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.
       
           PERFORM 0200-BCL-DEB
              THRU 0200-BCL-FIN.

           EXIT PROGRAM.

       0100-AFC-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-CMN.
           IF G-UTI-RLE EQUAL "ADMIN"
               DISPLAY S-ECR-ADM
           END-IF.

           PERFORM 0300-AFF-ERR-CND-DEB
              THRU 0300-AFF-ERR-CND-FIN.

           ACCEPT S-ECR-CHX.
       0100-AFC-ECR-FIN.

       0200-BCL-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN
               MOVE 0 TO WS-CHX
               PERFORM 0100-AFC-ECR-DEB
                  THRU 0100-AFC-ECR-FIN
               EVALUATE WS-CHX
                   WHEN 0
                       SET WS-ETT-BCL-FIN TO TRUE
                   WHEN 1
                       CALL "ecrajliv"
                       END-CALL
                   WHEN 2
                       CALL "ecrchliv"
                       END-CALL
                   WHEN OTHER
                       IF G-UTI-RLE EQUAL "ADMIN" THEN
                           PERFORM 0250-EVA-ADM-DEB
                              THRU 0250-EVA-ADM-FIN
                       ELSE
                           PERFORM 0400-ERR-OPT-IVL-DEB
                              THRU 0400-ERR-OPT-IVL-FIN
                       END-IF
               END-EVALUATE
           END-PERFORM.

       0200-BCL-FIN.

       0250-EVA-ADM-DEB.
           EVALUATE WS-CHX
               WHEN '3'
                   CALL "ecrmjliv"
                   END-CALL
            
               WHEN '4'
                   CALL "ecrspliv"
                   END-CALL
               WHEN OTHER
                   PERFORM 0400-ERR-OPT-IVL-DEB
                      THRU 0400-ERR-OPT-IVL-FIN
           END-EVALUATE.
       0250-EVA-ADM-FIN.

       0300-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0300-AFF-ERR-CND-FIN.

       0400-ERR-OPT-IVL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-OPT-IVL TO WS-MSG-ERR.
       0400-ERR-OPT-IVL-FIN.
