      ******************************************************************
      *                             ENTÊTE                             *
      * Ce programme sert à modifier la quantité d'une pièce.          *
      * L’utilisateur rentre l’ID de la pièce, le nombre de pièce à    *
      * faire entrer/sortir, ainsi que le type d’action (ajout/retrait)*
      * et appel le sous programme "majpie" pour exécuter l'action     *
      * souhaitée (ajout/retrait).                                     *
      * C'est le programme 'mijpie' qui doit afficher le message       *
      * suivant 'Mise à jour effectuée !' une fois que la mise à jour  *
      * de la pièce est réussie.                                       * 
      *                                                                *
      *                           TRIGRAMMES                           *
      * ACT=ACTION                                                     *
      * AFC=AFFICHAGE                                                  *
      * DEB=DEBUT                                                      *
      * ECR=ECRAN                                                      *
      * FIN=FIN                                                        *
      * IDT=IDENTITE                                                   *
      * MAJ=MISE A JOUR                                                *
      * PIE=PIECE                                                      *
      * QTE=QUANTITE                                                   *
      * SSI SAISIE                                                     *
      * TYP=TYPE                                                       *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjpie.
       AUTHOR. Benoit.
       DATE-WRITTEN. 01-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PIE-TYP               PIC 9(01).
           88 AJOUT                       VALUE 0.
           88 ENLEVER                     VALUE 1.

       77 WS-PIE-IDT               PIC 9(10).
       77 WS-PIE-QTE               PIC 9(10). 
       77 WS-PIE-ACT               PIC 9(01).

       01 WS-VAL                PIC 9(03).
           88 WS-VAL-SUC                  VALUE 111.

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       01  WS-CHX               PIC X(01).
           88 WS-CHX-VID                  VALUE " ".

       01 WS-ERR-SQL            PIC X(76) VALUE
           "Une erreur est survenue lors de la requete".

       01 WS-ERR-VAL          PIC X(76) VALUE "Erreur de validation".
       
       01 WS-SUC-MAJ            PIC X(76) VALUE
           "La mise a jour s'est deroulee correctement".

       COPY ctxerr.

       COPY utiglb.

       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-SSI-01.
           COPY ecrutlin.
           
           05  LINE 6  COL 23 VALUE 'ID de la piece : ['.
           05  LINE 6  COL 51 VALUE ']'.
           05  LINE 6  COL 41 PIC Z(10) TO WS-PIE-IDT AUTO.
           05  LINE 10 COL 3  VALUE 'Quantite : '.
           05  LINE 11 COL 3  VALUE '['.
           05  LINE 11 COL 14 VALUE ']'.
           05  LINE 11 COL 4  PIC Z(10) TO WS-PIE-QTE AUTO.
           05  LINE 12 COL 3  VALUE 'Ajouter (1) Enlever (2) :'.
           05  LINE 13 COL 3  VALUE '['.
           05  LINE 13 COL 5  VALUE ']'.
           05  LINE 13 COL 4  PIC Z(01) TO WS-PIE-ACT AUTO.
           05 LINE 22.
               10 COL 62 VALUE "Retour au menu".
               10 COL 77 VALUE "[".
               10 COL 78 PIC X(01) USING WS-CHX.
               10 COL 79 VALUE "]".
       
       01 S-MSG-ERR.
           05 LINE 05 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0100-BCL-DEB
              THRU 0100-BCL-FIN.

           EXIT PROGRAM.

       0100-BCL-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           SET WS-CHX-VID TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN

               PERFORM 0200-AFC-ECR-DEB 
                  THRU 0200-AFC-ECR-FIN

               EVALUATE TRUE
                   WHEN WS-CHX-VID

                       PERFORM 0350-VAL-DEB
                          THRU 0350-VAL-FIN

                       PERFORM 0300-MAJ-DEB
                          THRU 0300-MAJ-FIN

                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE
               END-EVALUATE
           END-PERFORM.
       0100-BCL-FIN.

      * Affiche l'ecran de saisi
       0200-AFC-ECR-DEB.    
           DISPLAY S-FND-ECR.

           PERFORM 0800-AFF-ERR-CND-DEB
              THRU 0800-AFF-ERR-CND-FIN.

           ACCEPT S-ECR-SSI-01.
       0200-AFC-ECR-FIN.

      * Saisir l'id et la qantité de la pièce à modifier et l'action
      * (Ajout/Enlever) à faire 

       0300-MAJ-DEB.
           IF WS-VAL-SUC THEN
               CALL "majpie"
                   USING
                   WS-PIE-IDT
                   WS-PIE-QTE
                   WS-PIE-TYP
                   WS-MAJ-RET
               END-CALL
               
               EVALUATE TRUE
                   WHEN WS-MAJ-RET-OK
                       PERFORM 0900-SUC-MAJ-DEB
                          THRU 0900-SUC-MAJ-FIN
                   WHEN OTHER
                       PERFORM 1000-ERR-SQL-DEB
                          THRU 1000-ERR-SQL-FIN
               END-EVALUATE
           END-IF.
       0300-MAJ-FIN.

       0350-VAL-DEB.
           MOVE 0 TO WS-VAL.

           PERFORM 0400-VAL-IDT-DEB
              THRU 0400-VAL-IDT-FIN.

           PERFORM 0500-VAL-QTE-DEB
              THRU 0500-VAL-QTE-FIN.

           PERFORM 0600-VAL-ACT-DEB
              THRU 0600-VAL-ACT-FIN.
       0350-VAL-FIN.

       0400-VAL-IDT-DEB.
           IF WS-PIE-IDT <> 0 THEN
               ADD 1 TO WS-VAL
           ELSE
               PERFORM 0700-ERR-VAL-DEB
                  THRU 0700-ERR-VAL-FIN
           END-IF.
       0400-VAL-IDT-FIN.

       0500-VAL-QTE-DEB.
           IF WS-PIE-QTE <> 0 THEN
               ADD 10 TO WS-VAL
           ELSE
               PERFORM 0700-ERR-VAL-DEB
                  THRU 0700-ERR-VAL-FIN
           END-IF.
       0500-VAL-QTE-FIN.

       0600-VAL-ACT-DEB.
           IF (WS-PIE-ACT = 1 OR 2) THEN
               ADD 100 TO WS-VAL
               IF WS-PIE-ACT = 1 THEN
                  SET AJOUT TO TRUE
               ELSE
                  SET ENLEVER TO TRUE
               END-IF
           ELSE
               PERFORM 0700-ERR-VAL-DEB
                  THRU 0700-ERR-VAL-FIN
           END-IF.
       0600-VAL-ACT-FIN.

       0700-ERR-VAL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-VAL TO WS-MSG-ERR.
       0700-ERR-VAL-FIN.

       0800-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0800-AFF-ERR-CND-FIN.

       0900-SUC-MAJ-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-MAJ TO WS-MSG-ERR.
       0900-SUC-MAJ-FIN.

       1000-ERR-SQL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL TO WS-MSG-ERR.
       1000-ERR-SQL-FIN.
