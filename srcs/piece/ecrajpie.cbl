      ******************************************************************
      *                             ENTÊTE                             *
      * Le sous-programme 'ecrajpie' sert de formulaire pour ajouter   *
      * une pièce dans la base de données.                             *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; AJ=AJOUT; PIE=PIECE; QTE=QUANTITE; MIN=MINIMUM;     *
      * FOU=FOURNISSEUR; CHX=CHOIX; VER=VERIFICATION; CHP=CHAMP;       *
      * MSG=MESSAGE; CNX=CONNEXION; MQR=MARQUEUR; VLD=VALIDER;         *
      * INI=INITIALISATION; VAR=VARIABLE; ACP=ACCEPTE; SUC=SUCCES;     *
      * BCL=BOUCLE; PCP=PRINCIPAL                                      *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajpie.
       AUTHOR. siboryg.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *    Déclarations des variables pour l'enregistrement
       01 WS-NOM-PIE                PIC X(50).
       01 WS-QTE-PIE                PIC X(10).
       01 WS-MIN-PIE                PIC X(10).
       01 WS-ID-FOU                 PIC X(10).

      *    Déclarations des variables numériques nécessaires à
      *    l'appel du sous-programme.
       01 WS-QTE-PIE-NUM            PIC 9(10).
       01 WS-MIN-PIE-NUM            PIC 9(10).
       01 WS-ID-FOU-NUM             PIC 9(10).

      *    Déclaration de variables complémentaires nécessaires à 
      *    l'éxécution du programme.
       01 WS-CHX                    PIC X(01).

      *    Des marqueurs pour vérifier que les données saisies sont 
      *    correctes.
       01 WS-MQR                    PIC 9(03) VALUE 0.
           88 WS-MQR-SUC                      VALUE 111.
      
       
       SCREEN SECTION.
       COPY ecrprn.

      *    Ajout des éléments propres à l'écran d'ajout de pièce.
       01 S-ECR-AJ-PCS.
           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : ".

           05 LINE 09 COLUMN 03 VALUE "Nom :".
           05 LINE 10 COLUMN 03 VALUE "[".
           05 LINE 10 COLUMN 54 VALUE "]".
           05 LINE 12 COLUMN 03 VALUE "Quantite :".
           05 LINE 12 COLUMN 25 VALUE "[".
           05 LINE 12 COLUMN 36 VALUE "]".
           05 LINE 14 COLUMN 03 VALUE "Seuil minimum :".
           05 LINE 14 COLUMN 25 VALUE "[".
           05 LINE 14 COLUMN 36 VALUE "]".
           05 LINE 16 COLUMN 03 VALUE "ID fournisseur :".
           05 LINE 16 COLUMN 25 VALUE "[".
           05 LINE 16 COLUMN 36 VALUE "]".
           05 LINE 21 COLUMN 33 VALUE "Ajouter au stock".
           05 LINE 22 COLUMN 30 VALUE "1 - Oui   0 - Annuler".
           05 LINE 23 COLUMN 40 VALUE "[".
           05 LINE 23 COLUMN 42 VALUE "]".

           05 LINE 10 COLUMN 04     PIC X(50) TO WS-NOM-PIE.
           05 LINE 12 COLUMN 26     PIC X(10) TO WS-QTE-PIE.
           05 LINE 14 COLUMN 26     PIC X(10) TO WS-MIN-PIE.
           05 LINE 16 COLUMN 26     PIC X(10) TO WS-ID-FOU.
           05 LINE 23 COLUMN 41     PIC X(01) TO WS-CHX.

       PROCEDURE DIVISION.
      *    le déroulé du programme, après les vérifications ajupie est
      *    appelé.           
             
           PERFORM 0025-BCL-PCP-DEB
              THRU 0025-BCL-PCP-FIN.
      
           EXIT PROGRAM.


       0025-BCL-PCP-DEB.

           PERFORM 0050-INI-VAR-DEB
              THRU 0050-INI-VAR-FIN.

           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM UNTIL WS-CHX = 0  

               PERFORM 0150-ACP-ECR-DEB
                  THRU 0150-ACP-ECR-FIN

               PERFORM 0200-VER-QTE-DEB
                  THRU 0200-VER-QTE-FIN
           
               PERFORM 0300-VER-MIN-DEB
                  THRU 0300-VER-MIN-FIN
           
               PERFORM 0400-VER-FOU-DEB
                  THRU 0400-VER-FOU-FIN

               PERFORM 0500-VLD-ECR-DEB
                  THRU 0500-VLD-ECR-FIN

           END-PERFORM.
       0025-BCL-PCP-FIN.


      *    Paragraphe pour initialiser les variables.
       0050-INI-VAR-DEB. 
           MOVE 1        TO WS-CHX.
           MOVE SPACE    TO WS-NOM-PIE. 
           MOVE SPACE    TO WS-QTE-PIE.
           MOVE SPACE    TO WS-MIN-PIE.
           MOVE SPACE    TO WS-ID-FOU.
           MOVE 0        TO WS-MQR.  
       0050-INI-VAR-FIN.  

      *    Paragraphe pour afficher constamment l'ecran.
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-AJ-PCS.
       0100-AFF-ECR-FIN.

      *    Paragraphe pour accepter l'écran.         
       0150-ACP-ECR-DEB.
           ACCEPT  S-ECR-AJ-PCS.

           IF WS-CHX = 0
               EXIT PROGRAM
           END-IF.

      *    Paragraphe de sortie.      
       0150-ACP-ECR-FIN.

      *    Paragraphe pour vérifier que la quantité enregistrée est
      *    bien au format numérique.
       0200-VER-QTE-DEB.
           
           IF FUNCTION TRIM(WS-QTE-PIE) IS NUMERIC
               ADD 1 TO WS-MQR
           END-IF.
       
      *    Paragraphe de sortie.
       0200-VER-QTE-FIN.

      *    Parapraphe pour vérifier que le seuil minimum enregistré
      *    est bien au format numérique.
       0300-VER-MIN-DEB.
           
           IF FUNCTION TRIM(WS-MIN-PIE) IS NUMERIC
               ADD 10 TO WS-MQR
           END-IF.

      *    Parapraphe de sortie.
       0300-VER-MIN-FIN.

      *    Paragraphe pour vérifier que l'ID fournisseur est bien au
      *    format numérique.
       0400-VER-FOU-DEB.

           IF FUNCTION TRIM(WS-ID-FOU) IS NUMERIC
               ADD 100 TO WS-MQR
           END-IF.

      *    Paragraphe de sortie.
       0400-VER-FOU-FIN.

      *    Paragraphe qui appelle le sous-programme 'ajupie', l'appel
      *    ne se fera que si les marqueurs sont validés.
       0500-VLD-ECR-DEB.
           IF WS-MQR-SUC
               MOVE FUNCTION NUMVAL (WS-QTE-PIE) TO WS-QTE-PIE-NUM
               MOVE FUNCTION NUMVAL (WS-MIN-PIE) TO WS-MIN-PIE-NUM
               MOVE FUNCTION NUMVAL (WS-ID-FOU)  TO WS-ID-FOU-NUM

               CALL "ajupie"
                   USING
                   WS-NOM-PIE
                   WS-QTE-PIE-NUM
                   WS-MIN-PIE-NUM
                   WS-ID-FOU-NUM
               
               END-CALL

           ELSE

               DISPLAY 'ERREUR DE VALIDATION' AT LINE 23 COL 28

           END-IF.
           
      *    Paragraphe de sortie.
       0500-VLD-ECR-FIN.
