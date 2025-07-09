      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRIMER; LIV=LIVRAISON;                        *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ID                   PIC 9(10).
       01 WS-DAT                  PIC X(10).
       01 WS-STA                  PIC 9(01).
           88 WS-STA-EN-COU       VALUE 0.
           88 WS-STA-TER          VALUE 1.
       01 WS-TYP                  PIC 9(01).
           88 WS-TYP-ENT          VALUE 0.
           88 WS-TYP-SOR          VALUE 1.
      * WS-ID et WS-NOM fournisseur si entrante,
      * et client si sortante.
       01 WS-ID-SOR               PIC 9(10).
       01 WS-NOM-SOR              PIC X(50).
       01 WS-CMD                  PIC 9(01).
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY "ecrprn".

       01 S-SP-LIV.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           05 LINE 06 COLUMN 25 VALUE "ID du client : [".
           05 LINE 06 COLUMN 51 VALUE "]".
           05 LINE 06 COLUMN 41 PIC Z(10) TO WS-ID.

           05 LINE 22 COLUMN 30 VALUE "1 - Supprimer   0 - Annuler".
           05 LINE 23 COLUMN 37 VALUE "[ ]".
           05 LINE 23 COLUMN 38 PIC Z TO WS-CMD.

       PROCEDURE DIVISION.

           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-TRA-CMD-DEB
              THRU 0200-TRA-CMD-FIN.   

           EXIT PROGRAM.


      * Paragraphe pour afficher l'écran.    
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-SP-LIV.
       0100-AFF-ECR-FIN.    

      * Paragraphe pour permettre à l'utilisateur d'entrer un id client
      * et de choisir s'il veut le supprimer ou non
       0200-TRA-CMD-DEB.
           PERFORM UNTIL WS-CMD

               ACCEPT S-SP-LIV
            
               EVALUATE WS-CMD
            
                   WHEN EQUAL 1
                       CALL "liridliv"
                           USING
                           WS-ID
                           WS-DAT
                           WS-STA
                           WS-TYP
                           WS-ID-SOR
                           WS-NOM-SOR
                           WS-LIR-RET
                       END-CALL.

      * Avant de supprimer une livraison, vérifier qu'elle est bien
      * en cours.
                       
                       IF WS-STA-EN-COU
      * Dans le cas d'une livraison sortante, inverser les operations
      * avant de la supprimer.

                           IF WS-TYP-SOR

                               
                              
                           END-IF
           
                           CALL "supliv"
                               USING
                               WS-ID
                           END-CALL.

                       END-IF

                   WHEN EQUAL 0 

                   WHEN OTHER
                       DISPLAY "commande incomprise" LINE 17 COLUMN 30 

               END-EVALUATE

           END-PERFORM.
       0200-TRA-CMD-FIN. 