      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES :                         *
      * ECR=ECRAN; SUP/SP=SUPPRESSION; PIE=PIECE; IDF=IDENTIFIANT;     *
      * CHX=CHOIX; MSG=MESSSAGE; LEU=LEURRE; AFF=AFFICHE;              *
      *                                                                *
      *                     FONCTION DU PROGRAMME :                    *
      * IL PERMET À L'UTILISATEUR DE RENTRER L'IDENTIFIANT D'UNE PIÉCE *
      * POUR LA SUPPRIMER                                              *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrsppie.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 01-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDF-PIE       PIC 9(10).

       01  WS-CHX               PIC X(01).
           88 WS-CHX-VID                  VALUE " ".
       
       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       01 WS-ERR-SQL            PIC X(76) VALUE
           "Une erreur est survenue lors de la requete".

       01 WS-SUC-SUP            PIC X(76) VALUE
           "La suppression s'est deroulee correctement".

       COPY ctxerr.

       COPY utiglb.

       COPY supret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
           COPY ecrprn.

       01 S-ECR-SUP-PIE.
           COPY ecrutlin.

           05 LINE 08 COLUMN 22 VALUE "ID de la piece : ".
           05 LINE 08 COLUMN 39 VALUE "[".
           05 LINE 08 COLUMN 50 VALUE "]".
           05 LINE 08 COLUMN 40 PIC Z(10) TO WS-IDF-PIE.

           05 LINE 22.
               10 COLUMN 70 VALUE "Retour ".
               10 COLUMN 77 VALUE "[".
               10 COLUMN 78 PIC X(01) USING WS-CHX.
               10 COLUMN 79 VALUE "]".

       01 S-MSG-ERR.
           05 LINE 05 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0100-BCL-DEB
              THRU 0100-BCL-FIN.

           EXIT PROGRAM.

      ******************************************************************
      ***************************PARAGRAPHES**************************** 

       0100-BCL-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           SET WS-CHX-VID TO TRUE.

           PERFORM UNTIL WS-ETT-BCL-FIN
               PERFORM 0200-AFF-ECR-DEB
                  THRU 0200-AFF-ECR-FIN

               EVALUATE TRUE
                   WHEN WS-CHX-VID
                       PERFORM 0300-SUP-PIE-DEB
                          THRU 0300-SUP-PIE-FIN
                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE
               END-EVALUATE
           END-PERFORM.
       0100-BCL-FIN.

       0200-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.

           PERFORM 0800-AFF-ERR-CND-DEB
              THRU 0800-AFF-ERR-CND-FIN.

           ACCEPT  S-ECR-SUP-PIE.
       0200-AFF-ECR-FIN.

       0300-SUP-PIE-DEB.
           CALL "suppie"
               USING
               WS-IDF-PIE
               WS-SUP-RET
           END-CALL.

           EVALUATE TRUE
               WHEN WS-SUP-RET-OK
                   PERFORM 1000-SUC-SUP-DEB
                      THRU 1000-SUC-SUP-FIN
               WHEN OTHER
                   PERFORM 0900-ERR-SQL-DEB
                      THRU 0900-ERR-SQL-FIN
           END-EVALUATE.
       0300-SUP-PIE-FIN.

       0800-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0800-AFF-ERR-CND-FIN.

       0900-ERR-SQL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL TO WS-MSG-ERR.
       0900-ERR-SQL-FIN.

       1000-SUC-SUP-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-SUP TO WS-MSG-ERR.
       1000-SUC-SUP-FIN.
