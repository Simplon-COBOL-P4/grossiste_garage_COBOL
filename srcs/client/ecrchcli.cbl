      ******************************************************************
      *                             ENTÊTE                             *
      * Programme pour permettre   à l’utilisateur de choisir de quelle*
      * manière il souhaite lire les clients, soit via une recherche   *
      * par nom/ID, soit en les affichant par page.                    *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ecran; CH=choix; CLI=client; PRN=principal; FND=fond;      *
      * CON=condition; TRA=traitement; COM=commande; LEC=lecture.      *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchcli.
       AUTHOR. lucas.
       DATE-WRITTEN. 01-07-2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 WS-CON PIC 9(01).

       SCREEN SECTION.
      * Voir maquette 15-Ecran choix lecture clients.txt.
       COPY ecrprn.

       01 S-ECR-LEC-CLI.
          
           05 LINE 02 COLUMN 03 VALUE "Connecte en tant que:".

           05 LINE 09 COLUMN 30 VALUE "Afficher : ".
          
           05 LINE 13 COLUMN 30 VALUE "1 - Un client".

           05 LINE 14 COLUMN 30 VALUE "2 - La liste complete".

           05 LINE 19 COLUMN 30 VALUE "0 - Retour au menu ".
           
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : [_]".
           05 LINE 22 COLUMN 52 PIC Z TO WS-CON.

       PROCEDURE DIVISION.

           PERFORM 0100-ECR-DEB
              THRU 0100-ECR-FIN.

           PERFORM 0200-TRA-COM-DEB
              THRU 0200-TRA-COM-FIN.
           
           EXIT PROGRAM.

      * Affichage de l'écran et demande à l'utilisateur sa commande.
       0100-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-LEC-CLI.

       0100-ECR-FIN.

      * Traitement de la commande entrée par l'utilisateur.
       0200-TRA-COM-DEB.
           PERFORM UNTIL WS-CON EQUAL 1 OR WS-CON EQUAL 2
              ACCEPT S-ECR-LEC-CLI
              EVALUATE WS-CON
                  
                 WHEN EQUAL 1
                    CALL "ecrrecli"
                    END-CALL
          
                  WHEN EQUAL 2
                    CALL "ecrpgcli"
                    END-CALL 
                  WHEN OTHER 
                    DISPLAY "entrer 1 ou 2" LINE 21 COLUMN 3  
              END-EVALUATE
           END-PERFORM.
       0200-TRA-COM-FIN.
       