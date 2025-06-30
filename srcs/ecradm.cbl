      ******************************************************************
      * PROGRAMME : ecradm                                             *
      * OBJET     : Affichage du menu administrateur avec sélection.   *
      *             Retourne le choix utilisateur et un message.       *
      *                                                                *
      * TRIGRAMMES :                                                   *
      * CHOIX = CHX ; MESSAGE = MSG ; TEMPORAIRE = TMP ;               *
      * ECRAN = E ; MENU = MNU ; ADMIN = ADM ; FONCTIONNALITE = FCT ;          *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecradm.
       AUTHOR. Yassine.
       DATE-WRITTEN. 25-06-2025 (fr).

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
       COPY ecrprn.

       01 E-MNU-ADM.
           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : Admin".
          
           05 LINE 12 COLUMN 30 VALUE "1 - Gestion du stock".
           05 LINE 13 COLUMN 30 VALUE "2 - Gestion des clients".
           05 LINE 14 COLUMN 30 VALUE "3 - Gestion des fournisseurs".
           05 LINE 15 COLUMN 30 VALUE "4 - Gestion des livraisons".
           05 LINE 16 COLUMN 30 VALUE "5 - Generer un document".
           05 LINE 17 COLUMN 30 VALUE "6 - Journal de logs".
           05 LINE 18 COLUMN 30 VALUE "7 - Creer un compte utilisateur".
           05 LINE 20 COLUMN 30 VALUE "0 - Deconnexion".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : ".

           05 LINE 22 COLUMN 52 VALUE "[".
           05 LINE 22 COLUMN 54 VALUE "]".
           05 LINE 22 COLUMN 53 PIC X(01) TO   WS-TMP-CHX.
           05 LINE 23 COLUMN 30 PIC X(40) FROM WS-TMP-MSG.

      ******************************************************************       
       PROCEDURE DIVISION USING LK-CHX LK-MSG.
      
           PERFORM 0100-CHX-FCT-DEB
              THRU 0100-CHX-FCT-FIN. 
      

           EXIT PROGRAM.


      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************
       0100-CHX-FCT-DEB.

      * Boucle jusqu'à ce que l'utilisateur tape 0 pour déconnexion
           PERFORM UNTIL WS-TMP-CHX = 0
               MOVE SPACES TO WS-TMP-MSG

               DISPLAY S-FND-ECR
               DISPLAY E-MNU-ADM
               ACCEPT  E-MNU-ADM

               EVALUATE WS-TMP-CHX
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

                   WHEN 6 
      * Appel du sous-programme d'affichage du journal de logs.
                        CALL 'ecrlog'
                        END-CALL

                   WHEN 7 
      * Appel du sous-programme ecruti.
                        CALL 'ecruti'
                        END-CALL

                   WHEN 0 
                       MOVE "Deconnexion..."              TO WS-TMP-MSG
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



       0100-CHX-FCT-FIN.
           EXIT.
              
