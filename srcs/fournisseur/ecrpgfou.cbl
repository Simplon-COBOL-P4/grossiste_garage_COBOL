      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet d'afficher les fournisseurs en liste, permet  *
      * de saisir le numéro de la page. Il faut donc ensuite appeler   *
      * lirpgfou, et afficher les fournisseurs retournés.              *
      * À noter qu’il faut calculer le nombre de lignes disponibles sur*
      * l'écran pour choisir la quantité à demander au sous programme. *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ACC=Accept                                                     *
      * ADR=Adresse                                                    *
      * AFC=Affiché                                                    *
      * CAL=Call                                                       *
      * CDP=Code Postale                                               *
      * DEB=Début                                                      *
      * IDX=INDEX                                                      *
      * ECR=ECRAN                                                      *
      * EML=Email                                                      *
      * ERR=Erreur                                                     *
      * FIN=Fin                                                        *
      * FOU=Fournisseur                                                *
      * IDT=Identité                                                   *
      * IDX=INDEX                                                      *
      * INX=Indic                                                      *
      * MNU=Menu                                                       *
      * NOM=Nom                                                        *
      * PGE=PAGE                                                       *
      * FOU=FOURNISSEUR                                                *
      * LIN=Ligne                                                      *
      * LIR=Lire                                                       *
      * PRM=Premier                                                    *
      * QTE=Quantite                                                   *
      * RET=RETOUR                                                     *
      * SPG=Sous Programme                                             *
      * SSI=Saisi                                                      *
      * TBL=Tableau                                                    *
      * TEL=Téléphone                                                  *
      * VIL=Ville                                                      *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpgfou.
       AUTHOR. Benoit.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Arguments d'entrée.
       77 WS-TRT                 PIC X(78) VALUE ALL '_'.
       77 WS-RET-MNU             PIC X(01) VALUE SPACE.
       77 WS-QTE                 PIC 9(02) VALUE 12. *> Min 1 - Max 25.
       77 WS-PGE                 PIC 9(10). *> Min 0 - Max 1,000,000,000
       77 WS-ERR                 PIC X(01).
       77 WS-TBL-IDX             PIC 9(02).
       77 WS-LIN-PRM             PIC 9(02).

       77 WS-DUMMY                  PIC X.
       
      * Arguments de sortie.
       01 WS-TBL.
           05 FOURNISSEUR OCCURS 25 TIMES.
               10 WS-TBL-IDT     PIC 9(10).
               10 WS-TBL-NOM     PIC X(50).
               10 WS-TBL-ADR     PIC X(50).
               10 WS-TBL-VIL     PIC X(50).
               10 WS-TBL-CDP     PIC 9(05).
               10 WS-TBL-IND     PIC 9(03).
               10 WS-TBL-TEL     PIC 9(10).
               10 WS-TBL-EML     PIC X(50).

       01 WS-COL-VID.
           05 FILLER             PIC X(10) VALUE SPACE. *> ID
           05 FILLER             PIC X(01) VALUE "|".   
           05 FILLER             PIC X(11) VALUE SPACE. *> Nom
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(10) VALUE SPACE. *> Adresse
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(10) VALUE SPACE. *> Ville
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(05) VALUE SPACE. *> Code postal
           05 FILLER             PIC X(01) VALUE "|".
      * 4 caracteres pour l'indicatif, en comptant le prefixe '+'.
           05 FILLER             PIC X(04) VALUE SPACE. *> Indicatif
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(10) VALUE SPACE. *> Téléphone
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(11) VALUE SPACE. *> Mail

       1 WS-COL-TRT.
           05 FILLER             PIC X(10) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(11) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(10) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(10) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(05) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
      * 4 caracteres pour l'indicatif, en comptant le prefixe '+'.
           05 FILLER             PIC X(04) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(10) VALUE ALL "-".
           05 FILLER             PIC X(01) VALUE "|".
           05 FILLER             PIC X(11) VALUE ALL "-".
           
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       SCREEN SECTION.
       COPY ecrprn.
       01  S-ECR-SSI-01.
           05 LINE 04 COL 03 VALUE 'Connecte en tant que : Admin'.
           05 LINE 06 COL 02 PIC X(78) FROM WS-TRT.
           05 LINE 07 COL 02 FROM WS-COL-VID.
           05 LINE 08 COL 03 VALUE 'ID       |  NOM      | Adresse  |   
      -       'Ville  | CP  |INDC|Telephone |  EMAIL    '.
           05 LINE 09 COL 02 PIC X(78) FROM WS-COL-TRT.
           05 LINE 10 COL 02 FROM WS-COL-VID.
           05 LINE 11 COL 02 FROM WS-COL-VID.
           05 LINE 12 COL 02 FROM WS-COL-VID.
           05 LINE 13 COL 02 FROM WS-COL-VID.
           05 LINE 14 COL 02 FROM WS-COL-VID.
           05 LINE 15 COL 02 FROM WS-COL-VID.
           05 LINE 16 COL 02 FROM WS-COL-VID.
           05 LINE 17 COL 02 FROM WS-COL-VID.
           05 LINE 18 COL 02 FROM WS-COL-VID.
           05 LINE 19 COL 02 FROM WS-COL-VID.
           05 LINE 20 COL 02 FROM WS-COL-VID.
           05 LINE 21 COL 02 FROM WS-COL-VID.
           05 LINE 22 COL 02 PIC X(78) FROM WS-COL-TRT.
           05 LINE 23 COL 03 VALUE 'Choix de la page [          ]'.
           05 LINE 23 COL 62 VALUE 'Retour au menu [ ]'.
       
       01  S-ECR-SSI-02.
           05 LINE 23 COL 21 PIC Z(10) TO WS-PGE AUTO.
           05 LINE 23 COL 78 PIC X(01) TO WS-RET-MNU AUTO.

       PROCEDURE DIVISION.
           PERFORM 0100-ACC-ECR-DEB
              THRU 0100-ACC-ECR-FIN.
       
           EXIT PROGRAM.
                  
       0100-ACC-ECR-DEB.
      *
      * Affichage de l'ecran
      * 
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-SSI-01.
       
           PERFORM UNTIL WS-RET-MNU <> ' '
      *
      * Saisir le numéro de la page à afficher ou retour au menu
      *
               ACCEPT S-ECR-SSI-02
               IF WS-RET-MNU = ' ' AND WS-PGE <> 0 THEN
      *
      * Initialisé le tableau et appeler le sous programme lirepgcli.
      * Au retour, le tableau sera rempli de 12 enregistrement ou moins
      *
                   INITIALIZE WS-TBL

                   PERFORM 0200-CAL-SPG-DEB
                      THRU 0200-CAL-SPG-FIN
                   IF  LK-LIR-RET = 0 THEN
      *
      * Reinitialisé l'ecran
      *
                       DISPLAY S-FND-ECR
                       DISPLAY S-ECR-SSI-01
      *
      * Affiché le tableau
      *          
                       MOVE 10 TO WS-LIN-PRM
                       PERFORM 0300-AFC-FOU-DEB
                          THRU 0300-AFC-FOU-FIN
                   ELSE 
                       DISPLAY 'Erreur lors de la recuperation de la lis
      -            't des fournisseurs. Retour au menu' AT LINE 23 COL 2
                       ACCEPT WS-ERR LINE 23 COL 78
                       EXIT PROGRAM
      *Replace STOP RUN by
      *               EXIT PROGRAM 

                   END-IF
               END-IF
           END-PERFORM.  
       0100-ACC-ECR-FIN.
           EXIT.

       0200-CAL-SPG-DEB.
           CALL "lirpgfou"
               USING
      * Arguments d'entrée
               WS-PGE
               WS-QTE
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-TBL
               LK-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

       0200-CAL-SPG-FIN.
           EXIT.

       0300-AFC-FOU-DEB.
           PERFORM VARYING WS-TBL-IDX 
                   FROM 1 BY 1 UNTIL WS-TBL-IDX > WS-QTE OR 
                                     WS-TBL-IDT(WS-TBL-IDX) = 0

               DISPLAY WS-TBL-IDT(WS-TBL-IDX) 
               AT LINE WS-LIN-PRM COL 02
                                                                      
               DISPLAY WS-TBL-NOM(WS-TBL-IDX)(1:11) 
               AT LINE WS-LIN-PRM COL 13

               DISPLAY WS-TBL-ADR(WS-TBL-IDX)(1:10) 
               AT LINE WS-LIN-PRM COL 25

               DISPLAY WS-TBL-VIL(WS-TBL-IDX)(1:10) 
               AT LINE WS-LIN-PRM COL 36

               DISPLAY WS-TBL-CDP(WS-TBL-IDX) 
               AT LINE WS-LIN-PRM COL 47

               DISPLAY WS-TBL-IND(WS-TBL-IDX) 
               AT LINE WS-LIN-PRM COL 53
  
               DISPLAY WS-TBL-TEL(WS-TBL-IDX) 
               AT LINE WS-LIN-PRM COL 58
  
               DISPLAY WS-TBL-EML(WS-TBL-IDX)(1:11) 
               AT LINE WS-LIN-PRM COL 69

               ADD 1 TO WS-LIN-PRM
           END-PERFORM.

       0300-AFC-FOU-FIN.
           EXIT.
