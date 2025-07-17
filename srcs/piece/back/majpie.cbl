      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * majpie : Programme qui gère les entrées/sorties des pièces.    *
      * Le programme reçoit donc en argument l’ID de la pièce, la      *
      * quantité, et le mode de changement (Ajout/Retrait).            *
      * Suite à l’opération, le sous programme doit générer un log     *
      * dans la base de donnée, qui indique le contenu de l’opération. *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * MAJ=MISE À JOUR; PIE=PIÈCE; IDF=IDENTIFIANT; QTE=QUANTITE;     *
      * TYP=TYPE; CHG=CHANGEMENT; AJT=AJOUT; RTI=RETRAIT;              *
      * AFC=AFFECTATION; VAR=VARIABLE; CHX=CHOIX; GEN=GENERATION;      *
      * MSG=MESSAGE; EDT=EDITION; OPR=OPERATION; STA=STATUT; APL=APPEL;*
      * CRE=CREATION; UTI=UTILISATEUR.                                 *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. majpie.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 27-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Déclaration de la variable mentionnant l'opération effectuée
      * sur le stock pour l'affichage dans les logs.

       01 WS-OPR-QTE-PIE       PIC X(10).
 
      * Déclaration de la variable stockant le message à inclure dans 
      * les logs à chaque opération.  
       01 WS-MSG-LOG           PIC X(100).

      * Déclaration de la variable définissant le type de log. 
       01 WS-TYP-LOG           PIC X(12). 
      
      * Déclaration de la variable correspondant à l'identifiant de 
      * l'utilisateur.
       01 WS-IDF-UTI           PIC 9(10).


      * Déclaration de la variable d'édition pour un meilleur affichage 
      * des variables LK-QTE-PIE et LK-IDF-PIE dans les logs. 
       01 WS-IDF-EDT           PIC Z(10). 
       01 WS-QTE-EDT           PIC Z(10).
        
       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

      * Déclaration des variables correspondant aux attributs  
      * id_pie et qt_pie de la table piece.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDF-PIE           PIC 9(10).

      * Déclaration de la variable, correspondant à la quantité à 
      * ajouter ou à soustraire au stock, que doit saisir l'utilisateur. 
       01 PG-QTE-PIE           PIC 9(10).

      * Déclaration de la variable  définissant le statut du retrait.
      
       01 PG-STA-RTI           PIC X(02).
           88 PG-STA-RTI-OK                VALUE "OK".
           88 PG-STA-RTI-KO                VALUE "KO".


       EXEC SQL END DECLARE SECTION END-EXEC.
       
       EXEC SQL INCLUDE SQLCA END-EXEC.


       LINKAGE SECTION.
      * Arguments d'entrée correspondant aux variables utilisées dans 
      * le programme appelant.
       01 LK-IDF-PIE           PIC 9(10).
       01 LK-QTE-PIE           PIC 9(10).
       
      * Déclaration du booléen correspondant au choix de l'opération
      * sur le stock de pièces.  
       01 LK-TYP-CHG           PIC 9(01).
           88 LK-AJT                       VALUE 0.
           88 LK-RTI                       VALUE 1.
       
       COPY majret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-IDF-PIE,
                                LK-QTE-PIE,
                                LK-TYP-CHG
                                LK-MAJ-RET.
                                

           PERFORM 0100-AFC-VAR-DEB
              THRU 0100-AFC-VAR-FIN.
           
           PERFORM 0200-CHX-TYP-CHG-DEB
              THRU 0200-CHX-TYP-CHG-FIN.
           
           PERFORM 0500-APL-CRE-LOG-DEB
              THRU 0500-APL-CRE-LOG-FIN.

           EXIT PROGRAM.


      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************
       
       0100-AFC-VAR-DEB.

      * Alimentation des variables à utiliser dans SQL (id de la pièce
      * et quantité à ajouter ou à retirer dans le stock) avec les  
      * valeurs saisies par l'utilisateur. 

           MOVE LK-IDF-PIE 
           TO   PG-IDF-PIE.
       
           MOVE LK-QTE-PIE 
           TO   PG-QTE-PIE.

      * Alimentation des variables d'édition avec les valeurs saisies  
      * par l'utilisateur. Elles seront utilisées dans les logs.

           MOVE LK-IDF-PIE
           TO   WS-IDF-EDT.

           MOVE LK-QTE-PIE
           TO   WS-QTE-EDT.

      * Alimentation de la variable correspondant au type de log.     
           MOVE 'piece'
           TO   WS-TYP-LOG.

       0100-AFC-VAR-FIN.

      *-----------------------------------------------------------------
       
      * Choix de l'opération à effectuer sur le stock de la pièce 
      * correspondante.

       0200-CHX-TYP-CHG-DEB.

      * Si l'utilisateur choisit d'ajouter des pièces dans le stock,
      * additionne la quantité à rajouter saisie à la quantité des  
      * pièces dans le stock.

           IF LK-AJT

               PERFORM 0300-MAJ-AJT-QTE-DEB
                  THRU 0300-MAJ-AJT-QTE-FIN

      * Génération du message d'ajout dans les logs.

               PERFORM 0450-GEN-LOG-OK-DEB
                  THRU 0450-GEN-LOG-OK-FIN

      * Si l'utilisateur choisit de retirer des pièces dans le stock,
      * soustrait la quantité à retirer saisie à la quantité des pièces 
      * dans le stock (seulement si la quantité à retirer est 
      * inférieure au stock).

           ELSE

               PERFORM 0350-MAJ-RTI-QTE-DEB
                  THRU 0350-MAJ-RTI-QTE-FIN

      * Choix du message à générer dans les logs selon le statut du 
      * retrait.

               PERFORM 0400-CHX-MSG-LOG-DEB
                  THRU 0400-CHX-MSG-LOG-FIN

           END-IF.
       
       0200-CHX-TYP-CHG-FIN.

      *-----------------------------------------------------------------
       
      * Mise à jour de l'information sur la quantité de pièces du stock
      * dans la base de données SQL. Ajout de la quantité définie dans 
      * la SCREEN SECTION au stock.

       0300-MAJ-AJT-QTE-DEB.

           EXEC SQL
               UPDATE piece
               SET qt_pie = qt_pie + :PG-QTE-PIE
               WHERE id_pie = :PG-IDF-PIE
           END-EXEC.    

           IF SQLCODE = 0
              EXEC SQL COMMIT END-EXEC 

              MOVE 'Ajout'
              TO   WS-OPR-QTE-PIE
              SET LK-MAJ-RET-OK TO TRUE

           ELSE
              EXEC SQL ROLLBACK END-EXEC 
              SET LK-MAJ-RET-ERR TO TRUE
           END-IF.

       0300-MAJ-AJT-QTE-FIN.

      *-----------------------------------------------------------------
       
      * Mise à jour de l'information sur la quantité de pièces du stock
      * dans la base de données SQL. Retrait de la quantité définie dans 
      * la SCREEN SECTION au stock.


       0350-MAJ-RTI-QTE-DEB.

      * Affectation d'une variable de statut sur le retrait. Elle
      * permettra de définir le message log à envoyer.
      * Si la quantité à retirer est inférieure à la quantité en stock
      * alors le retrait est défini en "OK", sinon il est défini en 
      * "KO". 

           EXEC SQL
               SELECT 
                   CASE 
                       WHEN qt_pie>= :PG-QTE-PIE 
                       THEN 'OK'
                       ELSE 
                           'KO'
                   END 
               INTO :PG-STA-RTI
               FROM piece
               WHERE id_pie = :PG-IDF-PIE 
           END-EXEC.


      * Le retrait ne s'opère que si la quantité à retirer est 
      * inférieure à la quantité de la pièce en stock.

           IF PG-STA-RTI-OK
               EXEC SQL
                   UPDATE piece
                   SET qt_pie = qt_pie - :PG-QTE-PIE
                   WHERE id_pie = :PG-IDF-PIE
               END-EXEC
            
         
               IF SQLCODE = 0 
                   EXEC SQL COMMIT END-EXEC 
                   MOVE 'Retrait'
                   TO   WS-OPR-QTE-PIE 
                   SET LK-MAJ-RET-OK TO TRUE

               ELSE
                   EXEC SQL ROLLBACK END-EXEC 
                   SET LK-MAJ-RET-ERR TO TRUE
                  
               END-IF
           ELSE
               SET LK-MAJ-RET-ERR TO TRUE
           END-IF.
           
       0350-MAJ-RTI-QTE-FIN.

      *----------------------------------------------------------------- 
       0400-CHX-MSG-LOG-DEB.

      * Si le statut du retrait est "OK" alors on génère le message de
      * log correspondant au retrait dans le stock.

           IF PG-STA-RTI-OK 
       
               PERFORM 0450-GEN-LOG-OK-DEB
                  THRU 0450-GEN-LOG-OK-FIN  

      * Si le statut de retrait est "KO" alors on génère le message 
      * d'erreur dans les logs.

           ELSE
               
               PERFORM 0460-GEN-LOG-KO-DEB
                  THRU 0460-GEN-LOG-KO-FIN

           END-IF. 

       0400-CHX-MSG-LOG-FIN.
      *----------------------------------------------------------------- 
       
       0450-GEN-LOG-OK-DEB.
           
      * Concaténation de chaîne de caractères avec les variables 
      * correspondant à l'ID de la pièce concernée, le type de  
      * l'opération sur le stock et la quantité à ajouter/retirer au 
      * stock pour générer le message dans les logs.

           STRING '[' DELIMITED BY SIZE 
                  FUNCTION TRIM (WS-IDF-EDT) DELIMITED BY SIZE 
                  '] ' DELIMITED BY SIZE 
                  WS-OPR-QTE-PIE DELIMITED BY SPACE 
                  ' de ' DELIMITED BY SIZE
                  FUNCTION TRIM (WS-QTE-EDT) DELIMITED BY SIZE
                  ' unites.' DELIMITED BY SIZE
                  INTO WS-MSG-LOG
           END-STRING.

       0450-GEN-LOG-OK-FIN.
      *----------------------------------------------------------------- 
      
       0460-GEN-LOG-KO-DEB.

      * De même que pour le paragraphe 0450-GEN-LOG-OK-DEB, à la 
      * différence qu'ici un message d'erreur est généré.

           STRING '[' DELIMITED BY SIZE 
                  FUNCTION TRIM (WS-IDF-EDT) DELIMITED BY SIZE 
                  '] ' DELIMITED BY SIZE 
                  '[ERREUR] la quantite a retirer est superieure'
      -           ' a la quantite en stock' DELIMITED BY SIZE 
                  INTO WS-MSG-LOG
           END-STRING.
           
       0460-GEN-LOG-KO-FIN.

      *----------------------------------------------------------------- 
       
       0500-APL-CRE-LOG-DEB.

      * Appel du sous-programme ajulog pour l'insertion du log dans la
      * base de données SQL. Il prend le message de log généré ainsi
      * que le type de log défini dans ce programme en arguments.


           CALL "ajulog" 
               USING 
               WS-MSG-LOG
               WS-TYP-LOG
               WS-IDF-UTI
               WS-AJU-RET   
           END-CALL.

       0500-APL-CRE-LOG-FIN.


