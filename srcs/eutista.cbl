      ******************************************************************
      * Affichage d'un menu utilisateur avec retour choix et message   *
      *                                                                *
      * TRIGRAMMES :                                                   *
      * CHOIX = CHX ; MESSAGE = MSG ; TEMPORAIRE = TMP ;               *
      * SCREEN SECTION = S ; ECRAN = ECR ; MENU = MNU ;                *
      * UTILISATEUR = UTI ; STANDARD = STA                             *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. eutista.
       AUTHOR. Yassine.
       DATE-WRITTEN. 26-06-2025 (fr).

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Variables temporaires utilisées uniquement dans ce programme
       01 WS-TMP-CHX          PIC X(01) VALUE SPACES.
       01 WS-TMP-MSG          PIC X(40) VALUE SPACES.

       LINKAGE SECTION.
      * Les variables reçues du programme principal
       01 LK-CHX              PIC 9(01).
       01 LK-MSG              PIC X(40).

       SCREEN SECTION.
      * l'écran de l’administrateur avec le menu
       01 S-E-MNU-UTI.
           05 BLANK SCREEN.
           05 LINE 01 COLUMN 01 VALUE "+------------------------------".
           05 LINE 01 COLUMN 30 VALUE "-------------------------------".
           05 LINE 01 COLUMN 61 VALUE "-------------------+".
           05 LINE 02 COLUMN 01 VALUE "|".
           05 LINE 02 COLUMN 33 VALUE "LogiParts Solutions".
           05 LINE 02 COLUMN 80 VALUE "|".
           05 LINE 03 COLUMN 01 VALUE "+------------------------------".
           05 LINE 03 COLUMN 30 VALUE "-------------------------------".
           05 LINE 03 COLUMN 61 VALUE "-------------------+".
           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : ".
           05 LINE 04 COLUMN 26 VALUE "Utilisateur".
           05 LINE 04 COLUMN 80 VALUE "|".
           05 LINE 05 COLUMN 80 VALUE "|".
           05 LINE 06 COLUMN 80 VALUE "|".
           05 LINE 07 COLUMN 80 VALUE "|".
           05 LINE 08 COLUMN 80 VALUE "|".
           05 LINE 09 COLUMN 80 VALUE "|".
           05 LINE 10 COLUMN 80 VALUE "|".
           05 LINE 11 COLUMN 80 VALUE "|".
           05 LINE 12 COLUMN 80 VALUE "|".
           05 LINE 13 COLUMN 80 VALUE "|".
           05 LINE 14 COLUMN 80 VALUE "|".
           05 LINE 15 COLUMN 80 VALUE "|".
           05 LINE 16 COLUMN 80 VALUE "|".
           05 LINE 17 COLUMN 80 VALUE "|".
           05 LINE 18 COLUMN 80 VALUE "|".
           05 LINE 19 COLUMN 80 VALUE "|".
           05 LINE 20 COLUMN 80 VALUE "|".
           05 LINE 21 COLUMN 80 VALUE "|".
           05 LINE 22 COLUMN 80 VALUE "|".
           05 LINE 23 COLUMN 80 VALUE "|".
           05 LINE 24 COLUMN 80 VALUE "|".
          
           05 LINE 12 COLUMN 30 VALUE "1 - Gestion du stock".
           05 LINE 13 COLUMN 30 VALUE "2 - Gestion des clients".
           05 LINE 14 COLUMN 30 VALUE "3 - Gestion des fournisseurs".
           05 LINE 15 COLUMN 30 VALUE "4 - Gestion des livraisons".
           05 LINE 16 COLUMN 30 VALUE "5 - Generer un document".
           05 LINE 19 COLUMN 30 VALUE "0 - Deconnexion".
           05 LINE 21 COLUMN 30 VALUE "Entrez votre choix : ".

           05 LINE 21 COLUMN 52 VALUE "[".
           05 LINE 21 COLUMN 54 VALUE "]".
           05 LINE 21 COLUMN 53 PIC X(01) TO   WS-TMP-CHX.
           05 LINE 22 COLUMN 30 PIC X(40) FROM WS-TMP-MSG.
           05 LINE 04 COLUMN 01 VALUE "|".
           05 LINE 05 COLUMN 01 VALUE "|".
           05 LINE 06 COLUMN 01 VALUE "|".
           05 LINE 07 COLUMN 01 VALUE "|".
           05 LINE 08 COLUMN 01 VALUE "|".
           05 LINE 09 COLUMN 01 VALUE "|".
           05 LINE 10 COLUMN 01 VALUE "|".
           05 LINE 11 COLUMN 01 VALUE "|".
           05 LINE 12 COLUMN 01 VALUE "|".
           05 LINE 13 COLUMN 01 VALUE "|".
           05 LINE 14 COLUMN 01 VALUE "|".
           05 LINE 15 COLUMN 01 VALUE "|".
           05 LINE 16 COLUMN 01 VALUE "|".
           05 LINE 17 COLUMN 01 VALUE "|".
           05 LINE 18 COLUMN 01 VALUE "|".
           05 LINE 19 COLUMN 01 VALUE "|".
           05 LINE 20 COLUMN 01 VALUE "|".
           05 LINE 21 COLUMN 01 VALUE "|".
           05 LINE 22 COLUMN 01 VALUE "|".
           05 LINE 23 COLUMN 01 VALUE "|".
           05 LINE 24 COLUMN 01 VALUE "|".
           05 LINE 24 COLUMN 01 VALUE "+------------------------------".
           05 LINE 24 COLUMN 30 VALUE "-------------------------------".
           05 LINE 24 COLUMN 61 VALUE "-------------------+".

      ******************************************************************       
       PROCEDURE DIVISION USING LK-CHX LK-MSG.
      
           PERFORM 0100-CHX-UTI-DEB
              THRU 0100-CHX-UTI-FIN. 
      

           EXIT PROGRAM.


      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************
       0100-CHX-UTI-DEB.

      * Boucle jusqu'à ce que l'utilisateur tape 0 pour déconnexion
           PERFORM UNTIL WS-TMP-CHX = 0
               MOVE SPACES TO WS-TMP-MSG

               DISPLAY S-E-MNU-UTI
               ACCEPT  S-E-MNU-UTI

               EVALUATE WS-TMP-CHX
                   WHEN 1 
                       MOVE "Gestion du stock."           TO WS-TMP-MSG
      * Appel du sous-programme de gestion du stock.

                   WHEN 2 
                       MOVE "Gestion des clients."        TO WS-TMP-MSG
      * Appel du sous-programme de gestion des clients.

                   WHEN 3 
                       MOVE "Gestion des fournisseurs."   TO WS-TMP-MSG
      * Appel du sous-programme de gestion des fournisseurs.

                   WHEN 4 
                       MOVE "Gestion des livraisons."     TO WS-TMP-MSG
      * Appel du sous-programme de gestion des livraisons.

                   WHEN 5 
                       MOVE "Generation de document."     TO WS-TMP-MSG
      * Appel du sous-programme de génération de document.

                   WHEN 0 
                       MOVE "Deconnexion..."              TO WS-TMP-MSG
      * Appel du sous-programme de l'écran de connexion                 
                   WHEN OTHER 
                       MOVE "Choix invalide. Reessayez."  TO WS-TMP-MSG
               END-EVALUATE
           END-PERFORM.
      * On transmet le choix et le message au programme principal.
      * On copie le contenu de TMP-CHOIX dans L-CHOIX pour que le 
      * programme principal sache ce que l'utilisateur a choisi.
           MOVE WS-TMP-CHX   TO LK-CHX.
      * On copie TMP-MSG dans L-MSG pour que le programme principal 
      * récupère ce message.
           MOVE WS-TMP-MSG   TO LK-MSG.

       0100-CHX-UTI-FIN.
           EXIT.
              