      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Cet écran permet à l’utilisateur de rentrer soit l’ID, soit le *
      * nom d’une pièce, pour ensuite l’afficher.                      *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; RE=RECHERCHE; PIE=PIECE; IDT=identifiant; SEU=seuil *
      * AFF=affichage; TRA=traitement; COM=commande; FOR=fournisseur;  *
      * POU=poubelle                                                   *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrrepie.
       AUTHOR. lucas.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDT                  PIC 9(10).
       01 WS-NOM                  PIC X(50).
       01 WS-POU                  PIC 9(10).
       01 WS-SEU                  PIC 9(10).
       01 WS-ID-FOR               PIC 9(10).
       01 WS-NOM-FOR              PIC X(50).

       01 WS-IDT-OU-NOM           PIC X(50).
       01 WS-RE                   PIC X(01).

       SCREEN SECTION.
      * Maquette dans Stock/Ecran lecture piece unique.txt.
       COPY ecrprn.
       01 S-MNU-STD.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           05 LINE 07 COLUMN 03 VALUE "ID/Nom de la piece : [".
           05 LINE 07 COLUMN 75 VALUE "]".
           05 LINE 07 COLUMN 25 PIC X(50) TO WS-IDT-OU-NOM.
           05 LINE 08 COLUMN 02 VALUE "_________________________________
      -     "_____________________________________________".
           05 LINE 21 COLUMN 30 VALUE "1 - Rechercher  0 - Retour".
           05 LINE 22 COLUMN 40 VALUE "[".
           05 LINE 22 COLUMN 42 VALUE "]".
           05 LINE 22 COLUMN 41 PIC X(01) TO WS-RE.

      * Cette écran ne sera affiché que lorsque l'utilisateur aura
      * entrer l'id ou le nom
       01 S-MNU-STD2.
           05 LINE 10 COLUMN 03 VALUE "ID piece :".
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 14 VALUE "]".
           05 LINE 13 COLUMN 03 VALUE "Nom piece :".
           05 LINE 14 COLUMN 03 VALUE "[".
           05 LINE 14 COLUMN 52 VALUE "]".
           05 LINE 16 COLUMN 03 VALUE "Seuil minimum :".
           05 LINE 17 COLUMN 03 VALUE "[".
           05 LINE 17 COLUMN 14 VALUE "]".
           05 LINE 19 COLUMN 03 VALUE "ID fournisseur".
           05 LINE 20 COLUMN 03 VALUE "[".
           05 LINE 20 COLUMN 14 VALUE "]".
           

       PROCEDURE DIVISION.

           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN. 

           PERFORM 0200-TRA-COM-DEB
              THRU 0200-TRA-COM-FIN.     

           EXIT PROGRAM.


      * on affiche l'écran pour que l'utilisateur choisisse ce qu'il 
      * veut entrer.     
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-MNU-STD.
           ACCEPT S-MNU-STD.
       0100-AFF-ECR-FIN.

       0200-TRA-COM-DEB.
           PERFORM UNTIL WS-RE EQUAL 0
               IF WS-RE EQUAL 1
    
                   IF FUNCTION TRIM(WS-IDT-OU-NOM) IS NUMERIC THEN
                   
                       MOVE WS-IDT-OU-NOM TO WS-IDT

      * liridpie a besoin de 6 paramètres.
                       CALL "liridpie"
                           USING
      * Arguments d'entrée
                           WS-IDT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
                           WS-NOM
                           WS-POU *> variable poubelle      
                           WS-SEU
                           WS-ID-FOR
                           WS-NOM-FOR
      * Fin des arguments de sortie
                       END-CALL
                       PERFORM 0300-AFF-VAR-DEB
                          THRU 0300-AFF-VAR-FIN
        
                   ELSE 
                       MOVE WS-IDT-OU-NOM TO WS-NOM
                       CALL "lirnmpie"
                       USING
      * Arguments d'entrée
                           WS-IDT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
                           WS-NOM
                           WS-POU *> variable poubelle    
                           WS-SEU 
                           WS-ID-FOR
                           WS-NOM-FOR
      * Fin des arguments de sortie
                       END-CALL
                       PERFORM 0300-AFF-VAR-DEB
                          THRU 0300-AFF-VAR-FIN
        
                   END-IF
                   DISPLAY S-MNU-STD2
      * La commande est invalide(ni 1, ni 0)
               ELSE    
                   DISPLAY "commande invalide" AT LINE 23
               
               END-IF

               ACCEPT S-MNU-STD
           END-PERFORM.

       0200-TRA-COM-FIN.


      * Paragraphe pour afficher les valeurs des variables à la fin.
       0300-AFF-VAR-DEB.
           DISPLAY WS-IDT    AT LINE 11 COLUMN 04.
           DISPLAY WS-NOM    AT LINE 14 COLUMN 04.
           DISPLAY WS-SEU    AT LINE 17 COLUMN 04.
           DISPLAY WS-ID-FOR AT LINE 20 COLUMN 04.
       0300-AFF-VAR-FIN.