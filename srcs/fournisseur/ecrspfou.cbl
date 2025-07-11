      ******************************************************************
      *                             ENTÊTE                             *
      * Ecran de suppression d'un fournisseur                          *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRESSION; FOU=FOURNISSEUR; ID=IDENTIFIANT;    *
      * CMD=COMMANDE; AFF=AFFICHER; ECR=ECRAN; DEB=DEBUT; FND=FOND;    *
      * LEC=LECTURE; RET=RETOUR;                                       *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspfou.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ID          PIC 9(10).
       77 WS-CMD         PIC 9(01).

       COPY supret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY "ecrprn".

       01 S-SP-FOU.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           05 LINE 06 COLUMN 25 VALUE "ID du fournisseur : [".
           05 LINE 06 COLUMN 56 VALUE "]".
           05 LINE 06 COLUMN 46 PIC Z(10) TO WS-ID.

           05 LINE 21 COLUMN 30 VALUE "Supprimer fournisseur ?".
           05 LINE 22 COLUMN 30 VALUE "1 - Supprimer   0 - Annuler".
           05 LINE 23 COLUMN 37 VALUE "[ ]".
           05 LINE 23 COLUMN 38 PIC Z TO WS-CMD.

       PROCEDURE DIVISION.

           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-LEC-CMD-DEB
              THRU 0200-LEC-CMD-FIN.   

           EXIT PROGRAM.


      * Paragraphe pour afficher l'écran.    
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-SP-FOU.
       0100-AFF-ECR-FIN.    

      * Paragraphe pour permettre à l'utilisateur d'entrer un id 
      * fournisseur et de choisir s'il veut le supprimer ou non
       0200-LEC-CMD-DEB.
           MOVE 2 TO WS-CMD.
           PERFORM UNTIL WS-CMD = 0
               ACCEPT S-SP-FOU
               EVALUATE WS-CMD
                   WHEN 1
                       IF WS-ID = 0
                           DISPLAY "Identifiant incorrect." 
                           LINE 15 COLUMN 10
                       ELSE  
                           CALL "supfou"
                               USING
                               WS-ID
                               WS-SUP-RET
                           END-CALL
                           DISPLAY "Fournisseur supprimé" 
                           LINE 15 COLUMN 10
                       END-IF
                       
                   WHEN 0
                       DISPLAY "Annulation utilisateur." 
                       LINE 15 COLUMN 10
      
                   WHEN OTHER
                       DISPLAY "Commande incomprise." LINE 15 COLUMN 10
               END-EVALUATE
           END-PERFORM.
       0200-LEC-CMD-FIN.
           
           