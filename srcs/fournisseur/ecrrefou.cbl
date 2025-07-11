      ******************************************************************
      * LE PROGRAMME PERMET À L'UTILISATEUR DE RENTRER SOIT L'ID OU    *
      * LE NOM D'UN FOURNISSEUR, POUR ENSUITE L'AFFICHER.              *
      *                                                                *
      * TRIGRAMMES :                                                   *
      * FOU=FOURNISSEUR; SAI=SAISIE; CHX=CHOIX; ECR=ECRAN; LIR=LECTURE;*
      * RET=RETOUR; IDT=IDENTIFIANT; ADR=ADRESSE; VIL=VILLE;           *
      * CDP=CODE-POSTAL; IND=INDICATIF; TEL=TELEPHONE; EMA=EMAIL;      *
      * FND=FOND; PCP=PRINCIPAL; EVA=EVALUATION; BCL=BOUCLE;           *
      * UTL=UTILISATEUR; MAL=MAILE; LGN=LIGNE; TIR=TIRE.               *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrrefou.
       AUTHOR. Yassine.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-IDT-FOU        PIC 9(10).
       01 WS-NOM-FOU        PIC X(50).
       01 WS-ADR-FOU        PIC X(50).
       01 WS-VIL-FOU        PIC X(50).
       01 WS-CDP-FOU        PIC 9(05).
       01 WS-IND-FOU        PIC 9(03).
       01 WS-TEL-FOU        PIC 9(10).
       01 WS-MAL-FOU        PIC X(50).

       01 WS-SAI-FOU        PIC X(50).
       01 WS-CHX-UTL        PIC 9(01).
       01 WS-LIR-RET        PIC 9(04).
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

     
       01 WS-FIN-BCL       PIC X(01).
           88 WS-FIN-BCL-OUI VALUE "O".
           88 WS-FIN-BCL-NON VALUE "N".

       01 WS-COL-LNG.
          05 FILLER PIC X(78) VALUE ALL "_".  

       01 WS-TIR-LGN.
          05 FILLER PIC X(50) VALUE ALL "_".  

       SCREEN SECTION.
       COPY ecrprn.

      * L'écran de saisie.
      
       01 S-ECR-RE-FOU.
           05 LINE 04 COL 03 VALUE "Connecte en tant que : Admin".

           05 LINE 06 COL 03 VALUE "ID/nom du fournisseur : ".
           05 LINE 06 COL 27 VALUE "[".
           05 LINE 06 COL 28 PIC X(50) TO WS-SAI-FOU.
           05 LINE 06 COL 78 VALUE "]".

           05 LINE 07 COL 02 PIC X(78) FROM WS-COL-LNG. 
           05 LINE 08 COL 03 VALUE "ID : ".
           05 LINE 09 COL 03 VALUE "[".
           05 LINE 09 COL 14 VALUE "]".

           05 LINE 10 COL 03 VALUE "Nom : ".
           05 LINE 11 COL 03 VALUE "[".
           05 LINE 11 COL 54 VALUE "]".

           05 LINE 12 COL 03 VALUE "Email : ".
           05 LINE 13 COL 03 VALUE "[".
           05 LINE 13 COL 54 VALUE "]".

           05 LINE 14 COL 03 VALUE "Indicatif / Telephone : ".
           05 LINE 15 COL 03 VALUE "[+".
           05 LINE 15 COL 19 VALUE "]".

           05 LINE 16 COL 03 VALUE "Adresse : ".
           05 LINE 17 COL 03 VALUE "[".
           05 LINE 17 COL 54 VALUE "]".

           05 LINE 18 COL 03 VALUE "Ville : ".
           05 LINE 19 COL 03 VALUE "[".
           05 LINE 19 COL 54 VALUE "]".

           05 LINE 20 COL 03 VALUE "Code postal : ".
           05 LINE 21 COL 03 VALUE "[".
           05 LINE 21 COL 09 VALUE "]".

           05 LINE 22 COL 26 VALUE "1 - Rechercher".
           05 LINE 22 COL 43 VALUE "0 - Annuler".

           05 LINE 23 COL 40 VALUE "[".
           05 LINE 23 COL 41 PIC Z(01) TO WS-CHX-UTL.
           05 LINE 23 COL 42 VALUE "]".
      * L'écran pour afficher des lignes.
       01 S-ECR-TIR.                                    
           05 LINE 09 COL 04 PIC X(10) FROM WS-TIR-LGN. 
           05 LINE 11 COL 04 PIC X(50) FROM WS-TIR-LGN. 
           05 LINE 13 COL 04 PIC X(50) FROM WS-TIR-LGN. 
           05 LINE 15 COL 05 PIC Z(03) FROM WS-TIR-LGN. 
           05 LINE 15 COL 09 PIC Z(10) FROM WS-TIR-LGN. 
           05 LINE 17 COL 04 PIC X(50) FROM WS-TIR-LGN. 
           05 LINE 19 COL 04 PIC X(50) FROM WS-TIR-LGN. 
           05 LINE 21 COL 04 PIC X(05) FROM WS-TIR-LGN. 

      * L'écran pour afficher des données.
       01 S-ECR-AFF.
           05 LINE 09 COL 04 PIC 9(10) FROM WS-IDT-FOU.
           05 LINE 11 COL 04 PIC X(50) FROM WS-NOM-FOU.
           05 LINE 13 COL 04 PIC X(50) FROM WS-MAL-FOU.
           05 LINE 15 COL 05 PIC 9(03) FROM WS-IND-FOU.
           05 LINE 15 COL 09 PIC 9(10) FROM WS-TEL-FOU.
           05 LINE 17 COL 04 PIC X(50) FROM WS-ADR-FOU.
           05 LINE 19 COL 04 PIC X(50) FROM WS-VIL-FOU.
           05 LINE 21 COL 04 PIC 9(05) FROM WS-CDP-FOU.

      ******************************************************************
       PROCEDURE DIVISION.

           PERFORM 0100-BCL-PCP-DEB
              THRU 0100-BCL-PCP-FIN.

           EXIT PROGRAM.

      ******************************************************************
      * La boucle principale
       0100-BCL-PCP-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-TIR.   
           
           SET WS-FIN-BCL-NON TO TRUE.
           PERFORM UNTIL WS-FIN-BCL-OUI
              
              PERFORM 0200-AFF-ECR-DEB
                 THRU 0200-AFF-ECR-FIN

               PERFORM 0300-EVA-SAI-UTL-DEB
                  THRU 0300-EVA-SAI-UTL-FIN
                   
           END-PERFORM.
       0100-BCL-PCP-FIN.
           EXIT.

      ******************************************************************     
      * Afficher l'écran et récupérer la saisie utilisateur.
       0200-AFF-ECR-DEB.  
           DISPLAY S-ECR-RE-FOU.
           ACCEPT  S-ECR-RE-FOU.
       0200-AFF-ECR-FIN.
           EXIT.

      * Traiter le choix fait par l'utilisateur.
       0300-EVA-SAI-UTL-DEB.
           EVALUATE WS-CHX-UTL
               WHEN 1
              
                   PERFORM 0310-RE-FOU-DEB
                      THRU 0310-RE-FOU-FIN
               WHEN 0
              
                   SET WS-FIN-BCL-OUI TO TRUE
           END-EVALUATE.
       0300-EVA-SAI-UTL-FIN.
           EXIT.

      ******************************************************************
       0310-RE-FOU-DEB.
           IF FUNCTION TRIM(WS-SAI-FOU) IS NUMERIC
               MOVE WS-SAI-FOU TO WS-IDT-FOU
               CALL "liridfou" USING WS-IDT-FOU
                                     WS-NOM-FOU
                                     WS-ADR-FOU
                                     WS-VIL-FOU
                                     WS-CDP-FOU
                                     WS-IND-FOU
                                     WS-TEL-FOU
                                     WS-MAL-FOU
                                     WS-LIR-RET
               END-CALL         
           ELSE
               MOVE WS-SAI-FOU TO WS-NOM-FOU
               CALL "lirnmfou" USING WS-NOM-FOU
                                     WS-IDT-FOU
                                     WS-ADR-FOU
                                     WS-VIL-FOU
                                     WS-CDP-FOU
                                     WS-IND-FOU
                                     WS-TEL-FOU
                                     WS-MAL-FOU
                                     WS-LIR-RET
               END-CALL          
           END-IF.
      * Afficher les résultats récuperer.    
           DISPLAY S-ECR-AFF.
           
       0310-RE-FOU-FIN.
           EXIT.
