      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet de saisir les paramètres nécessaires à        *
      * l’affichage des pièces en liste, comme le type de tri, le sens *
      * tri ou le numéro de la page. Ensuite il appel le programme     *
      * 'lir-pie' et afice les pièces retournées.                       *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AFF=AFFICHER                                                   *
      * ASC=Ascendant                                                  *
      * DEB=Debut                                                      *
      * DSC=Descandant                                                 *
      * FIN=Fin                                                        *
      * FOU=Fournisseur                                                *
      * IDX=Index                                                      *
      * IDT=Identité                                                   *
      * LIN=Line                                                       *
      * NOM=Nom                                                        *
      * ORD=Ordre                                                      *
      * PGE=PAGE                                                       *
      * PIE=PIECE                                                      *
      * PRM=Premier                                                    *
      * QTE=Quantité                                                   *
      * SNS=Sens                                                       *
      * SSI=Saisi                                                      *
      * SUI=Seuil                                                      *
      * TRE=Tré                                                        *
      * TBL=Tableau                                                    *
      * TRI=Trié                                                       *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpgpie.
       AUTHOR. Benoit.
       DATE-WRITTEN. 02-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TRI                PIC 9(01).
           88 WS-TRI-NOM                   VALUE 0.
           88 WS-TRI-QTE                   VALUE 1.
           88 WS-TRI-FOU                   VALUE 2.
       
       01 WS-SNS-TRI            PIC 9(01).
           88 WS-ASC                       VALUE 0.
           88 WS-DSC                       VALUE 1.

       77 WS-QTE                PIC 9(02). *> Min 1 - Max 25.
       77 WS-PGE                PIC 9(10). *> Min 0 - Max 1,000,000,000.
       77 WS-TRE                PIC X(78) VALUE ALL '_'.
       77 WS-ORD                PIC X(01).
       77 WS-LIN-QTE            PIC 9(02) VALUE 10.
       77 WS-LIN-PRM            PIC 9(02).
       77 WS-TBL-IDX            PIC 9(02).

       01 WS-VAL                PIC 9(02).
           88 WS-VAL-SUC                  VALUE 11.

       01  WS-CHX               PIC X(01).
           88 WS-CHX-VID                  VALUE " ".

      * Arguments de sortie.
       01 WS-TBL. 
           05 PIECE OCCURS 25 TIMES. *> Max quantité.
               10 WS-TBL-IDT      PIC 9(10).
               10 WS-TBL-NOM      PIC X(50).
               10 WS-TBL-QTE      PIC 9(10).
               10 WS-TBL-SUI      PIC 9(10).
               10 WS-TBL-NOM-FOU  PIC X(50).

       01 WS-MNU-ACT              PIC 9(01).
           88 WS-MNU-ACT-VID                VALUE 1.
           88 WS-MNU-ACT-PLN                VALUE 2.

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       01 WS-ERR-SQL            PIC X(76) VALUE
           "Une erreur est survenue lors de la requete".

       01 WS-SUC-LIR            PIC X(76) VALUE
           "La lecture s'est deroulee correctement".

       01 WS-SUC-LIR-N-ELM.
           05 FILLER               PIC X(39) VALUE 
               "La lecture s'est deroulee correctement ".
           05 WS-SUC-LIR-N-ELM-NBR PIC Z(01)9(01).
           05 FILLER               PIC X(09) VALUE " elements".

       01 WS-SUC-LIR-ZER-ELM.
           05 FILLER            PIC X(54) VALUE
               "La lecture s'est deroulee correctement, mais il n'y a ".
           05 FILLER            PIC X(13) VALUE "aucun element".

       01 WS-ERR-VAL          PIC X(76) VALUE "Erreur de validation".

       01 WS-LIN-ENT.
           05 FILLER              PIC X(10) VALUE "    ID    ".
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(22) VALUE 
               "         Nom          ".
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(10) VALUE " Quantite ".
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(10) VALUE "  Seuil   ".
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(22) VALUE
               "   Nom Fournisseur    ".

       01 WS-LIN-VID.
           05 FILLER              PIC X(10) VALUE ALL SPACE.
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(22) VALUE ALL SPACE.
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(10) VALUE ALL SPACE.
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(10) VALUE ALL SPACE.
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 FILLER              PIC X(22) VALUE ALL SPACE.

       01 WS-LIN-PLN.
           05 WS-LIN-PLN-IDT      PIC X(10).
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 WS-LIN-PLN-NOM-PIE  PIC X(22).
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 WS-LIN-PLN-QTT      PIC X(10).
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 WS-LIN-PLN-SEU      PIC X(10).
           05 FILLER              PIC X(01) VALUE ALL "|".
           05 WS-LIN-PLN-NOM-FOU  PIC X(22).

       COPY ctxerr.

       COPY utiglb.

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY ecrprn.
      *
      * LA maquette de l'ecran de saisi 
      *
       01  S-ECR-SSI-01.
           COPY ecrutlin.

           05 LINE 6.
               10 COL 3 VALUE                      'Option de tri [ ] : '
      -                      '1 - Nom   2 - Quantite   3 - Fournisseur'.
               10 COL 18 PIC 9(01) TO WS-TRI AUTO.
           05 LINE 7  COL 3  VALUE 
               'Ordre de tri  [ ] : A - Ascendant   D - Descendant'.
           05 LINE 7  COL 18 PIC X(01) TO WS-ORD AUTO.
           05 LINE 8 COL 2  PIC X(78) FROM WS-TRE.
           05 LINE 9 COL 2 FROM WS-LIN-VID.
           05 LINE 10 COL 2  FROM WS-LIN-ENT.
           05 LINE 11.
               10 COL 2  PIC X(78) FROM WS-TRE.
               10 COL 12 VALUE '|'.
               10 COL 35 VALUE '|'.
               10 COL 46 VALUE '|'.
               10 COL 57 VALUE '|'.
           05 LINE 22.
               10 COL 2  PIC X(78) FROM WS-TRE.
               10 COL 12 VALUE '|'.
               10 COL 35 VALUE '|'.
               10 COL 46 VALUE '|'.
               10 COL 57 VALUE '|'.
           05 LINE 23.
               10 COL 03 VALUE 'Choix de la page'.
               10 COL 20 VALUE '['.
               10 COL 21 PIC Z(10) TO WS-PGE.
               10 COL 31 VALUE ']'.
               10 COL 62 VALUE "Retour au menu".
               10 COL 77 VALUE "[".
               10 COL 78 PIC X(01) USING WS-CHX.
               10 COL 79 VALUE "]".

       01  S-ECR-SSI-02.
           05 LINE 12 COL 2 FROM WS-LIN-VID.
           05 LINE 13 COL 2 FROM WS-LIN-VID.
           05 LINE 14 COL 2 FROM WS-LIN-VID.
           05 LINE 15 COL 2 FROM WS-LIN-VID.
           05 LINE 16 COL 2 FROM WS-LIN-VID.
           05 LINE 17 COL 2 FROM WS-LIN-VID.
           05 LINE 18 COL 2 FROM WS-LIN-VID.
           05 LINE 19 COL 2 FROM WS-LIN-VID.
           05 LINE 20 COL 2 FROM WS-LIN-VID.
           05 LINE 21 COL 2 FROM WS-LIN-VID.

       01 S-MSG-ERR.
           05 LINE 05 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0100-BCL-DEB
              THRU 0100-BCL-DEB.

           EXIT PROGRAM.
       
       0100-BCL-DEB.
           SET WS-MNU-ACT-VID TO TRUE.
           SET WS-ETT-BCL-ENC TO TRUE.
           SET WS-CHX-VID     TO TRUE.

           PERFORM UNTIL WS-ETT-BCL-FIN
               PERFORM 0200-AFC-ECR-DEB
                  THRU 0200-AFC-ECR-FIN
               EVALUATE TRUE
                   WHEN WS-CHX-VID
                       MOVE 0 TO WS-VAL
                       PERFORM 0400-VAL-TRI-DEB
                          THRU 0400-VAL-TRI-FIN
                       PERFORM 0500-VAL-ORD-DEB
                          THRU 0500-VAL-ORD-FIN
                
                       IF WS-VAL-SUC THEN
                           PERFORM 0300-CAL-LIR-PIE-DEB
                              THRU 0300-CAL-LIR-PIE-FIN
                       ELSE
                           PERFORM 1100-ERR-VAL-DEB
                              THRU 1100-ERR-VAL-FIN
                           SET WS-MNU-ACT-VID TO TRUE
                       END-IF
                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE
               END-EVALUATE
           END-PERFORM.

       0100-BCL-FIN.

      *
      * Affichade de l'ecran de saisi
      *
       0200-AFC-ECR-DEB.
           DISPLAY S-FND-ECR.

           PERFORM 0600-AFF-MNU-ACT-DEB
              THRU 0600-AFF-MNU-ACT-FIN

           PERFORM 0800-AFF-ERR-CND-DEB
              THRU 0800-AFF-ERR-CND-FIN.

           ACCEPT S-ECR-SSI-01.
       0200-AFC-ECR-FIN.

      *
      * Paramètres d'options
      *
       0300-CAL-LIR-PIE-DEB.
           EVALUATE WS-TRI
               WHEN 1 
                   SET WS-TRI-NOM TO TRUE
               WHEN 2
                   SET WS-TRI-QTE TO TRUE
               WHEN 3 
                   SET WS-TRI-FOU TO TRUE
           END-EVALUATE.

           EVALUATE WS-ORD
               WHEN 'A'
                   SET WS-ASC TO TRUE
               WHEN 'D'
                   SET WS-DSC TO TRUE
           END-EVALUATE.

           MOVE WS-LIN-QTE TO WS-QTE.

           CALL "lirpie"
               USING
               WS-TRI,
               WS-SNS-TRI,
               WS-QTE,
               WS-PGE,
               WS-TBL,
               WS-LIR-RET
           END-CALL.

           EVALUATE TRUE
               WHEN WS-LIR-RET-OK
                   SET WS-MNU-ACT-PLN TO TRUE
                   PERFORM 1000-SUC-LIR-DEB
                      THRU 1000-SUC-LIR-FIN
               WHEN WS-LIR-RET-ERR
                   SET WS-MNU-ACT-VID TO TRUE
                   PERFORM 0900-ERR-SQL-DEB
                      THRU 0900-ERR-SQL-FIN
           END-EVALUATE.

       0300-CAL-LIR-PIE-FIN.

       0400-VAL-TRI-DEB.
           IF (WS-TRI = 1 OR 2 OR 3) THEN
               ADD 1 TO WS-VAL
           END-IF.
       0400-VAL-TRI-FIN.

       0500-VAL-ORD-DEB.
           IF (WS-ORD = 'A' OR 'a' OR 'D' OR 'd') THEN
               ADD 10 TO WS-VAL
           END-IF.
       0500-VAL-ORD-FIN.

       0600-AFF-MNU-ACT-DEB.
           EVALUATE TRUE
               WHEN WS-MNU-ACT-VID
                   DISPLAY S-ECR-SSI-02
               WHEN WS-MNU-ACT-PLN
                   DISPLAY S-ECR-SSI-02
                   PERFORM 0700-AFF-MNU-PLN-DEB
                      THRU 0700-AFF-MNU-PLN-FIN
           END-EVALUATE.
       0600-AFF-MNU-ACT-FIN.

       0700-AFF-MNU-PLN-DEB.
           MOVE 12 TO WS-LIN-PRM
           PERFORM VARYING WS-TBL-IDX FROM 1 BY 1
                   UNTIL   WS-TBL-IDX > WS-QTE    

               MOVE WS-TBL-IDT    (WS-TBL-IDX) TO WS-LIN-PLN-IDT
               MOVE WS-TBL-NOM    (WS-TBL-IDX) TO WS-LIN-PLN-NOM-PIE
               MOVE WS-TBL-QTE    (WS-TBL-IDX) TO WS-LIN-PLN-QTT
               MOVE WS-TBL-SUI    (WS-TBL-IDX) TO WS-LIN-PLN-SEU
               MOVE WS-TBL-NOM-FOU(WS-TBL-IDX) TO WS-LIN-PLN-NOM-FOU

               DISPLAY WS-LIN-PLN AT LINE WS-LIN-PRM COL 02
                   
               ADD 1 TO WS-LIN-PRM
           END-PERFORM.
       0700-AFF-MNU-PLN-FIN.
           
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

       1000-SUC-LIR-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           EVALUATE WS-QTE
               WHEN WS-LIN-QTE
                   MOVE WS-SUC-LIR TO WS-MSG-ERR

               WHEN 0
                   MOVE WS-SUC-LIR-ZER-ELM TO WS-MSG-ERR

               WHEN OTHER
                   MOVE WS-QTE TO WS-SUC-LIR-N-ELM-NBR
                   MOVE WS-SUC-LIR-N-ELM TO WS-MSG-ERR
           END-EVALUATE.
       1000-SUC-LIR-FIN.

       1100-ERR-VAL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-VAL TO WS-MSG-ERR.
       1100-ERR-VAL-FIN.
