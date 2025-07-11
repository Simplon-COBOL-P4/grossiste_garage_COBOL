      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet à l’utilisateur de rentrer les différents     *
      * arguments nécessaire à la mise à jour d’un fournisseur.        *                                                       *
      * L’utilisateur rentre l’ID du fournisseur, puis appuie sur      *
      * entrée. Cela appelle le sous programme liridfou, qui récupère  *
      * les informations du fournisseur, en fonction de l’ID.          *
      * Suite à cela, il faut afficher les informations récupérées, ce *
      * qui donne à l’utilisateur la possibilité de les modifier, avant*
      * de valider, ce qui appelle le sous programme majfou.           *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ADR=Adresse                                                    *
      * AFC=Afficher                                                   *
      * CDP=Code Postale                                               *
      * CHO=Choix                                                      *
      * ECR=ECRAN                                                      *
      * EML=Email                                                      *
      * ERR=Erreur                                                     *
      * FET-Fetch                                                      *
      * FOU=FOURNISSEUR                                                *
      * IDT=Identité                                                   *
      * ITL=Indicatif Téléphone                                        *
      * MJ =MISE A JOUR                                                *
      * MOD=Modifier                                                   *
      * NOM=Nom                                                        *
      * SSI=Saisi                                                      *
      * TEL=Téléphone                                                  *
      * Vil=Ville                                                      *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjfou.
       AUTHOR. Benoit.
       DATE-WRITTEN. 10-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDT-FOU               PIC 9(10).
       01 WS-NOM-FOU               PIC X(50).
       01 WS-ADR-FOU               PIC X(50).
       01 WS-VIL-FOU               PIC X(50).
       01 WS-CDP-FOU               PIC 9(05).
       01 WS-ITL-FOU               PIC 9(03).
       01 WS-TEL-FOU               PIC 9(10).
       01 WS-EML-FOU               PIC X(50).
       01 WS-COD-RET               PIC 9(01).

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

       77 WS-CHO                   PIC X(01).
       77 WS-ERR                   PIC X(01).

       SCREEN SECTION.
       COPY ecrprn.

       01  S-SSI-FOU.
           05 LINE 04 COL 03 VALUE 'Connecte en tant que : Admin'.
           05 LINE 06 COL 19 VALUE 
                                'ID du fournisseur : [          ]'.
           05 LINE 08 COL 03 VALUE 'Nom :'.
           05 LINE 09 COL 03 VALUE '['.
           05 LINE 09 COL 54 VALUE ']'.
           05 LINE 10 COL 03 VALUE 'Email :'.
           05 LINE 11 COL 03 VALUE '['.
           05 LINE 11 COL 54 VALUE ']'.
           05 LINE 12 COL 03 VALUE 'Indicatif / Telephone :'.
           05 LINE 13 COL 03 VALUE '[+'.
           05 LINE 13 COL 19 VALUE ']'.
           05 LINE 14 COL 03 VALUE 'Adresse :'.
           05 LINE 15 COL 03 VALUE '['.
           05 LINE 15 COL 54 VALUE ']'.
           05 LINE 16 COL 03 VALUE 'Ville :'.
           05 LINE 17 COL 03 VALUE '['.
           05 LINE 17 COL 54 VALUE ']'.
           05 LINE 18 COL 03 VALUE 'Code postal :'.
           05 LINE 19 COL 03 VALUE '['.
           05 LINE 19 COL 09 VALUE ']'.
           05 LINE 21 COL 29 VALUE 'Confirmer modifications ?'.
           05 LINE 22 COL 32 VALUE '1 - Oui   0 - Annuler'.
           05 LINE 23 COL 39 VALUE '[ ]'.

       01  S-SSI-IDT-FOU.
           05 LINE 06 COL 40 PIC Z(10) TO WS-IDT-FOU.

       01  S-MOD-INF-FOU.
           05 LINE 09 COL 04 PIC X(50) USING WS-NOM-FOU AUTO.
           05 LINE 11 COL 04 PIC X(50) USING WS-EML-FOU AUTO.
           05 LINE 13 COL 05 PIC 9(03) USING WS-ITL-FOU AUTO.
           05 LINE 13 COL 09 PIC 9(10) USING WS-TEL-FOU AUTO.
           05 LINE 15 COL 04 PIC X(50) USING WS-ADR-FOU AUTO.
           05 LINE 17 COL 04 PIC X(50) USING WS-VIL-FOU AUTO.
           05 LINE 19 COL 04 PIC 9(05) USING WS-CDP-FOU AUTO.
           05 LINE 23 COL 40 PIC X(01) TO WS-CHO.

       PROCEDURE DIVISION.

           PERFORM 0100-AFC-ECR-DEB
              THRU 0100-AFC-ECR-FIN.
           PERFORM 0200-SSI-IDT-FOU-DEB
              THRU 0200-SSI-IDT-FOU-FIN.
           PERFORM 0300-FET-INF-FOU-DEB
              THRU 0300-FET-INF-FOU-FIN.
           PERFORM 0400-MOD-INF-FOU-DEB
              THRU 0400-MOD-INF-FOU-FIN.
           EXIT PROGRAM.

      * Affiche l'ecran de saisi
       0100-AFC-ECR-DEB.    
           DISPLAY S-FND-ECR.
           DISPLAY S-SSI-FOU.
       0100-AFC-ECR-FIN.
           EXIT.
           
       0200-SSI-IDT-FOU-DEB.
           PERFORM UNTIL WS-IDT-FOU <> 0
               ACCEPT S-SSI-IDT-FOU
           END-PERFORM.
       0200-SSI-IDT-FOU-FIN.
           EXIT.

       0300-FET-INF-FOU-DEB.
           CALL "liridfou"
               USING
      * Arguments d'entree.
               WS-IDT-FOU
      * Arguments de sortie.
               WS-NOM-FOU
               WS-ADR-FOU
               WS-VIL-FOU
               WS-CDP-FOU
               WS-ITL-FOU
               WS-TEL-FOU
               WS-EML-FOU
               WS-LIR-RET
           END-CALL.

           IF  WS-LIR-RET <> 0 THEN
               DISPLAY 'Fournisseur non trouve' AT LINE 23 COL 2
               ACCEPT WS-ERR AT LINE 23 COL 24
               EXIT PROGRAM
           END-IF.

       0300-FET-INF-FOU-FIN.
           EXIT.

       0400-MOD-INF-FOU-DEB.
           PERFORM UNTIL WS-CHO = '1' OR '0'
               ACCEPT S-MOD-INF-FOU
               EVALUATE WS-CHO
                   WHEN '1'
                       CALL "majfou"
                           USING
                           WS-IDT-FOU
                           WS-NOM-FOU
                           WS-ADR-FOU
                           WS-VIL-FOU
                           WS-CDP-FOU
                           WS-ITL-FOU
                           WS-TEL-FOU
                           WS-EML-FOU
                           WS-MAJ-RET
                       END-CALL
                       IF  WS-MAJ-RET <> 0 THEN
                           DISPLAY 'Echec de la mise a jour' AT LINE 23
                                                                   COL 2
                           ACCEPT WS-ERR AT LINE 23 COL 25
                           EXIT PROGRAM
                       ELSE 
                           DISPLAY 'Mise a jour terminee' AT LINE 23 COL
                                                                       2
                           ACCEPT WS-ERR AT LINE 23 COL 22
                       END-IF
                   WHEN '0'
                       DISPLAY 'Mise a jour annulee' AT LINE 23 COL 2
                       ACCEPT WS-ERR AT LINE 23 COL 21
                   WHEN OTHER
                       DISPLAY "Veuillez confirmer par '1' ou '0'" AT 
                                                           LINE 23 COL 2
                       ACCEPT WS-ERR AT LINE 23 COL 35
                       DISPLAY '                                  ' AT
                                                           LINE 23 COL 2
               END-EVALUATE
           END-PERFORM. 

       0400-MOD-INF-FOU-FIN.
           EXIT.
