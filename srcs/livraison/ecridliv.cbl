      ******************************************************************
      *                             ENTÊTE                             *
      *  Cet écran permet à l’utilisateur de rentrer l’id d’une        *
      * livraison, afin de d’afficher ses détails                      *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; ID=IDENTIFIANT; LIV=LIVRAISON; NB=nombre; ST=sortie;*
      * STA=statut; TYP=type; ENT=entrante; SOR=sortante; TER=terminer;*
      * DAT=date; CRS=cours; COM=commun; REC=recherche; SEC=secondaire;*
      * CLI=client; FOU=fournisseur; AFF=afficher; VAR=variable;       *
      * UNI=unique; PIE=piece; TRA=traitement; CMD=commande            *
      ******************************************************************
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecridliv.
       AUTHOR. lucas.
       DATE-WRITTEN. 09-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL INCLUDE SQLCA END-EXEC.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NB-LIV-PIE  PIC 9(10).
       01 PG-ID            PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.

      * Variable pour savoir si on quitte le sous-programme ou non.
       01 WS-REC            PIC 9(01).
       01 WS-ID             PIC 9(10).
       01 WS-DAT            PIC X(10).
       01 WS-STA            PIC 9(01).
           88 WS-STA-EN-CRS               VALUE 0.
           88 WS-STA-TER                  VALUE 1.
       01 WS-TYP                    PIC 9(01).
           88 WS-TYP-ENT                  VALUE 0.
           88 WS-TYP-SOR                  VALUE 1.
      * Identifiant et nom fournisseur si entrante,
      * et client si sortante.
       01 WS-ID-ST      PIC 9(10).
       01 WS-NOM-ST     PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.
       COPY ecrprn.

       01 S-ECR-LIV-COM.
          
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que: Admin".
           
           05 LINE 05 COLUMN 03 VALUE "ID de la livraison : [".
           05 LINE 05 COLUMN 35 VALUE "]".
           05 LINE 05 COLUMN 25 PIC Z(10) TO WS-ID.
           05 LINE 06 COLUMN 02 VALUE "_________________________________
      -    "_____________________________________________".

           05 LINE 22 COLUMN 30 VALUE "1 - Rechercher   0 - Annuler".
           05 LINE 23 COLUMN 40 VALUE "[". 
           05 LINE 23 COLUMN 42 VALUE "]".
           05 LINE 23 COLUMN 41 PIC Z TO WS-REC.

       01 S-ECR-LIV-COM-SEC.
           05 LINE 08 COLUMN 03 VALUE "ID :".
           05 LINE 09 COLUMN 03 VALUE "[".
           05 LINE 09 COLUMN 14 VALUE "]".

           05 LINE 14 COLUMN 03 VALUE "Nombre pieces uniques :".
           05 LINE 15 COLUMN 03 VALUE "[".
           05 LINE 15 COLUMN 14 VALUE "]".

           05 LINE 16 COLUMN 03 VALUE "Date :".
           05 LINE 17 COLUMN 03 VALUE "[".
           05 LINE 17 COLUMN 14 VALUE "]".

           05 LINE 18 COLUMN 03 VALUE "Statut :".
           05 LINE 19 COLUMN 03 VALUE "[".
           05 LINE 19 COLUMN 05 VALUE "]".

       01 S-ECR-FOU.
           05 LINE 10 COLUMN 03 VALUE "ID fournisseur".
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 14 VALUE "]".

           05 LINE 12 COLUMN 03 VALUE "Nom fournisseur".
           05 LINE 13 COLUMN 03 VALUE "[".
           05 LINE 13 COLUMN 54 VALUE "]".

       01 S-ECR-CLI.
      * Les espaces après client son mis pour effacer "sseur" de 
      * fournisseur si on affiche l'écran pour le fournisseur puis
      * l'écran pour le client.
           05 LINE 10 COLUMN 03 VALUE "ID client      ".
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 14 VALUE "]".

           05 LINE 12 COLUMN 03 VALUE "Nom client     ".
           05 LINE 13 COLUMN 03 VALUE "[".
           05 LINE 13 COLUMN 54 VALUE "]".

       PROCEDURE DIVISION.


           PERFORM 0100-AFF-ECR-DEB
              THRU 0100-AFF-ECR-FIN.
           
           PERFORM 0200-TRA-CMD-DEB
              THRU 0200-TRA-CMD-FIN.     

           EXIT PROGRAM.

       0100-AFF-ECR-DEB.
      * On commence par afficher les screens.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-LIV-COM.
           ACCEPT S-ECR-LIV-COM.
       0100-AFF-ECR-FIN.

       0200-TRA-CMD-DEB.
      * Boucle tant que l'utilisateur le veut

           PERFORM UNTIL WS-REC EQUAL 0 
               EVALUATE WS-REC
                   WHEN EQUAL 1 
                       CALL "liridliv"
                           USING
      * Arguments d'entrée.
                           WS-ID
      * Fin des arguments d'entrée.
      * Début des arguments de sortie.
                           WS-DAT
                           WS-STA
                           WS-TYP
                           WS-ID-ST
                           WS-NOM-ST
                           WS-LIR-RET
      * Fin des arguments de sortie.
                       END-CALL
      * On regarde le type pour savoir si fournisseur ou client.
                       IF WS-TYP EQUAL 1 *>client
                           DISPLAY S-ECR-LIV-COM-SEC
                           DISPLAY S-ECR-CLI
      * Pour effacer le message d'erreur si nécessaire
                           DISPLAY "                 " LINE 21 COLUMN 03 
                           PERFORM 0400-PIE-UNI-DEB
                              THRU 0400-PIE-UNI-FIN
                           PERFORM 0300-AFF-VAR-DEB
                              THRU 0300-AFF-VAR-FIN
                       ELSE *>fournisseur
                           DISPLAY S-ECR-LIV-COM-SEC
                           DISPLAY S-ECR-FOU
                           DISPLAY "                 " LINE 21 COLUMN 03 
                           PERFORM 0400-PIE-UNI-DEB
                              THRU 0400-PIE-UNI-FIN
                           PERFORM 0300-AFF-VAR-DEB
                              THRU 0300-AFF-VAR-FIN
                   WHEN OTHER
                       DISPLAY "commande invalide" LINE 21 COLUMN 03 
               END-EVALUATE
      * L'utilisateur doit pouvoir entrer une autre commande.
               ACCEPT S-ECR-LIV-COM
           END-PERFORM.
       0200-TRA-CMD-FIN.


      * Paragraphe pour afficher les variables dans la screen.
       0300-AFF-VAR-DEB.
           DISPLAY WS-ID           LINE 09 COLUMN 04.
           DISPLAY PG-NB-LIV-PIE   LINE 15 COLUMN 04.
           DISPLAY WS-DAT          LINE 17 COLUMN 04.
           DISPLAY WS-STA          LINE 19 COLUMN 04.
           DISPLAY WS-ID-ST        LINE 11 COLUMN 04.
           DISPLAY WS-NOM-ST       LINE 13 COLUMN 04.
       0300-AFF-VAR-FIN.

      * Paragraphe pour connaire le nombre de pièce différente 
      * demandé par la livraison.
       0400-PIE-UNI-DEB.
           MOVE WS-ID TO PG-ID.

           EXEC SQL
           SELECT COUNT(*)
           INTO :PG-NB-LIV-PIE
           FROM Livraison_Piece
           WHERE id_liv = :PG-ID
           END-EXEC.
       0400-PIE-UNI-FIN.