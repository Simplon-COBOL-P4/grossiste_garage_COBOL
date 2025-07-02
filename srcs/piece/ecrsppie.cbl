      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES :                         *
      * ECR=ECRAN; SUP/SP=SUPPRESSION; PIE=PIECE; IDF=IDENTIFIANT;     *
      * CHX=CHOIX; MSG=MESSSAGE; LEU=LEURRE; AFF=AFFICHE;              *
      *                                                                *
      *                     FONCTION DU PROGRAMME :                    *
      * IL PERMET À L'UTILISATEUR DE RENTRER L'IDENTIFIANT D'UNE PIÉCE *
      * POUR LA SUPPRIMER                                              *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrsppie.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 01.07.2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDF-PIE       PIC Z(10).

       01 WS-LEU           PIC X(01).

       01 WS-CHX           PIC 9(01).
           88 WS-CHX-OUI       VALUE 1.
           88 WS-CHX-NON       VALUE 2.
       

       SCREEN SECTION.
           COPY ecrprn.

       01 S-ECR-SUP-PIE.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : ".

           05 LINE 08 COLUMN 22 VALUE "ID de la piece : ".
           05 LINE 08 COLUMN 39 VALUE "[".
           05 LINE 08 COLUMN 50 VALUE "]".
           05 LINE 08 COLUMN 40 PIC Z(10) TO WS-IDF-PIE.

           05 LINE 14 COLUMN 30 VALUE "Supprimer la piece ? ".
           05 LINE 16 COLUMN 31 VALUE "1 - Oui".
           05 LINE 16 COLUMN 41 VALUE "2 - Non".

           05 LINE 18 COLUMN 38 VALUE "[".
           05 LINE 18 COLUMN 40 VALUE "]".
           05 LINE 18 COLUMN 39 PIC 9(01) TO WS-CHX.


       PROCEDURE DIVISION.

      * AFFICHAGE DE L'ÉCRAN 
           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

      * SUPPRIME UNE PIECE 
           PERFORM 0200-SUP-PIE-DEB
              THRU 0200-SUP-PIE-FIN.   


           EXIT PROGRAM.

      ******************************************************************
      ***************************PARAGRAPHES**************************** 

       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.

           DISPLAY S-ECR-SUP-PIE.   
           ACCEPT  S-ECR-SUP-PIE.
       0100-AFF-ECR-FIN.

       0200-SUP-PIE-DEB.
           IF WS-CHX-OUI

              CALL "suppie"
                USING WS-IDF-PIE
              END-CALL         

              DISPLAY "PIECE SUPPRIMEE ! " AT LINE 20 COLUMN 32      
              ACCEPT WS-LEU
      
           ELSE IF WS-CHX-NON

              DISPLAY "SUPPRESSION ANNULEE !" AT LINE 20 COLUMN 30
              ACCEPT WS-LEU

           ELSE 

              DISPLAY "ERREUR DE SAISIE ! "  AT LINE 20 COLUMN 32
              ACCEPT WS-LEU

           END-IF.
       0200-SUP-PIE-FIN.
