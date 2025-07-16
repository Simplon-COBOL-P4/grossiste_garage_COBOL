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
       01 WS-CON1                 PIC 9(01) VALUE 1.
       01 WS-CON                  PIC 9(01).

      * Variable pour les appel de sous-programme.      
       01 WS-DAT                  PIC X(10).
       01 WS-STA                  PIC 9(01).
           88 STA-EN-CRS             VALUE 0.
           88 STA-TER                VALUE 1.
       01 WS-TYP                  PIC 9(01).
           88 TYP-ENT                 VALUE 0.
           88 TYP-SOR                 VALUE 1.
      * Identifiant fournisseur si entrante, et client si sortante.
       01 WS-IDT                  PIC 9(10).

      * Variable pour l'ajout de pièce dans la livraison(état 4).
       01 WS-IDT-LIV              PIC 9(10).
       01 WS-IDT-PIE              PIC 9(10).
       01 WS-QUA-PIE              PIC 9(10).

      * Le code d'erreur
       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

      *maquette
      * https://github.com/Simplon-COBOL-P4/grossiste_garage_COBOL/blob/maquette/Maquette/Livraisons/28-Ecran%20ajout%20livraisons.txt

      
      * Variable nécessaire en cas de livraison sortante pour récupérer
      * la quantité de pièce qu'il y a en stock.

      * Arguments de sortie.
       01 WS-NOM-PIE              PIC X(50).
       01 WS-QUA-PIE-SOR          PIC 9(10).
       01 WS-SEU-PIE              PIC 9(10).
       01 WS-ID-FOR               PIC 9(10).
       01 WS-NOM-FOR              PIC X(50).


       SCREEN SECTION.
       COPY ecrprn.

      * état 1
       01 S-ET1.
           05 LINE 06 COLUMN 03 VALUE 'Type de livraison'.
           05 LINE 09 COLUMN 03 VALUE 'Entree (0) / Sortie (1) : ['.
           05 LINE 09 COLUMN 31 VALUE ']'.
           05 LINE 09 COLUMN 30 PIC Z(01) TO WS-TYP.
           05 LINE 21 COLUMN 28 VALUE '1 - Suivant  0 - Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) TO WS-CON1.
           05 LINE 22 COLUMN 42 VALUE "]".

      * état 2, livraison entrante
       01 S-ET2.
           05 LINE 06 COLUMN 03 VALUE 'Livraison entrante'.
           05 LINE 08 COLUMN 03 VALUE 'ID fournisseur : ['.
           05 LINE 08 COLUMN 21 PIC Z(10) TO WS-IDT.
           05 LINE 08 COLUMN 31 VALUE ']'.
           05 LINE 09 COLUMN 03 VALUE "                               ".
           05 LINE 10 COLUMN 03 VALUE "Date livraison : [".
           05 LINE 10 COLUMN 31 VALUE ']'.
           05 LINE 10 COLUMN 21 PIC X(10) TO WS-DAT.
           05 LINE 12 COLUMN 03 VALUE "Statut (0/1) : [".
           05 LINE 12 COLUMN 20 VALUE "]".
           05 LINE 12 COLUMN 19 PIC Z(01) TO WS-STA.
           05 LINE 21 COLUMN 28 VALUE '1 - Suivant  0 - Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) TO WS-CON.
           05 LINE 22 COLUMN 42 VALUE "]".

      * état 3, livraison entrante
       01 S-ET3.
           05 LINE 06 COLUMN 03 VALUE 'Livraison sortante'.
           05 LINE 08 COLUMN 03 VALUE 'ID client :      ['.
           05 LINE 08 COLUMN 21 PIC Z(10) TO WS-IDT.
           05 LINE 08 COLUMN 31 VALUE ']'.
           05 LINE 09 COLUMN 03 VALUE "                               ".
           05 LINE 10 COLUMN 03 VALUE "Date livraison : [".
           05 LINE 10 COLUMN 31 VALUE ']'.
           05 LINE 10 COLUMN 21 PIC X(10) TO WS-DAT.
           05 LINE 12 COLUMN 03 VALUE "Statut (0/1) : [".
           05 LINE 12 COLUMN 20 VALUE "]".
           05 LINE 12 COLUMN 19 PIC Z(01) TO WS-STA.
           05 LINE 21 COLUMN 28 VALUE '1 - Suivant  0 - Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) TO WS-CON.
           05 LINE 22 COLUMN 42 VALUE "]".


       01 S-ET4.
           05 LINE 06 COLUMN 03 VALUE 'Piece de livraison'.
           05 LINE 08 COLUMN 03 VALUE 'ID piece : ['.
           05 LINE 08 COLUMN 15 PIC Z(10) TO WS-IDT-PIE.
           05 LINE 08 COLUMN 25 VALUE ']      '.
           05 LINE 10 COLUMN 03 VALUE "Quantite : [".
           05 LINE 10 COLUMN 25 VALUE ']      '.
           05 LINE 10 COLUMN 15 PIC X(10) TO WS-QUA-PIE.
           05 LINE 12 COLUMN 03 VALUE '                               '.
           05 LINE 21 COLUMN 28 VALUE '1 - Ajouter   2 - Terminer   0 - 
      -    'Annuler'.
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 41 PIC Z(01) TO WS-CON.
           05 LINE 22 COLUMN 42 VALUE "]".


       PROCEDURE DIVISION.

           PERFORM 0600-PRO-PRI-DEB
              THRU 0600-PRO-PRI-FIN.

           

           EXIT PROGRAM.


       0100-ET1-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ET1.
           ACCEPT S-ET1.
       0100-ET1-FIN.

       0200-ET2-DEB.
           DISPLAY S-ET2
           ACCEPT S-ET2
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
               WS-AJU-RET
      * Fin des arguments de sortie
               END-CALL
               IF WS-AJU-RET EQUAL 0
      * Pour récupérer l'id de la livraison.
                   PERFORM 0500-IDT-LIV-DEB
                      THRU 0500-IDT-LIV-FIN
                   PERFORM 0450-AJ-PIE-ENT-DEB
                      THRU 0450-AJ-PIE-ENT-FIN
               END-IF 
           END-IF.
       0200-ET2-FIN.

       0300-ET3-DEB.
           DISPLAY S-ET3.
           ACCEPT S-ET3.
      * Livraison sortante
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
               WS-AJU-RET
      * Fin des arguments de sortie
               END-CALL
               IF WS-AJU-RET EQUAL 0
      * Pour récupérer l'id de la livraison.
                   PERFORM 0500-IDT-LIV-DEB
                      THRU 0500-IDT-LIV-FIN
                   PERFORM 0400-AJ-PIE-DEB
                      THRU 0400-AJ-PIE-FIN
               END-IF 
           END-IF.
       0300-ET3-FIN.


      * Ce que l'on fait à l'état 4, que des pièces sortante donc
      * il faut faire attention au stock
       0400-AJ-PIE-DEB.

           PERFORM UNTIL WS-CON EQUAL 0 OR WS-CON EQUAL 2
               DISPLAY S-ET4
               ACCEPT S-ET4
               IF WS-CON EQUAL 1       
      * On regarde le stock de la pièce on a en stock        
                   CALL "liridpie"
                   USING
                   WS-IDT-PIE
                   WS-NOM-PIE
                   WS-QUA-PIE-SOR  
                   WS-SEU-PIE
                   WS-ID-FOR 
                   WS-NOM-FOR 
      * On vérifie que la livraison ne demande pas trop de pièce que 
      * l'on a pas en stock
                   IF WS-QUA-PIE-SOR EQUAL WS-QUA-PIE OR 
                   WS-QUA-PIE-SOR GREATER THAN WS-QUA-PIE
                       CALL "ajulivpi"
                       USING
                       WS-IDT-LIV
                       WS-IDT-PIE
                       WS-QUA-PIE
                       WS-AJU-RET
                       END-CALL
      * En cas de problème, on rollback immédiatement
                   IF WS-AJU-RET NOT EQUAL 0
                       EXEC SQL ROLLBACK WORK END-EXEC
                   END-IF
                   DISPLAY WS-QUA-PIE LINE 26 
                   DISPLAY WS-QUA-PIE-SOR LINE 27 
      * Il faudrait après le call mettre à jour la quantité dans la
      * base de donnée. Mais aucun sous-programme ne permet 
      * actuellement de le faire.
                   END-IF
               END-IF

           END-PERFORM.

           IF WS-CON EQUAL 2 
               EXEC SQL COMMIT WORK END-EXEC
           ELSE 
               EXEC SQL ROLLBACK WORK END-EXEC
           END-IF.
       0400-AJ-PIE-FIN.

      * Ce que l'on fait à l'état 4, il n'y a que des pièce entrantes
       0450-AJ-PIE-ENT-DEB.
           
           PERFORM UNTIL WS-CON EQUAL 0 OR WS-CON EQUAL 2
               DISPLAY S-ET4
               ACCEPT S-ET4
               IF WS-CON EQUAL 1       
                   CALL "ajulivpi"
                   USING
                   WS-IDT-LIV
                   WS-IDT-PIE
                   WS-QUA-PIE
                   WS-AJU-RET
                   END-CALL
      * En cas de problème, on rollback immédiatement
                   IF WS-AJU-RET NOT EQUAL 0
                       EXEC SQL ROLLBACK WORK END-EXEC
                   END-IF
               END-IF

           END-PERFORM.

           IF WS-CON EQUAL 2 
               EXEC SQL COMMIT WORK END-EXEC
           ELSE 
               EXEC SQL ROLLBACK WORK END-EXEC
           END-IF.

       0450-AJ-PIE-ENT-FIN.



       0500-IDT-LIV-DEB.
      * Comme ajuliv ne renvoie pas l'id de la dernière livraison,
      * on la récupère autrement.
      * On tri les livraisons par ordre descendant et on récupère le
      * premier qui arrive.
      
      *     EXEC SQL
      *     SELECT id_liv 
      *     INTO :WS-IDT-LIV
      *     FROM livraison
      *     ORDER BY id_liv DESC 
      *     LIMIT 1
      *     END-EXEC.

      * On suppose que la récupération de l'id de livraison se 
      * passe toujours bien.
           MOVE 5 TO WS-IDT-LIV.
       0500-IDT-LIV-FIN.

       0600-PRO-PRI-DEB.

           PERFORM UNTIL WS-CON1 EQUAL 0

               PERFORM 0100-ET1-DEB
                  THRU 0100-ET1-FIN
    
               IF WS-CON1 EQUAL 1
      * livraison entrante.
                   IF WS-TYP EQUAL 0
                       PERFORM 0200-ET2-DEB
                          THRU 0200-ET2-FIN
    
                   ELSE IF WS-TYP EQUAL 1
                       PERFORM 0300-ET3-DEB
                          THRU 0300-ET3-FIN
                       
                   END-IF
               END-IF

           END-PERFORM.
       0600-PRO-PRI-FIN.