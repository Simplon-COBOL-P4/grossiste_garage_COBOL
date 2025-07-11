      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Programme d'affichage de l'écran permettant la suppression     *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRIMER; LIV=LIVRAISON; ID=IDENTIFIANT;        *
      * DAT=DATE; STA=STATUT; COU=COURS; TER=TERMINER; TYP=TYPE;       *
      * ENT=ENTREE; SOR=SORTIE; PIE=PIECE; QTE=QUANTITE; CMD=COMMANDE  *
      * ETA=ETAT; LEC=LECTURE                                          *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspliv.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 10-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-ID                   PIC 9(10).
       01  WS-DAT                  PIC X(10).
       01  WS-STA                  PIC 9(01).
           88 WS-STA-EN-COU       VALUE 0.
           88 WS-STA-TER          VALUE 1.
       01  WS-TYP                  PIC 9(01).
           88 WS-TYP-ENT          VALUE 0.
           88 WS-TYP-SOR          VALUE 1.
      * WS-ID et WS-NOM fournisseur si entrante,
      * et client si sortante.
       01  WS-ID-SOR               PIC 9(10).
       01  WS-NOM-SOR              PIC X(50).
      * Elements de piece pour l'inversion d'opération 
       01  WS-ID-PIE               PIC 9(10).
       01  WS-QTE                  PIC 9(10).
 
       01  WS-CMD                  PIC 9(01).
      * Etat de la lecture des pièces associés 
       01  WS-ETA-LEC              PIC 9(01).
           88 WS-ETA-LEC-OK                  VALUE 0.
           88 WS-ETA-LEC-FIN                 VALUE 1.

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.    
       COPY supret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY "ecrprn".

       01 S-SP-LIV.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           05 LINE 06 COLUMN 25 VALUE "ID du client : [".
           05 LINE 06 COLUMN 51 VALUE "]".
           05 LINE 06 COLUMN 41 PIC Z(10) TO WS-ID.

           05 LINE 22 COLUMN 30 VALUE "1 - Supprimer   0 - Annuler".
           05 LINE 23 COLUMN 37 VALUE "[ ]".
           05 LINE 23 COLUMN 38 PIC Z TO WS-CMD.

       PROCEDURE DIVISION.

           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-LEC-CMD-DEB
              THRU 0200-LEC-CMD-FIN.   

           EXIT PROGRAM.


      * Paragraphe pour afficher l'écran.    
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-SP-LIV.
       0100-AFF-ECR-FIN.    

      * Paragraphe pour permettre à l'utilisateur d'entrer un id client
      * et de choisir s'il veut le supprimer ou non
       0200-LEC-CMD-DEB.
           MOVE 2 TO WS-CMD.
           PERFORM UNTIL WS-CMD = 0
               ACCEPT S-SP-LIV
               EVALUATE WS-CMD
                   WHEN 1

      * Lecture de la livraison par l'id pour récupérer le statut de la
      * livraison         
                       CALL "liridliv"
                           USING WS-ID
                                 WS-DAT
                                 WS-STA
                                 WS-TYP
                                 WS-ID-SOR
                                 WS-NOM-SOR
                                 WS-LIR-RET
                       END-CALL

      * Avant de supprimer une livraison, vérifier qu'elle est bien
      * en cours.

                       IF WS-STA-EN-COU

      * Dans le cas d'une livraison sortante, inverser les operations
      * avant de la supprimer.

                           IF WS-TYP-SOR

                               PERFORM UNTIL WS-ETA-LEC-FIN

      * Fetch de l'id d'une piece et de sa quantité lié à une livraison
                                   CALL "fetlivpi"
                                       USING WS-ID, 
                                             WS-ID-PIE, 
                                             WS-QTE, 
                                             WS-ETA-LEC
                                   END-CALL

      * Mise à jour de la pièce avec un retrait de la quantité
                                   CALL "majpie"
                                       USING WS-ID-PIE, WS-QTE, 0
                                   END-CALL
      
                               END-PERFORM
      
                           END-IF
      
                           CALL "supliv"
                               USING WS-ID, WS-SUP-RET
                           END-CALL
      
                       ELSE
      
                           DISPLAY "Livraison déjà terminée," 
                           "non supprimée." 
                           LINE 15 COLUMN 10
      
                       END-IF
      
                   WHEN 0
                       DISPLAY "Annulation utilisateur." 
                       LINE 15 COLUMN 10
      
                   WHEN OTHER
                       DISPLAY "Commande incomprise." LINE 15 COLUMN 10
               END-EVALUATE
           END-PERFORM.
       0200-LEC-CMD-FIN. 

