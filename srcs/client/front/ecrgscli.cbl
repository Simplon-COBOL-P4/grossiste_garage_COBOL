      ******************************************************************
      *                             ENTÊTE                             *
      * Cet écran permet de choisir l’action à effectuer vis-à-vis des *
      * clients, se référer à la maquette pour voir ce qu’il faut      *
      * afficher. Il doit afficher des lignes différentes en fonction  *
      * de l’argument principal (Role), car ce n’est pas les mêmes     *
      * options selon si c’est un utilisateur standard, ou admin.      *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; GS=GESTION; CLI=Client; ROL=role; ST=standard       *
      * AD=admin; AFF=afficher                                         *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgscli.
       AUTHOR. lucas.
       DATE-WRITTEN. 03-07-2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.
      * Le numéro de la commande entrer par l'utilisateur
       01 WS-CMD PIC 9(01).

       COPY utiglb.

       SCREEN SECTION.
       COPY ecrprn.
      * La maquette pour l'utilisateur standard est 
      * 13-Ecran gestion clients(utilisateur).txt.
       01 S-ECR-ST.
           COPY ecrutlin.
           05 LINE 09 COLUMN 30 VALUE "Gestion des clients".
           05 LINE 13 COLUMN 30 VALUE "1 - Ajouter un client".
           05 LINE 14 COLUMN 30 VALUE "2 - Afficher un client".
           05 LINE 19 COLUMN 30 VALUE "0 - Retour au menu ".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : [_]".
           05 LINE 22 COLUMN 52 PIC Z TO WS-CMD.

      * La maquette pour l'admin est 
      * 12-Ecran gestion clients(admin).txt.
       01 S-ECR-AD.
           05 LINE 04 COLUMN 02 VALUE "Connecte en tant que : ". 
           05 LINE 15 COLUMN 30 VALUE "3 - Modifier un client".
           05 LINE 16 COLUMN 30 VALUE "4 - Supprimer un client".
       
       PROCEDURE DIVISION.
           
           PERFORM 0100-AFF-ECR-DEB
               THRU 0100-AFF-ECR-FIN.

           PERFORM 0200-TRA-CMD-DEB
               THRU 0200-TRA-CMD-FIN.
    
           EXIT PROGRAM.


      * Paragraphe qui gère l'affichage de l'écran.
       0100-AFF-ECR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-ST.
           IF G-UTI-RLE EQUAL "ADMIN"
               DISPLAY S-ECR-AD
               DISPLAY "admin" AT LINE 04 COLUMN 25
           ELSE
               DISPLAY "standard" AT LINE 04 COLUMN 25
           END-IF.
       0100-AFF-ECR-FIN.

      * Paragraphe qui gère la commande de l'utilisateur.
       0200-TRA-CMD-DEB.
           ACCEPT S-ECR-ST.
           PERFORM UNTIL WS-CMD EQUAL 0
               EVALUATE WS-CMD
                   WHEN EQUAL 1
                       CALL "ecrajcli"
                       END-CALL
                   WHEN EQUAL 2
                       CALL "ecrchcli"
                       END-CALL
                   WHEN EQUAL 3 AND G-UTI-RLE EQUAL "ADMIN"
                       CALL "ecrmjcli"
                       END-CALL
                   WHEN EQUAL 4 AND G-UTI-RLE EQUAL "ADMIN"
                       CALL "ecrspcli"
                       END-CALL
                   WHEN 0
                       EXIT PROGRAM
                   WHEN OTHER 
                       DISPLAY "commande incorrecte" 
                       AT LINE 21 COLUMN 5
                       ACCEPT S-ECR-ST
               END-EVALUATE
           END-PERFORM.


       0200-TRA-CMD-FIN.
