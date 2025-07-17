      ******************************************************************
      * PROGRAMME : ecrmnprn                                           *
      * OBJET     : Affichage du menu principal avec sélection.        *
      *                                                                *
      * TRIGRAMMES :                                                   *
      * CHOIX = CHX ; PRINCIPAL = PRN ; COMMUN = COM ;                 *
      * ECRAN = E ; MENU = MN, MNU ; ADMIN = ADM ; FONCTIONNALITE = FCT*
      * CONTEXTE = CTX ; ERREUR = ERR ; OPTION = OPT ; INVALIDE = IVL ;*
      * CONDITIONNELLEMENT = CND ;                                     *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmnprn.
       AUTHOR. Yassine.
       DATE-WRITTEN. 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Variables temporaires utilisées uniquement dans ce programme
       01 WS-CHX                PIC X(01) VALUE SPACES.

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       01 WS-OPT-IVL            PIC X(76) VALUE
           "Cette option n'existe pas".

       COPY ctxerr.

       COPY utiglb.

       SCREEN SECTION.
      * l'écran de l’administrateur avec le menu
       COPY ecrprn.

       01 S-MNU-PRN-COM.
           COPY ecrutlin.
          
           05 LINE 12 COLUMN 30 VALUE "1 - Gestion du stock".
           05 LINE 13 COLUMN 30 VALUE "2 - Gestion des clients".
           05 LINE 14 COLUMN 30 VALUE "3 - Gestion des fournisseurs".
           05 LINE 15 COLUMN 30 VALUE "4 - Gestion des livraisons".
           05 LINE 16 COLUMN 30 VALUE "5 - Generer un document".
           05 LINE 20 COLUMN 30 VALUE "0 - Deconnexion".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : ".

           05 LINE 22 COLUMN 52 VALUE "[".
           05 LINE 22 COLUMN 54 VALUE "]".
           05 LINE 22 COLUMN 53 PIC X(01) TO WS-CHX.

       01 S-MNU-PRN-ADM.
           05 LINE 17 COLUMN 30 VALUE "6 - Journal de logs".
           05 LINE 18 COLUMN 30 VALUE "7 - Creer un compte utilisateur".

       01 S-MSG-ERR.
           05 LINE 23 COLUMN 03 FROM WS-MSG-ERR.

      ******************************************************************       
       PROCEDURE DIVISION.
      
           PERFORM 0100-CHX-FCT-DEB
              THRU 0100-CHX-FCT-FIN. 

           EXIT PROGRAM.

      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************
       0100-CHX-FCT-DEB.
           SET WS-ETT-BCL-ENC TO TRUE
      * Boucle jusqu'à ce que l'utilisateur tape 0 pour déconnexion
           PERFORM UNTIL WS-ETT-BCL-FIN
               DISPLAY S-FND-ECR
               DISPLAY S-MNU-PRN-COM

               IF G-UTI-RLE EQUAL "ADMIN"
                   DISPLAY S-MNU-PRN-ADM
               END-IF
               
               PERFORM 0400-AFF-ERR-CND-DEB
                  THRU 0400-AFF-ERR-CND-FIN

               ACCEPT S-MNU-PRN-COM

               PERFORM 0200-EVA-CHX-DEB
                  THRU 0200-EVA-CHX-FIN

           END-PERFORM.
       0100-CHX-FCT-FIN.

       0200-EVA-CHX-DEB.
           EVALUATE WS-CHX
               WHEN 1 
      * Appel du sous-programme de gestion du stock.
                   CALL "ecrgspie"
                   END-CALL
               WHEN 2 
      * Appel du sous-programme de gestion des clients.
                   CALL "ecrgscli"
                   END-CALL
               WHEN 3 
      * Appel du sous-programme de gestion des fournisseurs.

               WHEN 4 
      * Appel du sous-programme de gestion des livraisons.

               WHEN 5 
      * Appel du sous-programme de génération de document.

               WHEN 0 
                   SET WS-ETT-BCL-FIN TO TRUE
               WHEN OTHER
                   IF G-UTI-RLE EQUAL "ADMIN"
                       PERFORM 0300-EVA-CHX-ADM-DEB
                          THRU 0300-EVA-CHX-ADM-FIN
                   ELSE
                       PERFORM 0500-ERR-OPT-IVL-DEB
                          THRU 0500-ERR-OPT-IVL-FIN
                   END-IF
           END-EVALUATE.
       0200-EVA-CHX-FIN.

       0300-EVA-CHX-ADM-DEB.
           EVALUATE WS-CHX
               WHEN 6 
      * Appel du sous-programme d'affichage du journal de logs.
                   CALL 'ecrpglog'
                   END-CALL

               WHEN 7 
      * Appel du sous-programme ecrajuti.
                   CALL 'ecrajuti'
                   END-CALL

               WHEN OTHER
                   PERFORM 0500-ERR-OPT-IVL-DEB
                      THRU 0500-ERR-OPT-IVL-FIN
           END-EVALUATE.
       0300-EVA-CHX-ADM-FIN.

       0400-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0400-AFF-ERR-CND-FIN.

       0500-ERR-OPT-IVL-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-OPT-IVL TO WS-MSG-ERR.
       0500-ERR-OPT-IVL-FIN.
