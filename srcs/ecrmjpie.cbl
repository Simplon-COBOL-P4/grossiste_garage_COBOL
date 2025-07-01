      ******************************************************************
      *                             ENTÊTE                             *
      * Ce programme sert à modifier la quantité d'une pièce.          *
      * L’utilisateur rentre l’ID de la pièce, le nombre de pièce à    *
      * faire entrer/sortir, ainsi que le type d’action (ajout/retrait)*
      * et appel le sous programme "majpie" pour exécuter l'action     *
      * souhaitée (ajout/retrait).                                     *
      * C'est le programme 'mijpie' qui doit afficher le message       *
      * suivant 'Mise à jour effectuée !' une fois que la mise à jour  *
      * de la pièce est réussie.                                       * 
      *                                                                *
      *                           TRIGRAMMES                           *
      * ACT=ACTION                                                     *
      * AFC=AFFICHAGE                                                  *
      * DEB=DEBUT                                                      *
      * ECR=ECRAN                                                      *
      * FIN=FIN                                                        *
      * IDT=IDENTITE                                                   *
      * MAJ=MISE A JOUR                                                *
      * PIE=PIECE                                                      *
      * QTE=QUANTITE                                                   *
      * SSI SAISIE                                                     *
      * TYP=TYPE                                                       *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjpie.
       AUTHOR. Benoit.
       DATE-WRITTEN. 01-07-2025 (FR).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PIE-TYP               PIC 9(01).
           88 AJOUT                       VALUE 0.
           88 ENLEVER                     VALUE 1.

       77 WS-PIE-IDT               PIC 9(10).
       77 WS-PIE-QTE               PIC 9(10). 
       77 WS-PIE-ACT               PIC 9(01).

       SCREEN SECTION.
       COPY ecrprn.

       01  ECR-SSI-01.
           05  LINE 4  COL 3  VALUE 'Connecte en tant que : Admin'.
           05  LINE 6  COL 23 VALUE 'ID de la piece : ['.
           05  LINE 6  COL 51 VALUE ']'.
           05  LINE 6  COL 41 PIC Z(10) TO WS-PIE-IDT AUTO.
           05  LINE 10 COL 3  VALUE 'Quantite : '.
           05  LINE 11 COL 3  VALUE '['.
           05  LINE 11 COL 14 VALUE ']'.
           05  LINE 11 COL 4  PIC Z(10) TO WS-PIE-QTE AUTO.
           05  LINE 12 COL 3  VALUE 'Ajouter (1) Enlever (2) :'.
           05  LINE 13 COL 3  VALUE '['.
           05  LINE 13 COL 5  VALUE ']'.
           05  LINE 13 COL 4  PIC Z(01) TO WS-PIE-ACT AUTO.

       PROCEDURE DIVISION.

      * Afficher l'écran de travail
       PERFORM 0100-AFC-ECR-DEB 
          THRU 0100-AFC-ECR-FIN.

      * Saisir l'ecran du travail. Tous les chapms sont obligatoires
       PERFORM 0100-SSI-ECR UNTIL WS-PIE-IDT <> 0 AND
               WS-PIE-QTE <> 0 AND (WS-PIE-ACT = 1 OR 2).

      * Appeler le sous programme 'majpie' pour faire les modifs.
       PERFORM 0100-MAJ-DEB
          THRU 0100-MAJ-FIN.
       EXIT PROGRAM.

      * Affiche l'ecran de saisi
       0100-AFC-ECR-DEB.    
           DISPLAY S-FND-ECR.
           DISPLAY ECR-SSI-01.
       0100-AFC-ECR-FIN.

      * Saisir l'id et la qantité de la pièce à modifier et l'action
      * (Ajout/Enlever) à faire 
       0100-SSI-ECR.
           ACCEPT ECR-SSI-01.
           IF WS-PIE-ACT = 1 THEN
              SET AJOUT TO TRUE
           ELSE
              SET ENLEVER TO TRUE
           END-IF.
  
       0100-MAJ-DEB.
           CALL "majpie"
               USING
               WS-PIE-IDT
               WS-PIE-QTE
               WS-PIE-TYP
           END-CALL.
       0100-MAJ-FIN.
           EXIT.
      
