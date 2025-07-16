      ******************************************************************
      *                             ENTÊTE                             *
      * Ecran de mise a jour des infos d'une piece.                    *
      * Cet écran permet à l’utilisateur de rentrer les différents     *
      * arguments nécessaire à la mise à jour d’une pièce.             *
      * L’utilisateur rentre l’ID de la pièce, puis appuie sur entrée. *
      * Cela appelle le sous programme liridpie, qui récupère les      *
      * informations de la pièce, en fonction de l’ID.                 *
      * Suite à cela, il faut afficher les informations récupérées, ce *
      * qui donne à l’utilisateur la possibilité de les modifier, avant*
      * de valider, ce qui appelle le sous programme mjinfpie. 
      *                                                                *
      *                           TRIGRAMMES                           *
      * AFC=Afficher                                                   *
      * DEB=Debut                                                      *
      * ECR=Ecran                                                      *
      * FIN=Fin                                                        *
      * IDT=Identité                                                   *
      * INF=Information                                                *
      * LIR=Lire                                                       *
      * NOM=Nom                                                        *
      * PBL=Poubelle                                                   *
      * PIE=Piece                                                      *
      * SSI=Saisi                                                      *
      * SUI=Seuil                                                      *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjinf.
       AUTHOR. Benoit.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDT-PIE           PIC 9(10).
       01 WS-NOM-PIE           PIC X(50).
       01 WS-SUI-PIE           PIC 9(10).
       01 WS-IDT-FOU           PIC 9(10).
       01 WS-PBL               PIC X(50).
       01 WS-MAJ-RET           PIC X(01).

       SCREEN SECTION.
       COPY ecrprn.

       01  S-ECR-SSI-01.
           05 LINE 04 COL 03 VALUE 'Connecte en tant que : Admin'.
           05 LINE 07 COL 23 VALUE 'ID de la piece : [          ]'.
           05 LINE 09 COL 03 VALUE 'Nom piece :'.
           05 LINE 10 COL 03 VALUE '[                                   
      -                            '               ]'.
           05 LINE 12 COL 03 VALUE 'Seuil minimum :'.
           05 LINE 13 COL 03 VALUE '[          ]'.
           05 LINE 15 COL 03 VALUE 'ID fournisseur :'.
           05 LINE 16 COL 03 VALUE '[          ]'.
           05 LINE 20 COL 23 VALUE 'Mettre a jour ?'.
           05 LINE 21 COL 20 VALUE '1 - Oui   0 - Retour'.
           05 LINE 22 COL 30 VALUE '[ ]'.
           05 LINE 22 COL 31 PIC X(01) USING WS-MAJ-RET.

       01  S-ECR-SSI-IDT.
           05 LINE 07 COL 41 PIC Z(10) TO WS-IDT-PIE AUTO.

       01  S-ECR-SSI-INF.
           05 LINE 10 COL 04 PIC X(50) USING WS-NOM-PIE AUTO.
           05 LINE 13 COL 04 PIC Z(10) USING WS-SUI-PIE AUTO.
           05 LINE 16 COL 04 PIC Z(10) USING WS-IDT-FOU AUTO.
           05 LINE 22 COL 31 PIC X(01) USING WS-MAJ-RET AUTO.



       PROCEDURE DIVISION.
      *
      * Affiché l'ecran de saisi
      * 
           PERFORM 0100-AFC-ECR-DEB
              THRU 0100-AFC-ECR-FIN.
      *
      * Saisir l'ID de la piece et les modifications souhaites puis 
      * confirmer la mise-à-jour.
      *
           PERFORM 0150-SSI-DEB
              THRU 0150-SSI-FIN.
      
           EXIT PROGRAM.
      * 
      * Afficher l'ecran de saisi
      *
       0100-AFC-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-SSI-01.

       0100-AFC-ECR-FIN.
           EXIT.

       0150-SSI-DEB.
           PERFORM UNTIL WS-MAJ-RET = '0'
               PERFORM 0200-SSI-IDT-DEB
                  THRU 0200-SSI-IDT-FIN
               PERFORM 0300-LIR-PIE-DEB
                  THRU 0300-LIR-PIE-FIN
               PERFORM 0400-SSI-MOD-DEB
                  THRU 0400-SSI-MOD-FIN
           END-PERFORM.

       0150-SSI-FIN.
           EXIT.
      *
      * Saisir l'id de la piece à mdifier
      * 
       0200-SSI-IDT-DEB.
           MOVE 0 TO WS-IDT-PIE.
           PERFORM UNTIL WS-IDT-PIE <> 0
             ACCEPT S-ECR-SSI-IDT
           END-PERFORM.

       0200-SSI-IDT-FIN.
           EXIT.
      *
      * Appeler lireidpie en specifiant l'id de la piece
      * 
       0300-LIR-PIE-DEB.
           CALL "liridpie"
               USING
      * Arguments d'entrée
               WS-IDT-PIE
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-NOM-PIE
               WS-SUI-PIE
               WS-IDT-FOU
      * Argument non utilisé, obligé de le mettre quand même.
               WS-PBL
      * Fin des arguments de sortie
           END-CALL.

       0300-LIR-PIE-FIN.
           EXIT.
      *
      * Modifier les données de la piece en question puis taper '1'
      * pour confirmer la mise-à-jour.
      *
       0400-SSI-MOD-DEB.
           MOVE ' ' TO WS-MAJ-RET.
           ACCEPT S-ECR-SSI-INF.
      *
      * Si la modification est conformée, appelé le programme mjinfpie
      * poue enrégistrer les modifications; si non retour à l'ecran de 
      * saisi.
      *
           IF WS-MAJ-RET = '1' THEN
              CALL "mjinfpie"
                 USING
      * Arguments d'entrée
                 WS-IDT-PIE
                 WS-NOM-PIE
                 WS-SUI-PIE
                 WS-IDT-FOU
      * Fin des arguments d'entrée
              END-CALL
           END-IF.  

       0400-SSI-MOD-FIN.
           EXIT.
