      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * LE PROGRAMME PERMET À L'UTILISATEUR DE RENTRER LES             *
      * DIFFÉRENTS ARGUMENTS NÉCESSSAIRE À L'AJOUT D'UN FOURNISSEUR    *
      * DANS LA BD.                                                    *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ADR=ADRESSE; AFF=AFFICHAGE; AJ=AJOUT; BCL=BOUCLE;              *
      * CDP=CODE-POSTAL; CHX=CHOIX; ECR=ECRAN; EML=EMAIL; EVA=EVALUE;  *
      * FOU=FOURNISSEUR; IND=INDICATIF; PCP=PRINCIPAL;                 *
      * TEL=TELEPHONE; UTL=UTILISATEUR; VIL=VILLE;                     *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajfou.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 09-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NOM                 PIC X(50).
       01 WS-ADR                 PIC X(50).
       01 WS-VIL                 PIC X(50).
       01 WS-CDP                 PIC 9(05).
       01 WS-IND                 PIC 9(03).
       01 WS-TEL                 PIC 9(10).
       01 WS-EML                 PIC X(50).

      * VARIABLE POUR LE CHOIX DE L'UTILISATEUR.
       01 WS-CHX                 PIC 9(01).

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY ecrprn.

       01 S-ECR-AJ-FOU.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           
           05 LINE 08 COLUMN 03 VALUE "Nom : ".
           05 LINE 09 COLUMN 03 VALUE "[".
           05 LINE 09 COLUMN 54 VALUE "]".

           05 LINE 10 COLUMN 03 VALUE "Email : ".
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 54 VALUE "]".
      
           05 LINE 12 COLUMN 03 VALUE "Indicatif / Telephone : ".
           05 LINE 13 COLUMN 03 VALUE "[+".
           05 LINE 13 COLUMN 54 VALUE "]".
     
           05 LINE 14 COLUMN 03 VALUE "Adresse : ".
           05 LINE 15 COLUMN 03 VALUE "[".
           05 LINE 15 COLUMN 54 VALUE "]".
      
           05 LINE 16 COLUMN 03 VALUE "Ville : ".
           05 LINE 17 COLUMN 03 VALUE "[".
           05 LINE 17 COLUMN 54 VALUE "]".
      
           05 LINE 18 COLUMN 03 VALUE "Code postal : ".
           05 LINE 19 COLUMN 03 VALUE "[".
           05 LINE 19 COLUMN 09 VALUE "]".
       
           05 LINE 20 COLUMN 33 VALUE "Ajouter fournisseur ?".
           05 LINE 21 COLUMN 33 VALUE "1 - Oui".
           05 LINE 21 COLUMN 43 VALUE "0 - Annuler".
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 42 VALUE "]".
           

           05 LINE 09 COLUMN 04 PIC X(50) TO WS-NOM.
           05 LINE 11 COLUMN 04 PIC X(50) TO WS-EML.
           05 LINE 13 COLUMN 05 PIC Z(03) TO WS-IND.
           05 LINE 13 COLUMN 09 PIC Z(45) TO WS-TEL.
           05 LINE 15 COLUMN 04 PIC X(50) TO WS-ADR.
           05 LINE 17 COLUMN 04 PIC X(50) TO WS-VIL.
           05 LINE 19 COLUMN 04 PIC Z(05) TO WS-CDP.
           05 LINE 22 COLUMN 41 PIC Z(01) TO WS-CHX.

          
       PROCEDURE DIVISION.

           PERFORM 0100-BCL-PCP-DEB
              THRU 0100-BCL-PCP-FIN.

           EXIT PROGRAM.

      ***************************PARAGRAPHES**************************** 
       0100-BCL-PCP-DEB.

           MOVE 1 TO WS-CHX

           PERFORM 0200-AFF-ECR-DEB
              THRU 0200-AFF-ECR-FIN

           PERFORM UNTIL WS-CHX = 0    

               PERFORM 0300-EVA-CHX-DEB
                  THRU 0300-EVA-CHX-FIN

           END-PERFORM.     
           
       0100-BCL-PCP-FIN.

      * PARAGRAPHE POUR AFFICHER L'ÉCRAN.
       0200-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-AJ-FOU.
       0200-AFF-ECR-FIN.

      * PARAGRAPHE POUR EVALUER LE CHOIX DE L'UTILISATEUR.
       0300-EVA-CHX-DEB.
           ACCEPT  S-ECR-AJ-FOU.

           EVALUATE WS-CHX

               WHEN 1
                   
                   CALL "ajufou"
                       USING
                       WS-NOM
                       WS-ADR
                       WS-VIL
                       WS-CDP
                       WS-IND
                       WS-TEL
                       WS-EML
                       WS-AJU-RET
                   END-CALL
           
               WHEN 0

                   EXIT PROGRAM
                
           END-EVALUATE.
       0300-EVA-CHX-FIN.
