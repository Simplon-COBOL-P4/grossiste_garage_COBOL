      ******************************************************************
      * Affichage d'un menu utilisateur avec retour choix et message   *
      *                                                                *
      * TRIGRAMMES :                                                   *
      * CHOIX = CHX ; MESSAGE = MSG ; TEMPORAIRE = TMP ;               *
      * ECRAN = ECR ; MENU = MNU ;                                     *
      * UTILISATEUR = UTI ; STANDARD = STA                             *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrsta.
       AUTHOR. Yassine.
       DATE-WRITTEN. 26-06-2025 (fr).

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Variables temporaires utilisées uniquement dans ce programme
       01 WS-CHX              PIC 9(01).

       SCREEN SECTION.
       COPY ecrprn.

      * l'écran de l’administrateur avec le menu
       01 S-E-MNU-UTI.
           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : ".
           05 LINE 04 COLUMN 26 VALUE "Utilisateur".
          
           05 LINE 12 COLUMN 30 VALUE "1 - Gestion du stock".
           05 LINE 13 COLUMN 30 VALUE "2 - Gestion des clients".
           05 LINE 14 COLUMN 30 VALUE "3 - Gestion des fournisseurs".
           05 LINE 15 COLUMN 30 VALUE "4 - Gestion des livraisons".
           05 LINE 16 COLUMN 30 VALUE "5 - Generer un document".
           05 LINE 19 COLUMN 30 VALUE "0 - Deconnexion".
           05 LINE 21 COLUMN 30 VALUE "Entrez votre choix : ".

           05 LINE 21 COLUMN 52 VALUE "[".
           05 LINE 21 COLUMN 54 VALUE "]".
           05 LINE 21 COLUMN 53 PIC X(01) TO WS-CHX.

      ******************************************************************       
       PROCEDURE DIVISION.
      
           PERFORM 0100-CHX-UTI-DEB
              THRU 0100-CHX-UTI-FIN. 
      

           EXIT PROGRAM.


      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************
       0100-CHX-UTI-DEB.

      * Boucle jusqu'à ce que l'utilisateur tape 0 pour déconnexion
           PERFORM UNTIL WS-CHX = 0

               DISPLAY S-FND-ECR
               ACCEPT  S-E-MNU-UTI

               EVALUATE WS-CHX
                   WHEN 1 
      * Appel du sous-programme de gestion du stock.

                   WHEN 2 
      * Appel du sous-programme de gestion des clients.

                   WHEN 3 
      * Appel du sous-programme de gestion des fournisseurs.

                   WHEN 4 
      * Appel du sous-programme de gestion des livraisons.

                   WHEN 5 
      * Appel du sous-programme de génération de document.

                   WHEN 0 
      * Appel du sous-programme de l'écran de connexion                 
                   WHEN OTHER 
               END-EVALUATE
           END-PERFORM.

       0100-CHX-UTI-FIN.
