      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet de saisir les paramètres nécessaires à        *
      * l’affichage des pièces en liste, comme le type de tri, le sens *
      * tri ou le numéro de la page. Ensuite il appel le programme     *
      * 'lirpie' et afice les pièces retournées.                       *
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
       PROGRAM-ID. affpie.
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
       77 WS-LIN-PRM            PIC 9(02) VALUE 14.
       77 WS-TBL-IDX            PIC 9(02).

      * Arguments de sortie.
       01 WS-TBL. 
           05 PIECE OCCURS 25 TIMES. *> Max quantité.
               10 WS-TBL-IDT      PIC 9(10).
               10 WS-TBL-NOM      PIC X(80).
               10 WS-TBL-QTE      PIC 9(10).
               10 WS-TBL-SUI      PIC 9(10).
               10 WS-TBL-NOM-FOU  PIC X(80).

       SCREEN SECTION.
       COPY ecrprn.
      *
      * LA maquette de l'ecran de saisi 
      *
       01  S-ECR-SSI-01.
           05 LINE 4  COL 3  VALUE 'Connecte en tant que : '.
           05 LINE 6  COL 3  VALUE '1 - trier par nom   2 - trier par '.
           05 LINE 6  COL 37 VALUE 'quantite   3 - trier par '.
           05 LINE 6  COL 62 VALUE 'fournisseur'.
           05 LINE 7  COL 3  VALUE 'Option de tri : [ ]'.
           05 LINE 7  COL 20 PIC 9(01) TO WS-TRI AUTO.
           05 LINE 8  COL 3  VALUE 'A - Ascendant   D - Descendant'.
           05 LINE 8  COL 50 VALUE 'PAGE'.
           05 LINE 9  COL 3  VALUE 'Ordre de tri  : [ ]'.
           05 LINE 9  COL  50 VALUE '[          ]'.
           05 LINE 9  COL 20 PIC X(01) TO WS-ORD AUTO.
           05 LINE 9  COL 51 PIC Z(10) TO WS-PGE AUTO.
           05 LINE 10 COL 2  PIC X(78) FROM WS-TRE.
           05 LINE 11 COL 12 VALUE '|                      |          '.
           05 LINE 11 COL 46 VALUE '|          |'.
           05 LINE 12 COL 3  VALUE 'ID       | Nom                  |'.
           05 LINE 12 COL 36 VALUE ' Quantite | Seuil    |'.
           05 LINE 12 COL 58 VALUE ' Nom Fournisseur      '.
           05 LINE 13 COL 2  PIC X(78) FROM WS-TRE.
           05 LINE 13 COL 12 VALUE '|'.
           05 LINE 13 COL 35 VALUE '|'.
           05 LINE 13 COL 46 VALUE '|'.
           05 LINE 13 COL 57 VALUE '|'.
           05 LINE 14 COL 12 VALUE '|                      |          '.
           05 LINE 14 COL 46 VALUE '|          |'.
           05 LINE 15 COL 12 VALUE '|                      |          '.
           05 LINE 15 COL 46 VALUE '|          |'.
           05 LINE 16 COL 12 VALUE '|                      |          '.
           05 LINE 16 COL 46 VALUE '|          |'.
           05 LINE 17 COL 12 VALUE '|                      |          '.
           05 LINE 17 COL 46 VALUE '|          |'.
           05 LINE 18 COL 12 VALUE '|                      |          '.
           05 LINE 18 COL 46 VALUE '|          |'.
           05 LINE 19 COL 12 VALUE '|                      |          '.
           05 LINE 19 COL 46 VALUE '|          |'.
           05 LINE 20 COL 12 VALUE '|                      |          '.
           05 LINE 20 COL 46 VALUE '|          |'.
           05 LINE 21 COL 12 VALUE '|                      |          '.
           05 LINE 21 COL 46 VALUE '|          |'.
           05 LINE 22 COL 12 VALUE '|                      |          '.
           05 LINE 22 COL 46 VALUE '|          |'.
           05 LINE 23 COL 12 VALUE '|                      |          '.
           05 LINE 23 COL 46 VALUE '|          |'.



       PROCEDURE DIVISION.

       PERFORM 0100-AFC-ECR-DEB
          THRU 0100-AFC-ECR-FIN.
       PERFORM 0200-SSI-ECR-DEB
          THRU 0200-SSI-ECR-FIN.
       PERFORM 0300-CAL-LIRPIE-DEB
          THRU 0300-CAL-LIRPIE-FIN.

       EXIT PROGRAM.
       
      *
      * Affichade de l'ecran de saisi
      *
       0100-AFC-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-SSI-01.
       0100-AFC-ECR-FIN.
           EXIT.

      *
      * Saisir dans l'ecran de saisi
      *
       0200-SSI-ECR-DEB.
           PERFORM UNTIL (WS-TRI = 1 oR 2 OR 3) AND (WS-ORD = 'A' OR 'a'
                   OR 'D' or 'd') AND (WS-PGE > 0 and < 1000000001)
                   ACCEPT S-ECR-SSI-01
           END-PERFORM.
       0200-SSI-ECR-FIN.
           EXIT.
      *
      * Paramètres d'options
      *
       0300-CAL-LIRPIE-DEB.
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
      *
      * Appeler lirpie pour collecter les données et les stocker dans 
      * le tableau WS-TABLEAU
      *
           CALL "lirpie"
                USING
                WS-TRI,
                WS-SNS-TRI,
                WS-QTE,
                WS-PGE,
                WS-TBL
            END-CALL.

      *
      * Afficher le tableau WS-TBL
      *
           PERFORM VARYING WS-TBL-IDX FROM 1 BY 1 UNTIL WS-TBL-IDX > 10
                                           OR WS-TBL-IDT(WS-TBL-IDX) = 0
             DISPLAY WS-TBL-IDT(WS-TBL-IDX) AT LINE WS-LIN-PRM COL 2
             DISPLAY WS-TBL-NOM(WS-TBL-IDX)(1:22) AT LINE WS-LIN-PRM COL
                                                                      13
             DISPLAY WS-TBL-QTE(WS-TBL-IDX) AT LINE WS-LIN-PRM COL 36
             DISPLAY WS-TBL-SUI(WS-TBL-IDX) AT LINE WS-LIN-PRM COL 47
             DISPLAY WS-TBL-NOM-FOU(WS-TBL-IDX)(1:22) AT LINE WS-LIN-PRM 
                                                                  COL 58
             ADD 1 TO WS-LIN-PRM
           END-PERFORM.
       0300-CAL-LIRPIE-FIN.
           EXIT.
           