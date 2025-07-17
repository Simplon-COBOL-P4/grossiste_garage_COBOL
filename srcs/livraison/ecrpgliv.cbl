      ******************************************************************
      *                             ENTÊTE                             *
      * Ecran d'affichage des livraisons par page et par filtre        *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; PG=PAGE; LIV=LIVRAISON; PGE=PAGE; NBR=NOMBRE;       *
      * ID=IDENTIFIANT; FOU=FOURNISSEUR; CLI=CLIENT; PIE=PIECE;        *
      * FLR=FILTRE; VID=VIDE; TAB=TABLEAU; DAT=DATE; STA=STATUT;       * 
      * TYP=TYPE; QTE=QUANTITE; LIN=LINE; ETA=ETAT; TRT=TRAIT;         *
      * RET=RETOUR; MNU=MENU; IDX=INDEX; ERR=ERROR; PRM=PARAMETRE;     * 
      * TET=TETE; SSI=SAISI; ACC=ACCEPTER; DEB=DEBUT;                  *
      * SPG= SOUS PROGRAMME                                            *    
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpgliv.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 15-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Arguments d'entrée.
       77 WS-PGE                          PIC 9(10).
       77 WS-NBR                          PIC 9(02)    VALUE 11.
       77 WS-ID-FOU-CLI-PIE               PIC 9(10).
       01 WS-FLR                          PIC 9(01).
           88 WS-FLR-VID                               VALUE 0.
           88 WS-FLR-FOU                               VALUE 1.
           88 WS-FLR-CLI                               VALUE 2.
           88 WS-FLR-PIE                               VALUE 3.
      * Arguments de sortie.
       01 WS-TAB.
           05 WS-LIV OCCURS 25 TIMES.
               10 WS-ID-LIV               PIC 9(10).
               10 WS-DAT-LIV              PIC X(10).
               10 WS-STA-LIV              PIC 9(01).
                   88 WS-STA-EN-COU                    VALUE 0.
                   88 WS-STA-TER                       VALUE 1.
               10 WS-TYP-LIV              PIC 9(01).
                   88 WS-TYP-ENT                       VALUE 0.
                   88 WS-TYP-SOR                       VALUE 1.
               10 WS-ID-FOU-CLI           PIC 9(10).
               10 WS-NOM-FOU-CLI          PIC X(50).
      * Attention à l'ambivalance de cet argument, il peut etre le
      * nombre de variete de pieces dans une livraison, comme le nombre
      * de piece de l'ID demandé dans la livraison. 
               10 WS-QTE-PIE              PIC 9(10).

      * Ligne vide de base du tableau
       01 WS-LIN-VID.
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(07)    VALUE SPACE.
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(17)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(08)    VALUE SPACE.  

      * Ligne vide du tableau en filtre vide et pièce
       01 WS-LIN-VID-ETA-1.   
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(07)    VALUE SPACE.
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(17)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(08)    VALUE SPACE.   

      * Ligne vide du tableau en filtre fournisseur et client
       01 WS-LIN-VID-ETA-2.   
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(36)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE SPACE.  
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(08)    VALUE SPACE.  
        
      * Ligne tiret de base du tableau   
       01 WS-LIN-TRT.   
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(07)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(17)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(08)    VALUE ALL "_". 

      * Ligne tiret du tableau en filtre vide et pièce
       01 WS-LIN-TRT-1.   
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(07)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(17)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(08)    VALUE ALL "_".  

      * Ligne vide du tableau en filtre fournisseur et client
       01 WS-LIN-TRT-2.   
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(36)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(10)    VALUE ALL "_".
           05 FILLER                      PIC X(01)    VALUE "|".
           05 FILLER                      PIC X(08)    VALUE ALL "_".         
        
       77 WS-RET-MNU                      PIC X(01)    VALUE SPACE.
       77 WS-TAB-IDX                      PIC 9(02).   
       77 WS-LIN-PRM                      PIC 9(02).   
       77 WS-TRT                          PIC X(78)    VALUE ALL '_'.
       77 WS-ERR                          PIC X(01).

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY ecrprn.

      * En tete du tableau pour le filtre vide et pièce
       01  S-ECR-TET-01.
           05 LINE 08 COL 03 VALUE '         |       |    ID    |
      -       'Nom       |          |          |        '.
           05 LINE 09 COL 03 VALUE 'ID       | Type  | cli/four |     cl
      -       'i/four    |  qtt pie |   date   | statut '.

      * En tete du tableau pour le filtre fournisseur
       01  S-ECR-TET-02.
           05 LINE 08 COL 03 VALUE '         |       
      -       '          |          |          |        '.
           05 LINE 09 COL 03 VALUE 'ID       |           Nom fournisseur      
      -       '          |  qtt pie |   date   | statut '.

      * En tête du tableau pour le filtre client
       01  S-ECR-TET-03.
           05 LINE 08 COL 03 VALUE '         |       
      -       '          |          |          |        '.
           05 LINE 09 COL 03 VALUE 'ID       |             Nom client      
      -       '          |  qtt pie |   date   | statut '.
      

       01  S-ECR-SSI-01.
           05 LINE 04 COL 03 VALUE 'Connecte en tant que : Admin'.
           05 LINE 05 COL 03 VALUE 'Pas de filtre (0), fournisseur (1), 
      -                            'client (2), piece (3)'.
           05 LINE 06 COL 03 VALUE 'Type de filtre : [ ]     ID : [_____
      -                            '_____]'.
           05 LINE 07 COL 02 PIC X(78) FROM WS-TRT.
           05 LINE 10 COL 02 PIC X(78) FROM WS-LIN-TRT.
           05 LINE 11 COL 02 FROM WS-LIN-VID.
           05 LINE 12 COL 02 FROM WS-LIN-VID.
           05 LINE 13 COL 02 FROM WS-LIN-VID.
           05 LINE 14 COL 02 FROM WS-LIN-VID.
           05 LINE 15 COL 02 FROM WS-LIN-VID.
           05 LINE 16 COL 02 FROM WS-LIN-VID.
           05 LINE 17 COL 02 FROM WS-LIN-VID.
           05 LINE 18 COL 02 FROM WS-LIN-VID.
           05 LINE 19 COL 02 FROM WS-LIN-VID.
           05 LINE 20 COL 02 FROM WS-LIN-VID.
           05 LINE 21 COL 02 FROM WS-LIN-VID.
           05 LINE 22 COL 02 PIC X(78) FROM WS-LIN-TRT.
           05 LINE 23 COL 03 VALUE 'Choix de la page [          ]'.
           05 LINE 23 COL 62 VALUE 'Retour au menu [ ]'.
       
       01  S-ECR-SSI-02.
           05 LINE 06 COL 21 PIC 9(01) TO WS-FLR AUTO.
           05 LINE 06 COL 34 PIC Z(10) TO WS-ID-FOU-CLI-PIE AUTO.
           05 LINE 23 COL 21 PIC Z(10) TO WS-PGE AUTO.
           05 LINE 23 COL 78 PIC X(01) TO WS-RET-MNU AUTO.

       PROCEDURE DIVISION.
       
           PERFORM 0100-ACC-ECR-DEB
              THRU 0100-ACC-ECR-FIN.
       
           EXIT PROGRAM.
                  
       0100-ACC-ECR-DEB.
      * Affichage de l'ecran
           DISPLAY S-FND-ECR.
           PERFORM 0400-SEL-FLR-DEB
              THRU 0400-SEL-FLR-FIN.
           DISPLAY S-ECR-SSI-01 
       
           PERFORM UNTIL WS-RET-MNU <> ' '  
      * Saisir le numéro de la page à afficher ou retour au menu
               ACCEPT S-ECR-SSI-02
               IF WS-RET-MNU = ' ' AND WS-PGE <> 0 THEN
      * Initialisé le tableau et appeler le sous programme lirepgliv.
      * Au retour, le tableau sera rempli de 11 enregistrement ou moins

                   PERFORM 0200-CAL-SPG-DEB
                      THRU 0200-CAL-SPG-FIN
                   IF  WS-LIR-RET = 0 THEN
      * Reinitialisé l'ecran
                       DISPLAY S-FND-ECR
                       PERFORM 0400-SEL-FLR-DEB
                          THRU 0400-SEL-FLR-FIN
                       DISPLAY S-ECR-SSI-01
      * Affiché le tableau
                       MOVE 11 TO WS-LIN-PRM
                       PERFORM 0300-AFC-FOU-DEB
                          THRU 0300-AFC-FOU-FIN
                   ELSE 
                       DISPLAY 'Erreur lors de la recuperation de la lis
      -            'te des livraisons. Retour au menu' AT LINE 23 COL 2
                       ACCEPT WS-ERR LINE 23 COL 78
                       EXIT PROGRAM

                   END-IF
               END-IF
           END-PERFORM.  
       0100-ACC-ECR-FIN.

       0200-CAL-SPG-DEB.
           CALL "lirpgliv"
               USING
      * Arguments d'entrée
               WS-PGE
               WS-NBR
               WS-ID-FOU-CLI-PIE
               WS-FLR
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-TAB
               WS-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

       0200-CAL-SPG-FIN.

       0300-AFC-FOU-DEB.
           PERFORM VARYING WS-TAB-IDX 
                   FROM 1 BY 1 UNTIL WS-ID-LIV(WS-TAB-IDX) = 0

               DISPLAY WS-ID-LIV(WS-TAB-IDX) 
               AT LINE WS-LIN-PRM COL 02

      *    Condition vérifiant dans quelle filtre pour l'affichage
               IF WS-FLR-VID OR WS-FLR-PIE
                   IF WS-TYP-ENT(WS-TAB-IDX)                                                       
                       DISPLAY "Entrant" 
                       AT LINE WS-LIN-PRM COL 13
                   ELSE 
                       DISPLAY "Sortant" 
                       AT LINE WS-LIN-PRM COL 13
                   END-IF    
      
                   DISPLAY WS-ID-FOU-CLI(WS-TAB-IDX)
                   AT LINE WS-LIN-PRM COL 21
      
                   DISPLAY WS-NOM-FOU-CLI(WS-TAB-IDX)(1:17) 
                   AT LINE WS-LIN-PRM COL 32
               ELSE 
                   DISPLAY WS-NOM-FOU-CLI(WS-TAB-IDX)(1:36) 
                   AT LINE WS-LIN-PRM COL 13
               END-IF    

               DISPLAY WS-QTE-PIE(WS-TAB-IDX) 
               AT LINE WS-LIN-PRM COL 50

               DISPLAY WS-DAT-LIV(WS-TAB-IDX) 
               AT LINE WS-LIN-PRM COL 61
  
               IF WS-STA-EN-COU(WS-TAB-IDX)                                                       
                   DISPLAY "En cours" 
                   AT LINE WS-LIN-PRM COL 72
               ELSE 
                   DISPLAY "Termine" 
                   AT LINE WS-LIN-PRM COL 72
               END-IF 

               ADD 1 TO WS-LIN-PRM
           END-PERFORM.

       0300-AFC-FOU-FIN.

       0400-SEL-FLR-DEB.
           EVALUATE TRUE
                   WHEN WS-FLR-VID
                        MOVE WS-LIN-VID-ETA-1 TO WS-LIN-VID
                        MOVE WS-LIN-TRT-1 TO WS-LIN-TRT
                        DISPLAY S-ECR-TET-01
                   WHEN WS-FLR-FOU
                        MOVE WS-LIN-VID-ETA-2 TO WS-LIN-VID
                        MOVE WS-LIN-TRT-2 TO WS-LIN-TRT
                        DISPLAY S-ECR-TET-02
                   WHEN WS-FLR-CLI
                        MOVE WS-LIN-VID-ETA-2 TO WS-LIN-VID
                        MOVE WS-LIN-TRT-2 TO WS-LIN-TRT
                        DISPLAY S-ECR-TET-03
                   WHEN WS-FLR-PIE
                        MOVE WS-LIN-VID-ETA-1 TO WS-LIN-VID
                        MOVE WS-LIN-TRT-1 TO WS-LIN-TRT
                        DISPLAY S-ECR-TET-01
                   WHEN OTHER
                        MOVE WS-LIN-VID-ETA-1 TO WS-LIN-VID
                        MOVE WS-LIN-TRT-1 TO WS-LIN-TRT
                        DISPLAY S-ECR-TET-01
           END-EVALUATE.
       0400-SEL-FLR-FIN.    

       