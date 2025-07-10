      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet à l’utilisateur de choisir de quelle manière  *
      * il souhaite lire les fournisseurs, soit via une recherche par  *
      * nom/ID, soit en les affichant par page.                        *
      * L’utilisateur a juste le choix entre deux options, qui         *
      * appellent les sous programmes ecrrefou ou ecrpgfou.            *
      *                                                                *
      *                           TRIGRAMMES                           *
      * CH=Choix                                                       *
      * ECR=Ecran                                                      *
      * ERR=Erreur                                                     *
      * EVA=Evaluer                                                    *
      * DEB=Début                                                      *
      * FIN=Fin                                                        *
      * FOU=Fournisseur                                                *
      * STD=Standard                                                   *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrchfou.
       AUTHOR. Benoit.
       DATE-WRITTEN. 10-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77  WS-STD                 PIC X(08) VALUE 'STANDARD'.
       77  WS-CH                  PIC X(01).
       77  WS-ERR                 PIC X(01).

       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-CH-FOU.
           05 LINE 04 COL 03 VALUE 'Connecte en tant que : '.
           05 LINE 04 COL 26 PIC X(08) FROM WS-STD.
           05 LINE 09 COL 30 VALUE 'Afficher :'.
           05 LINE 13 COL 30 VALUE '1 - Un fournisseur'.
           05 LINE 14 COL 30 VALUE '2 - La liste complete'.
           05 LINE 19 COL 30 VALUE '0 - Retour au menu'.
           05 LINE 22 COL 30 VALUE 'Entrez votre choix : [ ]'.
           05 LINE 22 COL 52 PIC X(01) TO WS-CH.

       PROCEDURE DIVISION.

           PERFORM 0100-CH-FOU-DEB
              THRU 0100-CH-FOU-FIN.
           EXIT PROGRAM.

       0100-CH-FOU-DEB.
      *
      * Affichage de l'écran.
      *
           DISPLAY S-FND-ECR.
      *
      * Entrez votre choix
      * Si '0' retour au programme appelant
      * Si '1' appel programme 'ecrrefou' pour afficher un fournisseur
      * Si '2' appel programme 'ecrpgfou' pour afficher une liste de
      * fournisseurs.
      *
           PERFORM UNTIL WS-CH = '0'
      *
      * Entrez votre choix.
      *
               ACCEPT S-ECR-CH-FOU
               PERFORM 0200-EVA-DEB
                  THRU 0200-EVA-FIN
      
           END-PERFORM.

       0100-CH-FOU-FIN.
           EXIT.

       0200-EVA-DEB.
           EVALUATE WS-CH
               WHEN '1'   
                   CALL "ecrrefou"
                   END-CALL
               WHEN '2'
                   CALL "ecrpgfou"
                   END-CALL
               WHEN <> '0'
                   DISPLAY 'Veillez saisir une des options existantes'
                                                        AT LINE 23 COL 2
                   ACCEPT WS-ERR AT LINE 23 COL 43                
                   DISPLAY '                                         '
                                                        AT LINE 23 COL 2
           END-EVALUATE.

       0200-EVA-FIN.
           EXIT.
