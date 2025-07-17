      ******************************************************************
      *                             ENTÊTE                             *
      * Ecran de mise a jour des infos d'une piece.                    *
      * Cet écran permet à l’utilisateur de rentrer les différents     *
      * arguments nécessaire à la mise à jour d’une pièce.             *
      * L’utilisateur rentre l’ID de la pièce, puis appuie sur entrée. *
      * Cela appelle le sous programme liridpie, qui récupère les      *
      * informations de la pièce, en fonction de l’ID.                 *
      * Suite à cela, il faut afficher les informations récupérées, ce *
      * qui donne à l’utilisateur la possibilité de les modifier, avant*
      * de valider, ce qui appelle le sous programme mjinfpie. 
      *                                                                *
      *                           TRIGRAMMES                           *
      * AFC=Afficher                                                   *
      * DEB=Debut                                                      *
      * ECR=Ecran                                                      *
      * FIN=Fin                                                        *
      * IDT=Identité                                                   *
      * INF=Information                                                *
      * LIR=Lire                                                       *
      * NOM=Nom                                                        *
      * PBL=Poubelle                                                   *
      * PIE=Piece                                                      *
      * SSI=Saisi                                                      *
      * SUI=Seuil                                                      *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjinf.
       AUTHOR. Benoit.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDT-PIE           PIC 9(10).
       01 WS-IDT-PIE-PRC       PIC 9(10).
       01 WS-NOM-PIE           PIC X(50).
       01 WS-QTE-PIE           PIC 9(10).
       01 WS-SUI-PIE           PIC 9(10).
       01 WS-IDT-FOU           PIC 9(10).
       01 WS-PBL               PIC X(50).

       01  WS-CHX              PIC X(01).
           88 WS-CHX-VID                  VALUE " ".

       01 WS-MNU-ACT              PIC 9(01).
           88 WS-MNU-ACT-VID                VALUE 1.
           88 WS-MNU-ACT-PLN                VALUE 2.

       01 WS-ETT-BCL           PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       01 WS-VAL                PIC 9(01).
           88 WS-VAL-SUC                  VALUE 1.

       01 WS-ERR-SQL           PIC X(76) VALUE
           "Une erreur est survenue lors de la requete".

       01 WS-SUC-LIR           PIC X(76) VALUE
           "La lecture s'est deroulee correctement".

       01 WS-SUC-MAJ           PIC X(76) VALUE
           "La mise a jour s'est deroulee correctement".

       01 WS-ERR-VAL           PIC X(76) VALUE "Erreur de validation".

       01 WS-ERR-SQL-FK        PIC X(76) VALUE
           "L'ID du fournisseur n'existe pas".

       COPY ctxerr.

       COPY utiglb.

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-SSI-01.
           COPY ecrutlin.

           05 LINE 07 COL 23 VALUE 'ID de la piece : [          ]'.
           05 LINE 09 COL 03 VALUE 'Nom piece :'.
           05 LINE 10 COL 03 VALUE '[                                   
      -                            '               ]'.
           05 LINE 12 COL 03 VALUE 'Seuil minimum :'.
           05 LINE 13 COL 03 VALUE '[          ]'.
           05 LINE 15 COL 03 VALUE 'ID fournisseur :'.
           05 LINE 16 COL 03 VALUE '[          ]'.
           05 LINE 22.
               10 COL 62 VALUE "Retour au menu".
               10 COL 77 VALUE "[".
               10 COL 79 VALUE "]".

       01  S-ECR-SSI-IDT.
           05 LINE 07 COL 41 PIC Z(10) USING WS-IDT-PIE AUTO.
           05 LINE 22 COL 78 PIC X(01) USING WS-CHX.

       01  S-ECR-SSI-INF.
           05 LINE 07 COL 41 PIC Z(10) USING WS-IDT-PIE AUTO.
           05 LINE 10 COL 04 PIC X(50) USING WS-NOM-PIE AUTO.
           05 LINE 13 COL 04 PIC Z(10) USING WS-SUI-PIE AUTO.
           05 LINE 16 COL 04 PIC Z(10) USING WS-IDT-FOU AUTO.
           05 LINE 22 COL 78 PIC X(01) USING WS-CHX.
           
       01 S-MSG-ERR.
           05 LINE 05 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0100-BCL-DEB
              THRU 0100-BCL-FIN.

           EXIT PROGRAM.

       0100-BCL-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           SET WS-CHX-VID TO TRUE.
           SET WS-MNU-ACT-VID TO TRUE.
           MOVE 0 TO WS-IDT-PIE-PRC.

           PERFORM UNTIL WS-ETT-BCL-FIN
               
               PERFORM 0200-AFC-ECR-DEB
                  THRU 0200-AFC-ECR-FIN

               EVALUATE TRUE
                   WHEN WS-CHX-VID

                       PERFORM 0500-VAL-DEB
                          THRU 0500-VAL-FIN

                       IF WS-VAL-SUC THEN
                           IF WS-IDT-PIE NOT EQUAL WS-IDT-PIE-PRC THEN
                               MOVE WS-IDT-PIE TO WS-IDT-PIE-PRC
                               PERFORM 0300-LIR-PIE-DEB
                                  THRU 0300-LIR-PIE-FIN
                           ELSE
                               PERFORM 0400-MAJ-DEB
                                  THRU 0400-MAJ-FIN
                           END-IF
                       END-IF

                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE

               END-EVALUATE
           END-PERFORM.
       0100-BCL-FIN.

       0200-AFC-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-SSI-01.

           PERFORM 1000-AFF-ERR-CND-DEB
              THRU 1000-AFF-ERR-CND-FIN.

           PERFORM 0900-AFF-MNU-ACT-DEB
              THRU 0900-AFF-MNU-ACT-FIN.
       0200-AFC-ECR-FIN.

      *
      * Appeler lireidpie en specifiant l'id de la piece
      * 
       0300-LIR-PIE-DEB.
           CALL "liridpie"
               USING
      * Arguments d'entrée
               WS-IDT-PIE
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-NOM-PIE
               WS-QTE-PIE
               WS-SUI-PIE
               WS-IDT-FOU
      * Argument non utilisé, obligé de le mettre quand même.
               WS-PBL
               WS-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

           EVALUATE TRUE
               WHEN WS-LIR-RET-OK
                   SET WS-MNU-ACT-PLN TO TRUE
                   PERFORM 1300-SUC-LIR-DEB
                      THRU 1300-SUC-LIR-FIN
               WHEN OTHER
                   PERFORM 1200-ERR-SQL-DEB
                      THRU 1200-ERR-SQL-FIN
                   MOVE 0 TO WS-IDT-PIE-PRC
                   SET WS-MNU-ACT-VID TO TRUE
           END-EVALUATE.
       0300-LIR-PIE-FIN.
      *
      * Modifier les données de la piece en question puis taper '1'
      * pour confirmer la mise-à-jour.
      *
       0400-MAJ-DEB.
           CALL "mjinfpie"
              USING
      * Arguments d'entrée
              WS-IDT-PIE
              WS-NOM-PIE
              WS-SUI-PIE
              WS-IDT-FOU
      * Fin des arguments d'entrée
              WS-MAJ-RET
           END-CALL.

           EVALUATE TRUE
               WHEN WS-MAJ-RET-OK
                   PERFORM 1500-SUC-MAJ-DEB
                      THRU 1500-SUC-MAJ-FIN

               WHEN WS-MAJ-RET-FK-ERR
                   PERFORM 1400-ERR-SQL-FK-DEB
                      THRU 1400-ERR-SQL-FK-FIN

               WHEN OTHER
                   PERFORM 1200-ERR-SQL-DEB
                      THRU 1200-ERR-SQL-FIN
                      
           END-EVALUATE.
       0400-MAJ-FIN.

       0500-VAL-DEB.
           MOVE 0 TO WS-VAL.
           PERFORM 0600-VAL-IDT-DEB
              THRU 0600-VAL-IDT-FIN.
       0500-VAL-FIN.

       0600-VAL-IDT-DEB.
           IF WS-IDT-PIE <> 0 THEN
               ADD 1 TO WS-VAL
           ELSE
               PERFORM 1100-ERR-VAL-DEB
                  THRU 1100-ERR-VAL-FIN
               SET WS-MNU-ACT-VID TO TRUE
           END-IF.
       0600-VAL-IDT-FIN.

       0900-AFF-MNU-ACT-DEB.
           EVALUATE TRUE
               WHEN WS-MNU-ACT-VID
                   ACCEPT S-ECR-SSI-IDT
               WHEN WS-MNU-ACT-PLN
                   ACCEPT S-ECR-SSI-INF
           END-EVALUATE.
       0900-AFF-MNU-ACT-FIN.

       1000-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       1000-AFF-ERR-CND-FIN.

       1100-ERR-VAL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-VAL TO WS-MSG-ERR.
       1100-ERR-VAL-FIN.

       1200-ERR-SQL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL TO WS-MSG-ERR.
       1200-ERR-SQL-FIN.

       1300-SUC-LIR-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-LIR TO WS-MSG-ERR.
       1300-SUC-LIR-FIN.

       1400-ERR-SQL-FK-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL-FK TO WS-MSG-ERR.
       1400-ERR-SQL-FK-FIN.

       1500-SUC-MAJ-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-MAJ TO WS-MSG-ERR.
       1500-SUC-MAJ-FIN.
