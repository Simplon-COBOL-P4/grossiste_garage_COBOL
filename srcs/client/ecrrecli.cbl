      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * LE PROGRAMME PERMET À L'UTILISATEUR DE RENTRER SOIT L'ID SOIT  * 
      * LE NOM D'UN CLIENT, POUR ENSUITE L'AFFICHER.                   *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * BCL=BOUCLE; CLI=CLIENT; CHX=CHOIX; ECR=ECRAN; EML=EMAIL;       *
      * FND=FOND; RE=RECHERCHE; IND=INDICATIF; IDF=IDENTIFIANT;        *
      * TEL=TELEPHONE; CDP=CODE-POSTAL; ADR=ADRESSE; SAI=SAISIE;       *
      * UTL=UTILISATEUR; LRR=LEURRE; VIL=VILLE; PCP=PRINCIPAL;         *
      * EVA=EVALUATION;                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrrecli.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 03-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDF       PIC 9(10).
       01 WS-NOM       PIC X(50).
       01 WS-EML       PIC X(50).
       01 WS-IND       PIC 9(03).
       01 WS-TEL       PIC 9(10).
       01 WS-CDP       PIC 9(05).
       01 WS-VIL       PIC X(50).
       01 WS-ADR       PIC X(50).

      * VARIABLE SAISIE UTILISATEUR.
       01 WS-SAI-UTL   PIC X(50).
      * VARIABLE CHOIX UTILISATEUR.
       01 WS-CHX-UTL   PIC 9(01).
      * VARIABLE LEURRE.
       01 WS-LRR       PIC X.

       01 WS-FIN-BCL      PIC X(01).
           88 WS-FIN-BCL-OUI   VALUE "O".
           88 WS-FIN-BCL-NON   VALUE "N".
       

       SCREEN SECTION.
       COPY ecrprn.

      * AFFICHAGE DE L'ÉCRAN DE RECHERCHE DU CLIENT.
       01 S-ECR-RE-CLI.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".

           05 LINE 06 COLUMN 03 VALUE "ID/nom du client : ".
           05 LINE 06 COLUMN 21 VALUE "[".
           05 LINE 06 COLUMN 22 PIC X(50) TO WS-SAI-UTL.
           05 LINE 06 COLUMN 72 VALUE "]".

           05 LINE 07 COLUMN 02 VALUE "_________________________________
      -    "_____________________________________________". 

           05 LINE 08 COLUMN 03 VALUE "ID : ".
           05 LINE 09 COLUMN 03 VALUE "[".
           05 LINE 09 COLUMN 54 VALUE "]".

           05 LINE 10 COLUMN 03 VALUE "Nom : ".
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 54 VALUE "]".

           05 LINE 12 COLUMN 03 VALUE "Email : ".
           05 LINE 13 COLUMN 03 VALUE "[".
           05 LINE 13 COLUMN 54 VALUE "]".
          
           
           05 LINE 14 COLUMN 03 VALUE "Indicatif / Telephone : ".
           05 LINE 15 COLUMN 03 VALUE "[+".
           05 LINE 15 COLUMN 19 VALUE "]".
           
           
           05 LINE 16 COLUMN 03 VALUE "Adresse : ".
           05 LINE 17 COLUMN 03 VALUE "[".
           05 LINE 17 COLUMN 54 VALUE "]".
           
           
           05 LINE 18 COLUMN 03 VALUE "Ville : ".
           05 LINE 19 COLUMN 03 VALUE "[".
           05 LINE 19 COLUMN 54 VALUE "]".
       

           05 LINE 20 COLUMN 03 VALUE "Code postal : ".
           05 LINE 21 COLUMN 03 VALUE "[".
           05 LINE 21 COLUMN 09 VALUE "]".
           

           05 LINE 22 COLUMN 26 VALUE "1 - Rechercher".
           05 LINE 22 COLUMN 43 VALUE "0 - Annuler".


           05 LINE 23 COLUMN 40 VALUE "[".
           05 LINE 23 COLUMN 41 PIC Z(01) TO WS-CHX-UTL.
           05 LINE 23 COLUMN 42 VALUE "]".
           

      * ÉCRAN QUI AFFICHE LES VALEURS DANS LES CHAMPS.
           01 S-ECR-AFF.
               05 LINE 09 COLUMN 04 PIC 9(10) FROM WS-IDF.
               05 LINE 11 COLUMN 04 PIC X(50) FROM WS-NOM.
               05 LINE 13 COLUMN 04 PIC X(50) FROM WS-EML.
               05 LINE 15 COLUMN 05 PIC 9(03) FROM WS-IND.
               05 LINE 15 COLUMN 09 PIC 9(10) FROM WS-TEL.
               05 LINE 21 COLUMN 04 PIC 9(05) FROM WS-CDP.
               05 LINE 19 COLUMN 04 PIC X(50) FROM WS-VIL.
               05 LINE 17 COLUMN 04 PIC X(50) FROM WS-ADR.


       PROCEDURE DIVISION.

           PERFORM 0100-BCL-PCP-DEB
              THRU 0100-BCL-PCP-FIN.
 
           EXIT PROGRAM.

      ******************************************************************
      ***************************PARAGRAPHES**************************** 
       0100-BCL-PCP-DEB.

           SET WS-FIN-BCL-NON TO TRUE.

           PERFORM UNTIL WS-FIN-BCL-OUI

               
               PERFORM 0200-AFF-ECR-DEB
                  THRU 0200-AFF-ECR-FIN

               PERFORM 0300-EVA-SAI-UTL-DEB
                  THRU 0300-EVA-SAI-UTL-FIN

           END-PERFORM.     
           
       0100-BCL-PCP-FIN.
       
       0200-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.

           DISPLAY S-ECR-RE-CLI. 
           ACCEPT  S-ECR-RE-CLI.

       0200-AFF-ECR-FIN.

       0300-EVA-SAI-UTL-DEB.
     

               EVALUATE WS-CHX-UTL

                   WHEN 1
     
                       PERFORM 0310-RE-CLI-DEB
                          THRU 0310-RE-CLI-FIN

                   WHEN 0

                       SET WS-FIN-BCL-OUI TO TRUE

    
               END-EVALUATE.
           
       0300-EVA-SAI-UTL-FIN.

       0310-RE-CLI-DEB.
               IF FUNCTION TRIM(WS-SAI-UTL) IS NUMERIC

                   CALL "liridcli"
                       USING 
                       *> Arguments d'entrée:
                       WS-IDF
                       *> Arguments de sortie:
                       WS-NOM
                       WS-EML
                       WS-IND
                       WS-TEL
                       WS-CDP
                       WS-VIL 
                       WS-ADR
                   END-CALL   
                   
                  DISPLAY S-ECR-AFF
                  ACCEPT WS-LRR
                  
                ELSE  

                   CALL "lirnmcli"
                       USING
                       *> Arguments d'entrée:
                       WS-NOM
                       *> Arguments de sortie:
                       WS-IDF
                       WS-EML
                       WS-IND
                       WS-TEL
                       WS-CDP
                       WS-VIL
                       WS-ADR
                   END-CALL 

               END-IF.
       0310-RE-CLI-FIN.
