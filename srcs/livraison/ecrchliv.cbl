      ******************************************************************
      *                             ENTÊTE                             *
      * C'est un sous-programme pour choisir quel affichage de         *
      * livraison, par affichage unique ou la liste complète.          *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN ; CH=CHOIX; FOU=FOURNISSEUR; CHX=CHOIX; MEN=MENU;    *
      * AFF=AFFICHER; ROL=ROLE; UTI=UTILISATEUR                        *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchliv.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CHX            PIC 9(01).
       01  WS-ROL-UTI        PIC X(10)   VALUE "ADMIN".
       
       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-CHX-FOU.
        05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : ".
        05 LINE 04 COLUMN 26 PIC X(10) FROM WS-ROL-UTI. 

        05 LINE 09 COLUMN 30 VALUE "Afficher :".
        05 LINE 13 COLUMN 30 VALUE "1 - Une livraison".
        05 LINE 14 COLUMN 30 VALUE "2 - La liste complete".
        05 LINE 19 COLUMN 30 VALUE "0 - Retour au menu".
        05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : [".
        05 LINE 22 COLUMN 53 VALUE "]".

        05 LINE 22 COLUMN 52 TO WS-CHX.


       PROCEDURE DIVISION.
           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-CHX-MEN-DEB
              THRU 0200-CHX-MEN-FIN.

           EXIT PROGRAM.

      *    Affichage de l'ecran et demande à l'utilisateur sa commande.
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-CHX-FOU.
       0100-AFF-ECR-FIN.

      *    Traitement de la commande entree par l'utilisateur.
       0200-CHX-MEN-DEB.
           MOVE 3 TO WS-CHX
           PERFORM UNTIL WS-CHX EQUAL 0
               ACCEPT S-ECR-CHX-FOU
               EVALUATE WS-CHX
                   WHEN "1"
      *    Ecran d'affichage unique de livraison         
                       CALL "ecridliv"
                       END-CALL
            
      *    Ecran d'affichage de plusieurs livraison  
                   WHEN "2"
                       CALL "ecrpgliv"
                       END-CALL
            
                   WHEN 0
                       EXIT PROGRAM
            
                   WHEN OTHER
                       DISPLAY "Entrer un des choix disponibles"
                       AT LINE 21 COLUMN 3
               END-EVALUATE
           END-PERFORM.

       0200-CHX-MEN-FIN.
            
