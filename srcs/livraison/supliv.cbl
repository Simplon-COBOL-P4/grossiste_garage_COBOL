      ******************************************************************
      *                             ENTÊTE                             *
      * Programme qui supprime une livraison dans la BDD. Le programme *
      * prend en paramètre l’ID d’une livraison. À noter qu’il retourne*
      * un code erreur (en flag), qui est déjà implémenté dans le      *
      * squelette. Il est impératif de remplir ce code erreur avant de *
      * rendre la main au programme appelant. Utiliser SQLCODE pour    *  
      * voir si des erreurs se sont produites. Attention à bien lire   *
      * le copybook pour savoir ce qui est attendu.                    *
      *                                                                * 
      *----------------------------------------------------------------* 
      *                           TRIGRAMMES                           *
      * SUP=SUPPRIMER; LIV=LIVRAISON; IDF=IDENTIFIANT; AFC=AFFECTATION;*
      * VAR=VARIABLE; EDT=EDITION; MSG=MESSAGE; TYP=TYPE; APL=APPEL;   *
      * CRE=CREATION; GEN=GENERATION.                                  *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. supliv.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 09-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.

      * Déclaration de la variable à utiliser en SQL correspondant 
      * à l'id de la livraison saisi par l'utilisateur. 
       01 PG-IDF-LIV             PIC 9(10).

       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       
      * Déclaration de la variable d'édition pour un meilleur affichage 
      * de la variable LK-IDF-LIV dans les logs.
       01 WS-IDF-LIV-EDT         PIC Z(10).

      * Déclaration de la variable correspondant à l'identifiant de 
      * l'utilisateur (à transmettre au sous-programme "ajulog").
       01 WS-IDF-UTI             PIC 9(10). 


      * Déclaration de la variable stockant le message à inclure dans 
      * les logs à chaque opération.  
       01 WS-MSG-LOG             PIC X(100).

      * Déclaration de la variable définissant le type de log. 
       01 WS-TYP-LOG             PIC X(12). 

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDF-LIV             PIC 9(10).

      * Arguments de sortie.
       COPY supret REPLACING ==:PREFIX:== BY ==LK==.


       PROCEDURE DIVISION USING LK-IDF-LIV,
                                LK-SUP-RET.


           PERFORM 0100-AFC-VAR-DEB
              THRU 0100-AFC-VAR-FIN.

           PERFORM 0200-SUP-LIV-DEB
              THRU 0200-SUP-LIV-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************
       0100-AFC-VAR-DEB.
           
      * Alimentation de la variable à utiliser dans SQL (id de la 
      * livraison) avec la valeur saisie par l'utilisateur.  
            
           MOVE LK-IDF-LIV 
           TO   PG-IDF-LIV.

      * Alimentation de la variable d'édition avec la valeur saisie  
      * par l'utilisateur. Elle sera utilisée dans les logs.
           
           MOVE LK-IDF-LIV 
           TO   WS-IDF-LIV-EDT.

      * Alimentation de la variable correspondant au type de log.     
           MOVE 'livraison'
           TO   WS-TYP-LOG.

           EXIT.
       0100-AFC-VAR-FIN.


      *----------------------------------------------------------------- 
       0200-SUP-LIV-DEB.

      * Suppression des informations de livraison à l'id indiqué par 
      * l'utilisateur.

           EXEC SQL
               DELETE FROM livraison
               WHERE id_liv = :PG-IDF-LIV   
           END-EXEC.
           
           IF SQLCODE = 0
      * Si la suppression réussit, la requête SQL est validée.      
               EXEC SQL COMMIT END-EXEC

      * Alimentation du flag "OK" pour signifier la réussite de la 
      * suppression. 
               SET LK-SUP-RET-OK TO TRUE

      * Génération du message de log à envoyer au sous-programme ajulog.

               PERFORM 0300-GEN-LOG-DEB
                  THRU 0300-GEN-LOG-FIN

      * Appel du sous-programme. 
               PERFORM 0400-APL-CRE-LOG-DEB
                  THRU 0400-APL-CRE-LOG-FIN

           ELSE 
      * Sinon la requête est annulée.
               EXEC SQL ROLLBACK END-EXEC
               
      * Alimentation du flag "ERR" pour signifier l'échec de la 
      * suppression. 
               SET LK-SUP-RET-ERR TO TRUE

           END-IF.
           EXIT.
       0200-SUP-LIV-FIN.

      *----------------------------------------------------------------- 
       
       0300-GEN-LOG-DEB.

      * Concaténation de chaîne de caractères avec la variable 
      * correspondant à l'ID de la livraison concernée pour générer le
      * message dans les logs.

           STRING '[' DELIMITED BY SIZE 
                  FUNCTION TRIM (WS-IDF-LIV-EDT) DELIMITED BY SIZE  
                  '] ' DELIMITED BY SIZE 
                  'Suppression'
           INTO WS-MSG-LOG
           END-STRING.
           
           EXIT.
       0300-GEN-LOG-FIN.

      *----------------------------------------------------------------- 
       
       0400-APL-CRE-LOG-DEB.
       
      * Appel du sous-programme ajulog pour l'insertion du log dans la
      * base de données SQL. Il prend le message de log généré, le type
      * de log défini dans ce programme et l'id utilisateur en 
      * arguments. 
           
           CALL "ajulog"
               USING 
               WS-MSG-LOG
               WS-TYP-LOG
               WS-IDF-UTI
               WS-AJU-RET
           END-CALL.

           EXIT.
       0400-APL-CRE-LOG-FIN.
