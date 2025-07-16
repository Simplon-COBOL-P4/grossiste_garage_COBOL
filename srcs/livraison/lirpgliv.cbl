      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      * LIR=LIRE; PG,PGE=PAGE; LIV=LIVRAISON; NBR=NOMBRE; ELM=ELEMENT; *
      * IDF=IDENTIFIANT; FOU=FOURNISSEUR; CLI=CLIENT; PIE=PIECE;       *
      * FIL=FILTRE; VID=VIDE; TAB=TABLEAU; LIV=LIVRAISON; DAT=DATE;    *
      * STA=STATUT; CRS=COURS; TRM=TERMINE; TYP=TYPE; ENT=ENTRANT;     *
      * SOR=SORTANT; QTE=QUANTITE; OFS=OFFSET; LIN=LIGNE;              *
      * EVA=EVALUATION; CSR= CURSEUR; AFC= AFFECTATION
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpgliv.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NBR-ELM                     PIC 9(02). *> Min 1 - Max 25
       01 PG-OFS                         PIC 9(03).  

       01 PG-IDF-FOU-CLI-PIE             PIC 9(10).
       
       01 PG-IDF-LIV           PIC 9(10).
       01 PG-IDF-FOU-CLI       PIC 9(10).
       01 PG-NOM-FOU-CLI       PIC X(50).
       01 PG-QTE-PIE           PIC 9(10).
       01 PG-DAT-LIV           PIC X(10).

       01 PG-STA-LIV           PIC 9(01).
           88 PG-STA-EN-CRS                   VALUE 0.
           88 PG-STA-TRM                      VALUE 1.
       
       01 PG-TYP-LIV           PIC 9(01).
                   88 PG-TYP-ENT                      VALUE 0.
                   88 PG-TYP-SOR                      VALUE 1.

       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Le nombre de lignes ajouter dans le tableau.
       01 WS-NBR-LIN-TAB        PIC 9(02).
               
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       
       LINKAGE SECTION.
      * Arguments d'entrée.
       77 LK-PGE                         PIC 9(10).
       77 LK-NBR-ELM                     PIC 9(02).
       77 LK-IDF-FOU-CLI-PIE             PIC 9(10).
       
       01 LK-FIL                         PIC 9(01).
           88 LK-FIL-VID                              VALUE 0.
           88 LK-FIL-FOU                              VALUE 1.
           88 LK-FIL-CLI                              VALUE 2.
           88 LK-FIL-PIE                              VALUE 3.
      * Arguments de sortie.
       01 LK-TAB.
           05 LK-LIV OCCURS 25 TIMES.
               10 LK-IDF-LIV           PIC 9(10).
               10 LK-DAT-LIV           PIC X(10).

               10 LK-STA-LIV           PIC 9(01).
                   88 LK-STA-EN-CRS                   VALUE 0.
                   88 LK-STA-TRM                      VALUE 1.

               10 LK-TYP-LIV           PIC 9(01).
                   88 LK-TYP-ENT                      VALUE 0.
                   88 LK-TYP-SOR                      VALUE 1.
                   
               10 LK-IDF-FOU-CLI       PIC 9(10).
               10 LK-NOM-FOU-CLI       PIC X(50).
      * Attention à l'ambivalence de cet argument, il peut etre le
      * nombre de variete de pieces dans une livraison, comme le nombre
      * de piece de l'ID demandé dans la livraison. 
               10 LK-QTE-PIE           PIC 9(10).
       


       PROCEDURE DIVISION USING LK-PGE,
                                LK-NBR-ELM,
                                LK-IDF-FOU-CLI-PIE,
                                LK-FIL,
                                LK-TAB,
                                WS-LIR-RET.
           

           PERFORM 0050-AFC-IDF-FIL-DEB
              THRU 0050-AFC-IDF-FIL-FIN.

           PERFORM 0100-OFS-DEB
              THRU 0100-OFS-FIN.

           PERFORM 0200-EVA-FIL-DEB
              THRU 0200-EVA-FIL-FIN.

           EXIT PROGRAM.


      ******************************************************************
      *                         PARAGRAPHES                            * 
      ****************************************************************** 
       
       0050-AFC-IDF-FIL-DEB.
       
           MOVE LK-IDF-FOU-CLI-PIE
           TO   PG-IDF-FOU-CLI-PIE.

           EXIT.

       0050-AFC-IDF-FIL-FIN.
       
      *-----------------------------------------------------------------

       0100-OFS-DEB.

      * Récupération de l'offset. C'est à partir de celui-ci que la 
      * la lecture va commencer. Il est donc défini comme étant le 
      * résultat du produit du numéro de page par le nombre d'éléments
      * par page.
           MULTIPLY LK-PGE BY LK-NBR-ELM GIVING PG-OFS.

      * Récupération de la limite dans une variable à utiliser dans 
      * SQL. Celle-ci est définie comme étant le nombre d'éléments à 
      * afficher par page.
           MOVE LK-NBR-ELM TO PG-NBR-ELM.
       
           EXIT.
       0100-OFS-FIN.

      *-----------------------------------------------------------------

       0200-EVA-FIL-DEB.

           EVALUATE TRUE 
               
               WHEN LK-FIL-VID
               
                   PERFORM 0300-CSR-FIL-VID-DEB
                      THRU 0300-CSR-FIL-VID-FIN

               WHEN LK-FIL-FOU

                   PERFORM 0400-CSR-FIL-FOU-DEB
                      THRU 0400-CSR-FIL-FOU-FIN
                   
                   SET LK-TYP-ENT TO TRUE 

               WHEN LK-FIL-CLI
                   
                   PERFORM 0500-CSR-FIL-CLI-DEB
                      THRU 0500-CSR-FIL-CLI-FIN

                   SET LK-TYP-SOR TO TRUE 

               WHEN LK-FIL-PIE
                   
                   PERFORM 0600-CSR-FIL-PIE-DEB
                      THRU 0600-CSR-FIL-PIE-FIN

           END-EVALUATE.


           EXIT.
       0200-EVA-FIL-FIN.
       
      *-----------------------------------------------------------------
       
       0300-CSR-FIL-VID-DEB.

      * Déclaration du curseur pour la table livraison. 
           EXEC SQL
               DECLARE curseur_liv CURSOR FOR 
               SELECT livraison.id_liv, 
                      COUNT(livraison.id_liv) AS nbr_typ_pie,
                      livraison.date_deb_liv, livraison.statut_liv,
                      COALESCE(fournisseur.nom_fou, client.nom_cli) 
                      AS nom_fou_cli,
                      COALESCE(fournisseur.id_fou, client.id_cli) 
                      AS id_fou_cli,
                      CASE 
                          WHEN client.id_cli IS NOT NULL THEN 1
                          WHEN fournisseur.id_fou IS NOT NULL THEN 0 
                      END AS type_liv
               
               FROM livraison    
               
               JOIN fournisseur 
                 ON livraison.id_fou = fournisseur.id_fou 
               
               JOIN client
                 ON livraison.id_cli = client.id_cli

               JOIN livraison_piece
                 ON livraison.id_liv = livraison_piece.id_liv
               GROUP BY livraison.id_liv

               LIMIT :PG-NBR-ELM
               OFFSET :PG-OFS
               FOR READ ONLY
           END-EXEC.           

      * Ouverture du curseur.
           EXEC SQL
               OPEN curseur_liv
           END-EXEC. 

      * En cas d'erreur lors de l'ouverture du curseur, le programme est
      * arrêté et le code d'erreur est renvoyé.
           IF SQLCODE NOT EQUAL 0
               SET WS-LIR-RET-ERR TO TRUE 
               EXIT PROGRAM
           END-IF.
           
      * Initialisation du nombre de lignes du tableau. 
           MOVE 0 TO WS-NBR-LIN-TAB.

      * Lecture du curseur tant que le SQLCODE n'est pas égal à 100, et 
      * donc qu'on ne se trouve pas au bout du curseur.
           PERFORM UNTIL SQLCODE = 100 
               
               EXEC SQL

      * Récupération des données suivantes : id et nom du fournisseur  
      * ou client selon le type de livraison, id, date de début et   
      * statut de livraison, la quantité de types de pièces dans une
      * livraison ainsi que le type de livraison. 
                   FETCH curseur_liv into 
                   :PG-IDF-LIV,
                   :PG-QTE-PIE,
                   :PG-DAT-LIV,
                   :PG-STA-LIV,
                   :PG-NOM-FOU-CLI,
                   :PG-IDF-FOU-CLI,
                   :PG-TYP-LIV
                   

               END-EXEC
       
      * Incrémentation du nombre de lignes du tableau.  
               ADD 1 TO WS-NBR-LIN-TAB

      * Les variables du tableau sont ensuite alimentées par les valeurs 
      * obtenues à l'aide du curseur.
               MOVE PG-IDF-LIV
               TO   LK-IDF-LIV(WS-NBR-LIN-TAB)

               MOVE PG-QTE-PIE
               TO   LK-QTE-PIE(WS-NBR-LIN-TAB)

               MOVE PG-DAT-LIV
               TO   LK-DAT-LIV(WS-NBR-LIN-TAB)

               MOVE PG-STA-LIV
               TO   LK-STA-LIV(WS-NBR-LIN-TAB)

               MOVE PG-NOM-FOU-CLI 
               TO   LK-NOM-FOU-CLI(WS-NBR-LIN-TAB)
               
               MOVE PG-IDF-FOU-CLI 
               TO   LK-IDF-FOU-CLI(WS-NBR-LIN-TAB)
               
               MOVE PG-TYP-LIV 
               TO   LK-TYP-LIV(WS-NBR-LIN-TAB)
               

           END-PERFORM.

      * Fermeture du curseur.
           EXEC SQL
               CLOSE curseur_liv
           END-EXEC.    

           SET LK-LIR-RET-OK TO TRUE.     
           
           EXIT.
       0300-CSR-FIL-VID-FIN.

      *-----------------------------------------------------------------
       
       0400-CSR-FIL-FOU-DEB.

      * Déclaration du curseur pour la table fournisseur. 
           EXEC SQL
               DECLARE curseur_fou CURSOR FOR 
               SELECT livraison.id_liv, fournisseur.nom_fou,
                      COUNT(livraison.id_liv) AS nbr_typ_pie,
                      livraison.date_deb_liv, livraison.statut_liv
                      

               FROM fournisseur    

               JOIN livraison 
               ON  fournisseur.id_fou = livraison.id_fou
               
               JOIN livraison_piece
               ON livraison.id_liv = livraison_piece.id_liv

               WHERE fournisseur.id_fou = :PG-IDF-FOU-CLI-PIE
               GROUP BY livraison.id_liv

               LIMIT :PG-NBR-ELM
               OFFSET :PG-OFS
               FOR READ ONLY
           END-EXEC.           

      * Ouverture du curseur.
           EXEC SQL
               OPEN curseur_fou
           END-EXEC. 

      * En cas d'erreur lors de l'ouverture du curseur, le programme est
      * arrêté et le code d'erreur est renvoyé.
           IF SQLCODE NOT EQUAL 0
               SET WS-LIR-RET-ERR TO TRUE 
               EXIT PROGRAM
           END-IF.
           
      * Initialisation du nombre de lignes du tableau. 
           MOVE 0 TO WS-NBR-LIN-TAB.

      * Lecture du curseur tant que le SQLCODE n'est pas égal à 100, et 
      * donc qu'on ne se trouve pas au bout du curseur.
           PERFORM UNTIL SQLCODE = 100 
               
               EXEC SQL

      * Récupération des données suivantes : nom du fournisseur, id, 
      * date de début et statut de livraison ainsi que la quantité de 
      * types de pièces dans une livraison. 
                   FETCH curseur_fou into 
                   :PG-IDF-LIV,
                   :PG-NOM-FOU-CLI,
                   :PG-QTE-PIE,
                   :PG-DAT-LIV,
                   :PG-STA-LIV
                   

               END-EXEC
       
      * Incrémentation du nombre de lignes du tableau.  
               ADD 1 TO WS-NBR-LIN-TAB

      * Les variables du tableau sont ensuite alimentées par les valeurs 
      * obtenues à l'aide du curseur.
               MOVE PG-IDF-LIV
               TO   LK-IDF-LIV(WS-NBR-LIN-TAB)

               MOVE PG-NOM-FOU-CLI 
               TO   LK-NOM-FOU-CLI(WS-NBR-LIN-TAB)
       
               MOVE PG-QTE-PIE
               TO   LK-QTE-PIE(WS-NBR-LIN-TAB)

               MOVE PG-DAT-LIV
               TO   LK-DAT-LIV(WS-NBR-LIN-TAB)
       
               MOVE PG-STA-LIV
               TO   LK-STA-LIV(WS-NBR-LIN-TAB)
       

           END-PERFORM.

      * Fermeture du curseur.
           EXEC SQL
               CLOSE curseur_fou
           END-EXEC.    

           SET LK-LIR-RET-OK TO TRUE. 
 
           EXIT.
       0400-CSR-FIL-FOU-FIN.

      *-----------------------------------------------------------------
       
       0500-CSR-FIL-CLI-DEB.

      * Déclaration du curseur pour la table client. 
           EXEC SQL
               DECLARE curseur_cli CURSOR FOR 
               SELECT livraison.id_liv, client.nom_cli,
                      COUNT(livraison.id_liv) AS nbr_typ_pie,
                      livraison.date_deb_liv, livraison.statut_liv
                      

               FROM client    

               JOIN livraison 
               ON  client.id_cli = livraison.id_cli
               
               JOIN livraison_piece
               ON livraison.id_liv = livraison_piece.id_liv

               WHERE client.id_cli = :PG-IDF-FOU-CLI-PIE
               GROUP BY livraison.id_liv

               LIMIT :PG-NBR-ELM
               OFFSET :PG-OFS
               FOR READ ONLY
           END-EXEC.           

      * Ouverture du curseur.
           EXEC SQL
               OPEN curseur_cli
           END-EXEC. 

      * En cas d'erreur lors de l'ouverture du curseur, le programme est
      * arrêté et le code d'erreur est renvoyé.
           IF SQLCODE NOT EQUAL 0
               SET WS-LIR-RET-ERR TO TRUE 
               EXIT PROGRAM
           END-IF.

      * Initialisation du nombre de lignes du tableau. 
           MOVE 0 TO WS-NBR-LIN-TAB.

      * Lecture du curseur tant que le SQLCODE n'est pas égal à 100, et 
      * donc qu'on ne se trouve pas au bout du curseur.
           PERFORM UNTIL SQLCODE = 100 
               
               EXEC SQL

      * Récupération des données suivantes : nom du client, id, 
      * date de début et statut de livraison ainsi que la quantité de 
      * de types de pièces dans une livraison. 
                   FETCH curseur_cli into 
                   :PG-IDF-LIV,
                   :PG-NOM-FOU-CLI,
                   :PG-QTE-PIE,
                   :PG-DAT-LIV,
                   :PG-STA-LIV
                   

               END-EXEC
       
      * Incrémentation du nombre de lignes du tableau.  
               ADD 1 TO WS-NBR-LIN-TAB

      * Les variables du tableau sont ensuite alimentées par les valeurs 
      * obtenues à l'aide du curseur.
               MOVE PG-IDF-LIV
               TO   LK-IDF-LIV(WS-NBR-LIN-TAB)

               MOVE PG-NOM-FOU-CLI 
               TO   LK-NOM-FOU-CLI(WS-NBR-LIN-TAB)

               MOVE PG-QTE-PIE
               TO   LK-QTE-PIE(WS-NBR-LIN-TAB)
       
               MOVE PG-DAT-LIV
               TO   LK-DAT-LIV(WS-NBR-LIN-TAB)
       
               MOVE PG-STA-LIV
               TO   LK-STA-LIV(WS-NBR-LIN-TAB)
       
               
           END-PERFORM.

      * Fermeture du curseur.
           EXEC SQL
               CLOSE curseur_cli
           END-EXEC.    

           SET LK-LIR-RET-OK TO TRUE. 
 
           EXIT.
       0500-CSR-FIL-CLI-FIN.

      *-----------------------------------------------------------------
       
       0600-CSR-FIL-PIE-DEB.

      * Déclaration du curseur pour la table pièce. 
           EXEC SQL
               DECLARE curseur_pie CURSOR FOR 
               SELECT livraison.id_liv, livraison_piece.qt_liv_pie,
                      livraison.date_deb_liv, livraison.statut_liv,
                      COALESCE(fournisseur.nom_fou, client.nom_cli) 
                      AS nom_fou_cli,
                      COALESCE(fournisseur.id_fou, client.id_cli) 
                      AS id_fou_cli,
                      CASE 
                          WHEN client.id_cli IS NOT NULL THEN 1
                          WHEN fournisseur.id_fou IS NOT NULL THEN 0 
                      END AS type_liv
               
               FROM livraison    

               JOIN fournisseur 
                 ON livraison.id_fou = fournisseur.id_fou 
               
               JOIN client
                 ON livraison.id_cli = client.id_cli

               JOIN livraison_piece
                 ON livraison.id_liv = livraison_piece.id_liv
               
               WHERE livraison_piece.id_pie = :PG-IDF-FOU-CLI-PIE

               LIMIT :PG-NBR-ELM
               OFFSET :PG-OFS
               FOR READ ONLY
           END-EXEC.           

      * Ouverture du curseur.
           EXEC SQL
               OPEN curseur_pie
           END-EXEC. 

      * En cas d'erreur lors de l'ouverture du curseur, le programme est
      * arrêté et le code d'erreur est renvoyé.
           IF SQLCODE NOT EQUAL 0
               SET WS-LIR-RET-ERR TO TRUE 
               EXIT PROGRAM
           END-IF.
           
      * Initialisation du nombre de lignes du tableau. 
           MOVE 0 TO WS-NBR-LIN-TAB.

      * Lecture du curseur tant que le SQLCODE n'est pas égal à 100, et 
      * donc qu'on ne se trouve pas au bout du curseur.
           PERFORM UNTIL SQLCODE = 100 
               
               EXEC SQL

      * Récupération des données suivantes : id et nom du fournisseur  
      * ou client selon le type de livraison, id, date de début et   
      * statut de livraison, la quantité de pièces livrées pour un type
      * de pièce dans une livraison ainsi que le type de livraison.
                   FETCH curseur_pie into 
                   :PG-IDF-LIV,
                   :PG-QTE-PIE,
                   :PG-DAT-LIV,
                   :PG-STA-LIV,
                   :PG-NOM-FOU-CLI,
                   :PG-IDF-FOU-CLI,
                   :PG-TYP-LIV
                   

               END-EXEC
       
      * Incrémentation du nombre de lignes du tableau.  
               ADD 1 TO WS-NBR-LIN-TAB

      * Les variables du tableau sont ensuite alimentées par les valeurs 
      * obtenues à l'aide du curseur.
               MOVE PG-IDF-LIV
               TO   LK-IDF-LIV(WS-NBR-LIN-TAB)

               MOVE PG-QTE-PIE
               TO   LK-QTE-PIE(WS-NBR-LIN-TAB)

               MOVE PG-DAT-LIV
               TO   LK-DAT-LIV(WS-NBR-LIN-TAB)

               MOVE PG-STA-LIV
               TO   LK-STA-LIV(WS-NBR-LIN-TAB)

               MOVE PG-NOM-FOU-CLI 
               TO   LK-NOM-FOU-CLI(WS-NBR-LIN-TAB)
               
               MOVE PG-IDF-FOU-CLI 
               TO   LK-IDF-FOU-CLI(WS-NBR-LIN-TAB)
               
               MOVE PG-TYP-LIV 
               TO   LK-TYP-LIV(WS-NBR-LIN-TAB)
               

           END-PERFORM.

      * Fermeture du curseur.
           EXEC SQL
               CLOSE curseur_pie
           END-EXEC.    

           SET LK-LIR-RET-OK TO TRUE.



           EXIT.
       0600-CSR-FIL-PIE-FIN.

      *-----------------------------------------------------------------
       
