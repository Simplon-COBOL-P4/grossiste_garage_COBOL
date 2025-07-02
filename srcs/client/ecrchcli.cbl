      ******************************************************************
      *                             ENTÊTE                             *
      * Programme pour permettre   à l’utilisateur de choisir de quelle*
      * manière il souhaite lire les clients, soit via une recherche   *
      * par nom/ID, soit en les affichant par page.                    *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; CH=CHOIX; CLI=CLIENT; PRINCIPAL=PRN; FOND=FND;      *
      * CON=condition; TRA=traitement; COM=commande                    *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchcli.
       AUTHOR. lucas.
       DATE-WRITTEN. 01/07/2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 WS-CON PIC 9 VALUE 0.

       SCREEN SECTION.

      * Voir maquette 15-Ecran choix lecture clients.txt
       01 S-FND-ECR.
           05 BLANK SCREEN.

           05 LINE 01 COLUMN 01 VALUE "+--------------------------------
      -    "----------------------------------------------+".

           05 LINE 02 COLUMN 01 VALUE "|".
           05 LINE 02 COLUMN 33 VALUE "LogiParts Solutions".
           05 LINE 02 COLUMN 80 VALUE "|".
      
           05 LINE 03 COLUMN 01 VALUE "+--------------------------------
      -    "----------------------------------------------+".

           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que:".
           05 LINE 04 COLUMN 80 VALUE "|".

           05 LINE 05 COLUMN 01 VALUE "|".
           05 LINE 05 COLUMN 80 VALUE "|".

           05 LINE 06 COLUMN 01 VALUE "|".
           05 LINE 06 COLUMN 80 VALUE "|".

           05 LINE 07 COLUMN 01 VALUE "|".
           05 LINE 07 COLUMN 80 VALUE "|".

           05 LINE 08 COLUMN 01 VALUE "|".
           05 LINE 08 COLUMN 80 VALUE "|".

           05 LINE 09 COLUMN 01 VALUE "|".
           05 LINE 09 COLUMN 80 VALUE "|".

           05 LINE 10 COLUMN 01 VALUE "|".
           05 LINE 10 COLUMN 80 VALUE "|".

           05 LINE 11 COLUMN 01 VALUE "|                            Affi
      -    "cher : ".
           05 LINE 11 COLUMN 80 VALUE "|".

           05 LINE 12 COLUMN 01 VALUE "|".
           05 LINE 12 COLUMN 80 VALUE "|".

           05 LINE 13 COLUMN 01 VALUE "|".
           05 LINE 13 COLUMN 80 VALUE "|".

           05 LINE 14 COLUMN 01 VALUE "|".
           05 LINE 14 COLUMN 80 VALUE "|".

           05 LINE 15 COLUMN 01 VALUE "|                            1 - 
      -     "Un client (ID requis)".
           05 LINE 15 COLUMN 80 VALUE "|".

           05 LINE 16 COLUMN 01 VALUE "|                            2 - 
      -     "La liste complete".
           05 LINE 16 COLUMN 80 VALUE "|".

           05 LINE 17 COLUMN 01 VALUE "|".
           05 LINE 17 COLUMN 80 VALUE "|".

           05 LINE 18 COLUMN 01 VALUE "|".
           05 LINE 18 COLUMN 80 VALUE "|".

           05 LINE 19 COLUMN 01 VALUE "|".
           05 LINE 19 COLUMN 80 VALUE "|".

           05 LINE 20 COLUMN 01 VALUE "|".
           05 LINE 20 COLUMN 80 VALUE "|".

           05 LINE 21 COLUMN 01 VALUE "|                            0 - 
      -     "Retour au menu ".
           05 LINE 21 COLUMN 80 VALUE "|".

           05 LINE 22 COLUMN 01 VALUE "|".
           05 LINE 22 COLUMN 80 VALUE "|".

           05 LINE 23 COLUMN 01 VALUE "|".
           05 LINE 23 COLUMN 80 VALUE "|".

           05 LINE 24 COLUMN 01 VALUE "|                            Entr
      -    "ez votre choix : [_]".
           05 LINE 24 COLUMN 80 VALUE "|".
           05 LINE 24 COLUMN 52 PIC Z TO WS-CON.

           05 LINE 25 COLUMN 01 VALUE "|".
           05 LINE 25 COLUMN 80 VALUE "|".

           05 LINE 26 COLUMN 01 VALUE "+--------------------------------
      -    "----------------------------------------------+".

       PROCEDURE DIVISION.

           PERFORM 0100-ECR-DEB
              THRU 0100-ECR-FIN.

           PERFORM 0200-TRA-COM-DEB
              THRU 0200-TRA-COM-FIN.
           
           EXIT PROGRAM.

      * affichage de l'écran et demande à l'utilisateur sa commande
       0100-ECR-DEB.
           DISPLAY S-FND-ECR.

           ACCEPT S-FND-ECR.
       0100-ECR-FIN.

      *traitement de la commande entrer par l'utilisateur
       0200-TRA-COM-DEB.
           EVALUATE WS-CON
               
               WHEN EQUAL 1
               CALL "ecrrecli"
               END-CALL
               
               WHEN EQUAL 2
               CALL "ecrpgcli"
               END-CALL
           END-EVALUATE.
       0200-TRA-COM-FIN.
       