      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet à l’utilisateur de rentrer l’identifiant d’un *
      * client, afin de le supprimer.                                  *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRESSION; CLI=CLIENT; IDN=identifiant         *
      * CMD=commande; AFF=affichage; TRA=traitement                    *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspcli.
       AUTHOR. lucas.
       DATE-WRITTEN. 02-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDN          PIC 9(10).
       01 WS-CMD          PIC 9(01).

      * La maquette est 19-Ecran suppression clients.txt
       SCREEN SECTION.
       COPY "ecrprn".

       01 S-SP-CLI.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           05 LINE 06 COLUMN 25 VALUE "ID du client : [".
           05 LINE 06 COLUMN 51 VALUE "]".
           05 LINE 06 COLUMN 41 PIC Z(10) TO WS-IDN.

           05 LINE 21 COLUMN 30 VALUE "Supprimer le client ?".
           05 LINE 22 COLUMN 30 VALUE "1 - Oui   2 - Non ".
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
           DISPLAY S-SP-CLI.
       0100-AFF-ECR-FIN.

      * Paragraphe pour permettre à l'utilisateur d'entrer un id client
      * et de choisir s'il veut le supprimer ou non
       0200-TRA-CMD-DEB.
           PERFORM UNTIL WS-CMD EQUAL 1 OR WS-CMD EQUAL 2

           ACCEPT S-SP-CLI

           EVALUATE WS-CMD

           WHEN EQUAL 1
                 CALL "supcli" USING WS-IDN
                 END-CALL
           WHEN EQUAL 2 
                 DISPLAY "suppression annuler" LINE 18 COLUMN 30 
           WHEN OTHER
                 DISPLAY "commande incomprise" LINE 17 COLUMN 30 
           END-EVALUATE

           END-PERFORM.
       0200-TRA-CMD-FIN.