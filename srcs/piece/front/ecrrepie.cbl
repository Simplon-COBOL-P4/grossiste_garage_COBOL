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
       01 WS-CHX                  PIC X(01).
           88 WS-CHX-VID                  VALUE " ".
           

       01 WS-ERR-SQL-NOM-ID       PIC X(76) VALUE
           "Le nom/ID de la piece n'existe pas".

       01 WS-SUC-LIR              PIC X(76) VALUE
           "Lecture reussie".

       01 WS-ETT-BCL              PIC 9(01).
           88 WS-ETT-BCL-ENC                VALUE 1.
           88 WS-ETT-BCL-FIN                VALUE 2.

       01 WS-MNU-2                PIC 9(01).
           88 WS-MNU-2-INV                  VALUE 1.
           88 WS-MNU-2-VIS                  VALUE 2.

       COPY ctxerr.

       COPY utiglb.

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
      * Maquette dans Stock/Ecran lecture piece unique.txt.
       COPY ecrprn.
       01 S-MNU-STD.
           COPY ecrutlin.

           05 LINE 07 COLUMN 03 VALUE "ID/Nom de la piece : [".
           05 LINE 07 COLUMN 75 VALUE "]".
           05 LINE 07 COLUMN 25 PIC X(50) TO WS-IDT-OU-NOM.
           05 LINE 08 COLUMN 02 VALUE "_________________________________
      -     "_____________________________________________".
           05 LINE 22.
               10 COLUMN 70 VALUE "Retour ".
               10 COLUMN 77 VALUE "[".
               10 COLUMN 78 PIC X(01) USING WS-CHX.
               10 COLUMN 79 VALUE "]".

      * Cette écran ne sera affiché que lorsque l'utilisateur aura
      * entrer l'id ou le nom
       01 S-MNU-STD-2.
           05 LINE 10 COLUMN 03 VALUE "ID piece :".
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 14 VALUE "]".
           05 LINE 13 COLUMN 03 VALUE "Nom piece :".
           05 LINE 14 COLUMN 03 VALUE "[".
           05 LINE 14 COLUMN 54 VALUE "]".
           05 LINE 16 COLUMN 03 VALUE "Seuil minimum :".
           05 LINE 17 COLUMN 03 VALUE "[".
           05 LINE 17 COLUMN 14 VALUE "]".
           05 LINE 19 COLUMN 03 VALUE "ID fournisseur".
           05 LINE 20 COLUMN 03 VALUE "[".
           05 LINE 20 COLUMN 14 VALUE "]".

           05 LINE 11 COLUMN 04 FROM WS-IDT.
           05 LINE 14 COLUMN 04 FROM WS-NOM.
           05 LINE 17 COLUMN 04 FROM WS-SEU.
           05 LINE 20 COLUMN 04 FROM WS-ID-FOR.
           
       01 S-MSG-ERR.
           05 LINE 23 COLUMN 03 FROM WS-MSG-ERR.

       PROCEDURE DIVISION.

           PERFORM 0200-TRA-COM-DEB
              THRU 0200-TRA-COM-FIN.     

           EXIT PROGRAM.

      * on affiche l'écran pour que l'utilisateur choisisse ce qu'il 
      * veut entrer.     
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.

           PERFORM 0500-AFF-ERR-CND-DEB
              THRU 0500-AFF-ERR-CND-FIN.

           PERFORM 0600-AFF-MNU-2-CND-DEB
              THRU 0600-AFF-MNU-2-CND-FIN

           ACCEPT S-MNU-STD.
       0100-AFF-ECR-FIN.

       0200-TRA-COM-DEB.
           SET WS-ETT-BCL-ENC TO TRUE.
           SET WS-CHX-VID TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN

               PERFORM 0100-AFF-ECR-DEB
                  THRU 0100-AFF-ECR-FIN

               EVALUATE TRUE
                   WHEN WS-CHX-VID
                       PERFORM 0300-APL-PRG-DEB
                          THRU 0300-APL-PRG-FIN
                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE
               END-EVALUATE
           END-PERFORM.

       0200-TRA-COM-FIN.

       0300-APL-PRG-DEB.
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
                   WS-LIR-RET
      * Fin des arguments de sortie
               END-CALL
        
           ELSE 
               MOVE WS-IDT-OU-NOM TO WS-NOM
               CALL "lirnmpie"
               USING
      * Arguments d'entrée
                   WS-NOM
      * Fin des arguments d'entrée
      * Début des arguments de sortie
                   WS-IDT
                   WS-POU *> variable poubelle    
                   WS-SEU 
                   WS-ID-FOR
                   WS-NOM-FOR
                   WS-LIR-RET
      * Fin des arguments de sortie
               END-CALL
           END-IF.

           IF WS-LIR-RET-OK THEN
               PERFORM 0900-SUC-LIR-DEB
                  THRU 0900-SUC-LIR-FIN
               SET WS-MNU-2-VIS TO TRUE
           ELSE
               PERFORM 0700-ERR-SQL-NOM-ID-DEB
                  THRU 0700-ERR-SQL-NOM-ID-FIN
           END-IF.

       0300-APL-PRG-FIN.

       0500-AFF-ERR-CND-DEB.
           IF WS-CTX-AFF-ERR THEN
               DISPLAY S-MSG-ERR
               SET WS-CTX-OK TO TRUE
           END-IF.
       0500-AFF-ERR-CND-FIN.

       0600-AFF-MNU-2-CND-DEB.
           IF WS-MNU-2-VIS THEN
               DISPLAY S-MNU-STD-2
               SET WS-MNU-2-INV TO TRUE
           END-IF.
       0600-AFF-MNU-2-CND-FIN.

       0700-ERR-SQL-NOM-ID-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-ERR-SQL-NOM-ID TO WS-MSG-ERR.
       0700-ERR-SQL-NOM-ID-FIN.

       0900-SUC-LIR-DEB.
           SET WS-CTX-AFF-ERR TO TRUE.
           MOVE WS-SUC-LIR TO WS-MSG-ERR.
       0900-SUC-LIR-FIN.
