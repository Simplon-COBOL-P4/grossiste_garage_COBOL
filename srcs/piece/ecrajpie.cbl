      ******************************************************************
      *                             ENTÊTE                             *
      * Le sous-programme 'ecrajpie'sert de formulaire pour ajouter    *
      * une pièce dans la base de données.                             *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; AJ=AJOUT; PIE=PIECE; QTE=QUANTITE; MIN=MINIMUM;     *
      * FOU=FOURNISSEUR; CHX=CHOIX; VER=VERIFICATION; CHP=CHAMP;       *
      * MSG=MESSAGE; CNX=CONNEXION; MQR=MARQUEUR; VLD=VALIDER;         *
      * INI=INITIALISATION; VAR=VARIABLE;                              *
      *                                                                *
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
    
      *    Déclaration des variables passées en numériques
       01 WS-QTE-PIE-NUM            PIC 9(10).
       01 WS-MIN-PIE-NUM            PIC 9(10).
       01 WS-ID-FOU-NUM             PIC 9(10).
       
      *    Déclaration de variables complémentaires nécessaire à 
      *    l'éxécution du programme.
       01 WS-CHX                    PIC X(01).
       01 WS-MSG-NOM                PIC X(30) VALUE SPACES.
       01 WS-MSG-QTE                PIC X(30) VALUE SPACES.
       01 WS-MSG-MIN                PIC X(30) VALUE SPACES.
       01 WS-MSG-FOU                PIC X(30) VALUE SPACES.

      *    Des marqueurs pour vérifier que les données saisies sont 
      *    correctes.
       77 WS-MQR-1                  PIC 9(01) VALUE 0.
       77 WS-MQR-2                  PIC 9(01) VALUE 0.
       77 WS-MQR-3                  PIC 9(01) VALUE 0.
       
       SCREEN SECTION.
       COPY ecrprn.

      *    Ajout des éléments propres à l'écran d'ajout de pièce.
       01 ECRAJPCS.
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
           PERFORM 0050-INI-VAR-DEB
              THRU 0050-INI-VAR-FIN.

           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-VER-QTE-DEB
              THRU 0200-VER-QTE-FIN.
       
           PERFORM 0300-VER-MIN-DEB
              THRU 0300-VER-MIN-FIN.
       
           PERFORM 0400-VER-FOU-DEB
              THRU 0400-VER-FOU-FIN.

           PERFORM 0500-VLD-ECR-DEB
              THRU 0500-VLD-ECR-FIN.
    
           EXIT PROGRAM.

      *    Paragraphe pour initialiser les variables.
       0050-INI-VAR-DEB.  
           MOVE 0 TO WS-MQR-1.  
           MOVE 0 TO WS-MQR-2.  
           MOVE 0 TO WS-MQR-3.  
           MOVE 1 TO WS-CHX.  
       0050-INI-VAR-FIN.  

      *    Paragraphe pour afficher constamment l'ecran.
       0100-AFF-ECR-DEB.
           IF WS-CHX = 0
               EXIT PROGRAM
           ELSE
               DISPLAY S-FND-ECR
               DISPLAY ECRAJPCS
               ACCEPT  ECRAJPCS
           END-IF.

       0100-AFF-ECR-FIN.
               EXIT.
      
      *    Parapgraphe pour vérifier que la quantité enregistrée est
      *    bien au format numérique.
       0200-VER-QTE-DEB.
           MOVE FUNCTION NUMVAL(WS-QTE-PIE) TO WS-QTE-PIE-NUM
           
           IF WS-QTE-PIE GREATER THAN ZERO
               ADD 1 TO WS-MQR-1
           END-IF.
       
      *    Paragraphe de sortie.
       0200-VER-QTE-FIN.
           EXIT.

      *    Parapgraphe pour vérifier que le seuil minimum enregistré
      *    est bien au format numérique.
       0300-VER-MIN-DEB.
           MOVE FUNCTION NUMVAL(WS-MIN-PIE) TO WS-MIN-PIE-NUM
           
           IF WS-MIN-PIE-NUM IS NUMERIC
               ADD 1 TO WS-MQR-2
           END-IF.

      *    Parapgraphe de sortie.
       0300-VER-MIN-FIN.
               EXIT.

      *    Paragraphe pour vérifier que l'ID fournisseur est bien au
      *    format numérique.
       0400-VER-FOU-DEB.
           MOVE FUNCTION NUMVAL(WS-ID-FOU) TO WS-ID-FOU-NUM

           IF WS-ID-FOU-NUM IS NUMERIC
               ADD 1 TO WS-MQR-3
           END-IF.

      *    Paragraphe de sortie.
       0400-VER-FOU-FIN.
           EXIT.

      *    Paragraphe qui appelle le sous-programme 'ajupie', l'appel
      *    ne se fera que si les marqueurs sont validés.
       0500-VLD-ECR-DEB.
           IF  WS-MQR-1 EQUAL 1
           AND WS-MQR-2 EQUAL 1
           AND WS-MQR-3 EQUAL 1
           CALL "ajupie"
               USING
                   WS-NOM-PIE
                   WS-QTE-PIE-NUM
                   WS-MIN-PIE-NUM
                   WS-ID-FOU-NUM
           END-CALL

      *    MOVE 0 TO WS-CHX pour arrêté le programme.
           MOVE 0 TO WS-CHX
           END-IF.
       
      *    Paragraphe de sortie.
       0500-VLD-ECR-FIN.
               EXIT.
