      ***************************************************  ***************
      *                             ENTÊTE                             *
      * Cet écran permet de choisir l’action à effectuer vis-à-vis des *
      * fournisseurs.                                                  *
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
       PROGRAM-ID. ecrgsfou.
       AUTHOR. Benoit.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 WS-CHO                PIC X(01).
       77 WS-ERR                PIC X(01).

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-ROL                   PIC X(14).

       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-CMN.
           05 LINE 04 COL 03 VALUE 'Connecte en tant que : '.
           05 LINE 04 COL 26 PIC X(14) FROM LK-ROL.
           05 LINE 09 COL 30 VALUE 'Gestion des fournisseurs'.
           05 LINE 13 COL 30 VALUE '1 - Ajouter un fournisseur'.
           05 LINE 14 COL 30 VALUE '2 - Afficher un fournisseur'.
           05 LINE 19 COL 30 VALUE '0 - Retour au menu'.
           05 LINE 22 COL 30 VALUE 'Entrez votre choix : [ ]'.
        
       01  S-ECR-ADM.
           05 LINE 15 COL 30 VALUE '3 - Modifier un fournisseur'.
           05 LINE 16 COL 30 VALUE '4 - Supprimer un fournisseur'.

       01  S-ECR-CHO.
           05 LINE 22 COL 52 PIC X(01) TO WS-CHO AUTO.


       PROCEDURE DIVISION USING LK-ROL.
           PERFORM 0100-AFC-ECR-DEB
              THRU 0100-AFC-ECR-FIN.
           PERFORM 0200-ACC-ECR-DEB
              THRU 0200-ACC-ECR-FIN.

           EXIT PROGRAM.

       0100-AFC-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-CMN.
           IF LK-ROL = 'ADMIN' THEN
              DISPLAY S-ECR-ADM
           END-IF.

       0100-AFC-ECR-FIN.
           EXIT.

       0200-ACC-ECR-DEB.
           MOVE ' ' TO WS-CHO.
           PERFORM UNTIL WS-CHO = '0'
             ACCEPT S-ECR-CHO
             EVALUATE WS-CHO
                WHEN '0'
                     CONTINUE
                WHEN '1'
                     CALL "ecrajfou"
                     END-CALL
                WHEN '2'
                     CALL "ecrchfou"
                     END-CALL
                WHEN '3'
                     IF LK-ROL = 'ADMIN' THEN
                        CALL "ecrmjfou"
                        END-CALL
                     ELSE 
                        PERFORM 0300-AFC-ERR-DEB
                           THRU 0300-AFC-ERR-FIN
                           END-IF
                WHEN '4'
                     IF LK-ROL = 'ADMIN' THEN
                        CALL "ecrspfou"
                        END-CALL
                      ELSE 
                        PERFORM 0300-AFC-ERR-DEB
                           THRU 0300-AFC-ERR-FIN
                     END-IF
                WHEN OTHER
                     PERFORM 0300-AFC-ERR-DEB
                        THRU 0300-AFC-ERR-FIN
             END-EVALUATE
           END-PERFORM.

       0200-ACC-ECR-FIN.
           EXIT.

       0300-AFC-ERR-DEB.
           DISPLAY 'Veuillez saisir une des options existants' AT LINE 
                                                              23 COL 30. 
           ACCEPT WS-ERR AT LINE 23 COL 71.
           DISPLAY '                                          ' AT LINE 
                                                              23 COL 30. 
       0300-AFC-ERR-FIN.
           EXIT.
