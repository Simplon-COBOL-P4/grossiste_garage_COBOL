      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *  écran qui ajoute une livraison à la base de donnée            *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; AJ=AJOUT; LIV=LIVRAISON; DAT=date; STA=statut       *
      * TYP=type; ENT=entrant; SOR=sortante; IDT=identifiant;          *
      * QUA=quantité; PIE=pièce; TER=terminer; CRS=cours; ET=état      *
      * CON=continuer; PRO=prgramme; PRI=principale                    *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajliv.
       AUTHOR. lucas.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Nécessaire pour faire COMMIT ou ROLLBACK
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Pour savoir si l'utilisateur veut continuer ou retourner en
      * arrière.
       01 WS-CON                  PIC 9(01).

      * Variable pour les appel de sous-programme.      
       01 WS-DAT                  PIC X(10).
       01 WS-STA                  PIC 9(01).
           88 STA-EN-CRS                    VALUE 0.
           88 STA-TER                       VALUE 1.
       01 WS-TYP                  PIC 9(01).
           88 TYP-ENT                       VALUE 0.
           88 TYP-SOR                       VALUE 1.
      * Identifiant fournisseur si entrante, et client si sortante.
       01 WS-IDT                  PIC 9(10).

      * Variable pour l'ajout de pièce dans la livraison(état 4).
       01 WS-IDT-LIV              PIC 9(10).
       01 WS-IDT-PIE              PIC 9(10).
       01 WS-QUA-PIE              PIC 9(10).

      * Le code d'erreur
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.
       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

   
      * Variable nécessaire en cas de livraison sortante pour récupérer
      * la quantité de pièce qu'il y a en stock.

      * Arguments de sortie.
       01 WS-NOM-PIE              PIC X(50).
       01 WS-QUA-PIE-SOR          PIC 9(10).
       01 WS-SEU-PIE              PIC 9(10).
       01 WS-ID-FOR               PIC 9(10).
       01 WS-NOM-FOR              PIC X(50).

       01 WS-CHX                  PIC X(01).
           88 WS-CHX-VID                  VALUE " ".

       01 WS-ETT-BCL              PIC 9(01).
           88 WS-ETT-BCL-ENC                VALUE 1.
           88 WS-ETT-BCL-FIN                VALUE 2.

       01 WS-MNU-VIS              PIC 9(01).
           88 WS-MNU-VIS-1                  VALUE 1.
           88 WS-MNU-VIS-2                  VALUE 2.
           88 WS-MNU-VIS-3                  VALUE 3.
           88 WS-MNU-VIS-4-SOR              VALUE 4.
           88 WS-MNU-VIS-4-ENT              VALUE 5.

       01 WS-SUC-LIV-PIE          PIC X(76) VALUE
           "La piece a ete ajoutee a la livraison avec success".

       01 WS-SUC-LIV              PIC X(76) VALUE
           "La livraison a ete ajoutee avec success".

       01 WS-ERR-QTE-PIE          PIC X(76) VALUE
           "Pas assez de cette piece pour cette operation".

       01 WS-OPT-IVL              PIC X(76) VALUE
           "Cette option n'existe pas".

       01 WS-ERR-SQL-ID-FOU       PIC X(76) VALUE
           "L'ID du fournisseur n'existe pas".

       01 WS-ERR-SQL-ID-CLI       PIC X(76) VALUE
           "L'ID du client n'existe pas".

       01 WS-ERR-SQL-ID-PIE       PIC X(76) VALUE
           "L'ID de la piece n'existe pas".

       01 WS-ERR-SQL-FMT-DAT      PIC X(76) VALUE
           "La date n'est pas correctement formatee (AAAA-MM-JJ)".

       01 WS-ERR-SQL              PIC X(76) VALUE
           "Une erreur est survenue lors de la requete".

       COPY ctxerr.

       COPY utiglb.

       SCREEN SECTION.
       COPY ecrprn.

       01 S-RTR.
           05 LINE 22.
               10 COLUMN 70 VALUE "Retour ".
               10 COLUMN 77 VALUE "[".
               10 COLUMN 79 VALUE "]".

      * état 1
       01 S-ET1.
           05 LINE 06 COLUMN 03 VALUE 'Type de livraison'.
           05 LINE 09 COLUMN 03 VALUE 'Entree (0) / Sortie (1) : ['.
           05 LINE 09 COLUMN 31 VALUE ']'.
           05 LINE 09 COLUMN 30 PIC Z(01) TO WS-TYP.
           05 LINE 22 COLUMN 78 PIC X(01) USING WS-CHX.


      * état 2, livraison entrante
       01 S-ET2.
           05 LINE 06 COLUMN 03 VALUE 'Livraison entrante'.
           05 LINE 08 COLUMN 03 VALUE 'ID fournisseur : ['.
           05 LINE 08 COLUMN 21 PIC Z(10) TO WS-IDT.
           05 LINE 08 COLUMN 31 VALUE ']'.
           05 LINE 10 COLUMN 03 VALUE "Date livraison : [".
           05 LINE 10 COLUMN 31 VALUE ']'.
           05 LINE 10 COLUMN 21 PIC X(10) TO WS-DAT.
           05 LINE 12 COLUMN 03 VALUE "Statut (0/1) : [".
           05 LINE 12 COLUMN 20 VALUE "]".
           05 LINE 12 COLUMN 19 PIC Z(01) TO WS-STA.
           05 LINE 21 COLUMN 28 VALUE '1 - Suivant  0 - Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) USING WS-CON.
           05 LINE 22 COLUMN 42 VALUE "]".
           05 LINE 22 COLUMN 78 PIC X(01) USING WS-CHX.

      * état 3, livraison entrante
       01 S-ET3.
           05 LINE 06 COLUMN 03 VALUE 'Livraison sortante'.
           05 LINE 08 COLUMN 03 VALUE 'ID client :      ['.
           05 LINE 08 COLUMN 21 PIC Z(10) TO WS-IDT.
           05 LINE 08 COLUMN 31 VALUE ']'.
           05 LINE 10 COLUMN 03 VALUE "Date livraison : [".
           05 LINE 10 COLUMN 31 VALUE ']'.
           05 LINE 10 COLUMN 21 PIC X(10) TO WS-DAT.
           05 LINE 12 COLUMN 03 VALUE "Statut (0/1) : [".
           05 LINE 12 COLUMN 20 VALUE "]".
           05 LINE 12 COLUMN 19 PIC Z(01) TO WS-STA.
           05 LINE 21 COLUMN 28 VALUE '1 - Suivant  0 - Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) USING WS-CON.
           05 LINE 22 COLUMN 42 VALUE "]".
           05 LINE 22 COLUMN 78 PIC X(01) USING WS-CHX.

       01 S-ET4.
           05 LINE 06 COLUMN 03 VALUE 'Piece de livraison'.
           05 LINE 08 COLUMN 03 VALUE 'ID piece : ['.
           05 LINE 08 COLUMN 15 PIC Z(10) USING WS-IDT-PIE.
           05 LINE 08 COLUMN 25 VALUE ']'.
           05 LINE 10 COLUMN 03 VALUE "Quantite : [".
           05 LINE 10 COLUMN 25 VALUE ']'.
           05 LINE 10 COLUMN 15 PIC Z(10) USING WS-QUA-PIE.
           05 LINE 21 COLUMN 20 VALUE
              '1 - Ajouter   2 - Terminer   0 - Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) USING WS-CON.
           05 LINE 22 COLUMN 42 VALUE "]".
           05 LINE 22 COLUMN 78 PIC X(01) USING WS-CHX.

       01 S-MSG-ERR.
           05 LINE 23 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0100-PRO-PRI-DEB
              THRU 0100-PRO-PRI-FIN.

           EXIT PROGRAM.

       0100-PRO-PRI-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           SET WS-MNU-VIS-1   TO TRUE.
           SET WS-CHX-VID     TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN

               DISPLAY S-FND-ECR
               PERFORM 0600-AFF-ERR-CND-DEB
                  THRU 0600-AFF-ERR-CND-FIN
               DISPLAY S-RTR

               MOVE 1 TO WS-CON

               EVALUATE TRUE
                   WHEN WS-MNU-VIS-1
                       ACCEPT S-ET1
                   WHEN WS-MNU-VIS-2
                       ACCEPT S-ET2
                   WHEN WS-MNU-VIS-3
                       ACCEPT S-ET3
                   WHEN WS-MNU-VIS-4-ENT OR WS-MNU-VIS-4-SOR
                       ACCEPT S-ET4
               END-EVALUATE

               EVALUATE TRUE
                   WHEN WS-CHX-VID 
                       EVALUATE TRUE
                           WHEN WS-MNU-VIS-1
                               PERFORM 0500-ET1-DEB
                                  THRU 0500-ET1-FIN
                           WHEN WS-MNU-VIS-2 OR WS-MNU-VIS-3
                               PERFORM 0200-ET2-DEB
                                  THRU 0200-ET2-FIN
                           WHEN WS-MNU-VIS-4-ENT OR WS-MNU-VIS-4-SOR
                               PERFORM 0400-AJ-PIE-DEB
                                  THRU 0400-AJ-PIE-FIN
                       END-EVALUATE

                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE
               END-EVALUATE
           END-PERFORM.
       0100-PRO-PRI-FIN.

       0200-ET2-DEB.
      * Aller à l'état 4 si le code d'erreur est à 0
           IF WS-CON EQUAL 1
               CALL "ajuliv"
                   USING
      * Arguments d'entrée
                   WS-DAT
                   WS-DAT
                   WS-STA
                   WS-TYP
                   WS-IDT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
                   WS-IDT-LIV
                   WS-AJU-RET
      * Fin des arguments de sortie
               END-CALL
               EVALUATE TRUE
                   WHEN WS-AJU-RET-OK
                       EVALUATE TRUE
                           WHEN WS-MNU-VIS-2
                               SET WS-MNU-VIS-4-ENT TO TRUE
                           WHEN WS-MNU-VIS-3
                               SET WS-MNU-VIS-4-SOR TO TRUE
                       END-EVALUATE
                       PERFORM 1200-SUC-LIV-DEB
                          THRU 1200-SUC-LIV-FIN
                   WHEN WS-AJU-RET-FK-ERR
                       EVALUATE TRUE
                           WHEN WS-MNU-VIS-2
                               PERFORM 0800-ERR-SQL-ID-FOU-DEB
                                  THRU 0800-ERR-SQL-ID-FOU-FIN
                           WHEN WS-MNU-VIS-3
                               PERFORM 1400-ERR-SQL-ID-CLI-DEB
                                  THRU 1400-ERR-SQL-ID-CLI-FIN
                       END-EVALUATE
                   WHEN WS-AJU-RET-FMT-DAT
                       PERFORM 1000-ERR-SQL-FMT-DAT-DEB
                          THRU 1000-ERR-SQL-FMT-DAT-FIN
                   WHEN OTHER
                       PERFORM 0900-ERR-SQL-DEB
                          THRU 0900-ERR-SQL-FIN
               END-EVALUATE
           END-IF.
       0200-ET2-FIN.

      * Ce que l'on fait à l'état 4, il n'y a que des pièce entrantes
       0400-AJ-PIE-DEB.
           EVALUATE WS-CON
               WHEN 1
                   CALL "vrflivpi"
                       USING
                       WS-IDT-LIV
                       WS-IDT-PIE
                       WS-LIR-RET
                   END-CALL

                   EVALUATE TRUE
                       WHEN WS-LIR-RET-OK
                           EVALUATE TRUE
                               WHEN WS-MNU-VIS-4-ENT
                                   PERFORM 0420-AJ-PIE-ENT-DEB
                                      THRU 0420-AJ-PIE-ENT-FIN
                               WHEN WS-MNU-VIS-4-SOR
                                   PERFORM 0440-AJ-PIE-SOR-DEB
                                      THRU 0440-AJ-PIE-SOR-FIN
                           END-EVALUATE
                           MOVE 0 TO WS-IDT-PIE
                           MOVE 0 TO WS-QUA-PIE
                       WHEN WS-LIR-RET-VID
                           PERFORM 1300-ERR-SQL-ID-PIE-DEB
                              THRU 1300-ERR-SQL-ID-PIE-FIN
                       WHEN OTHER
                           PERFORM 0900-ERR-SQL-DEB
                              THRU 0900-ERR-SQL-FIN
                   END-EVALUATE
               WHEN 2
                   SET WS-MNU-VIS-1 TO TRUE
               WHEN 0
                   SET WS-MNU-VIS-1 TO TRUE
               WHEN OTHER
                   PERFORM 0700-ERR-OPT-IVL-DEB
                      THRU 0700-ERR-OPT-IVL-FIN
           END-EVALUATE.
       0400-AJ-PIE-FIN.

       0420-AJ-PIE-ENT-DEB.
           CALL "ajulivpi"
               USING
               WS-IDT-LIV
               WS-IDT-PIE
               WS-QUA-PIE
               WS-AJU-RET
           END-CALL.

           IF STA-TER then
               CALL "majpie"
                   USING
                   WS-IDT-PIE
                   WS-QUA-PIE
                   WS-TYP
                   WS-MAJ-RET
               END-CALL
           END-IF.

           PERFORM 1100-SUC-LIV-PIE-DEB
              THRU 1100-SUC-LIV-PIE-FIN.
       0420-AJ-PIE-ENT-FIN.

       0440-AJ-PIE-SOR-DEB.
           CALL "liridpie"
               USING
               WS-IDT-PIE
               WS-NOM-PIE
               WS-QUA-PIE-SOR  
               WS-SEU-PIE
               WS-ID-FOR 
               WS-NOM-FOR
               WS-LIR-RET
           END-CALL

           IF WS-QUA-PIE-SOR >= WS-QUA-PIE
               CALL "ajulivpi"
                   USING
                   WS-IDT-LIV
                   WS-IDT-PIE
                   WS-QUA-PIE
                   WS-AJU-RET
               END-CALL

               CALL "majpie"
                   USING
                   WS-IDT-PIE
                   WS-QUA-PIE
                   WS-TYP
                   WS-MAJ-RET
               END-CALL
               
               PERFORM 1100-SUC-LIV-PIE-DEB
                  THRU 1100-SUC-LIV-PIE-FIN
           ELSE
               PERFORM 1500-ERR-QTE-PIE-DEB
                  THRU 1500-ERR-QTE-PIE-FIN
           END-IF.
       0440-AJ-PIE-SOR-FIN.

       0500-ET1-DEB.
           EVALUATE TRUE
               WHEN TYP-ENT
                   SET WS-MNU-VIS-2 TO TRUE
               WHEN TYP-SOR
                   SET WS-MNU-VIS-3 TO TRUE
               WHEN OTHER
                   PERFORM 0700-ERR-OPT-IVL-DEB
                      THRU 0700-ERR-OPT-IVL-FIN
           END-EVALUATE.
       0500-ET1-FIN.

       0600-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0600-AFF-ERR-CND-FIN.

       0700-ERR-OPT-IVL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-OPT-IVL TO WS-MSG-ERR.
       0700-ERR-OPT-IVL-FIN.

       0800-ERR-SQL-ID-FOU-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL-ID-FOU TO WS-MSG-ERR.
       0800-ERR-SQL-ID-FOU-FIN.

       0900-ERR-SQL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL TO WS-MSG-ERR.
       0900-ERR-SQL-FIN.

       1000-ERR-SQL-FMT-DAT-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL-FMT-DAT TO WS-MSG-ERR.
       1000-ERR-SQL-FMT-DAT-FIN.

       1100-SUC-LIV-PIE-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-LIV-PIE TO WS-MSG-ERR.
       1100-SUC-LIV-PIE-FIN.

       1200-SUC-LIV-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-LIV TO WS-MSG-ERR.
       1200-SUC-LIV-FIN.

       1300-ERR-SQL-ID-PIE-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL-ID-PIE TO WS-MSG-ERR.
       1300-ERR-SQL-ID-PIE-FIN.

       1400-ERR-SQL-ID-CLI-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL-ID-CLI TO WS-MSG-ERR.
       1400-ERR-SQL-ID-CLI-FIN.

       1500-ERR-QTE-PIE-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-QTE-PIE TO WS-MSG-ERR.
       1500-ERR-QTE-PIE-FIN.
