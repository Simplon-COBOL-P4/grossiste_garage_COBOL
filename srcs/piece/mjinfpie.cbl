      ******************************************************************
      *                             ENTÊTE                             *
      * Sous programme mjinfpie, qui met à jour les infos d’une pièce. *
      * Le programme reçoit donc en argument l’ID de la pièce, ainsi   *
      * que tous les paramètres nécessaires à la mise à jour dans la   *
      * BDD. À noter qu’il ne reçoit pas la quantité de la pièce, comme*
      * il est impossible de la modifier directement.                  *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * MJ=MISE A JOUR; INF=INFO; PIE=PIECE; IDF=IDENTIFIANT;          *
      * SUL= SEUIL; FOU=FOURNISSEUR; VAR=VARIABLE; INI= INITIALISATION;*
      * MSG=MESSAGE; EDT=EDITION; APL=APPEL; CRE=CREATION;             *
      * UTI=UTILISATEUR.                                               *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. mjinfpie.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
      * Déclaration de la variable stockant le message à inclure dans 
      * les logs à chaque opération.  
       01 WS-MSG-LOG           PIC X(100).

      * Déclaration de la variable définissant le type de log. 
       01 WS-TYP-LOG           PIC X(12). 

      * Déclaration de la variable correspondant à l'identifiant de 
      * l'utilisateur.
       01 WS-IDF-UTI           PIC 9(10).

      * Déclaration de la variable d'édition pour un meilleur affichage 
      * de la variable LK-IDF-PIE dans les logs. 
       01 WS-IDF-PIE-EDT       PIC Z(10).

      * Déclaration des variables correspondant aux attributs id_pie,
      * nom_pie, seuil_pie, id_fou.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.

       01 PG-IDF-PIE               PIC 9(10).
       01 PG-NOM-PIE               PIC X(50).
       01 PG-SUL-PIE               PIC 9(10).
       01 PG-IDF-FOU-PIE           PIC 9(10).

       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDF-PIE               PIC 9(10).
       01 LK-NOM-PIE               PIC X(50).
       01 LK-SUL-PIE               PIC 9(10).
       01 LK-IDF-FOU-PIE           PIC 9(10).




       PROCEDURE DIVISION USING LK-IDF-PIE,
                                LK-NOM-PIE,
                                LK-SUL-PIE,
                                LK-IDF-FOU-PIE.
           

           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.   
           
           PERFORM 0300-GEN-LOG-DEB
              THRU 0300-GEN-LOG-FIN.

           PERFORM 0400-APL-CRE-LOG-DEB
              THRU 0400-APL-CRE-LOG-FIN.

           EXIT PROGRAM.
       

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ****************************************************************** 

       0100-INI-VAR-DEB.

      * Initialistation des variables de la working-storage à utiliser 
      * en SQL.

           MOVE LK-IDF-PIE
           TO   PG-IDF-PIE.
           
           MOVE LK-NOM-PIE
           TO   PG-NOM-PIE.

           MOVE LK-SUL-PIE
           TO   PG-SUL-PIE.
           
           MOVE LK-IDF-FOU-PIE
           TO   PG-IDF-FOU-PIE.
           
      * Alimentation de la variable d'édition avec la valeur saisie  
      * par l'utilisateur. Elle sera utilisée dans les logs.

           MOVE LK-IDF-PIE
           TO   WS-IDF-PIE-EDT.

      * Alimentation de la variable correspondant au type de log.     
           MOVE 'piece'
           TO   WS-TYP-LOG.

           EXIT.
       0100-INI-VAR-FIN.

      *----------------------------------------------------------------- 
       0200-SQL-DEB.
           
      * Mise à jour des informations sur la pièce avec les informations
      * saisies par l'utilisateur.

           EXEC SQL 
               UPDATE piece 
               SET nom_pie = :PG-NOM-PIE,
                   seuil_pie = :PG-SUL-PIE,
                   id_fou = :PG-IDF-FOU-PIE
               WHERE id_pie = :PG-IDF-PIE
           END-EXEC.
           
      * Si la requête est valide alors elle est exécutée, sinon elle ne 
      * l'est pas.

           IF SQLCODE = 0
               EXEC SQL COMMIT END-EXEC
           ELSE
               EXEC SQL ROLLBACK END-EXEC
           END-IF.

           EXIT.
       0200-SQL-FIN.

      *----------------------------------------------------------------- 
       
       0300-GEN-LOG-DEB.

      * Concaténation de chaîne de caractères avec la variable 
      * correspondant à l'ID de la pièce concernée pour générer le
      * message dans les logs.

           STRING '[' DELIMITED BY SIZE 
                  FUNCTION TRIM (WS-IDF-PIE-EDT) DELIMITED BY SIZE 
                  '] ' DELIMITED BY SIZE 
                  'Mise a jour'
           INTO WS-MSG-LOG
           END-STRING.

           EXIT.
       0300-GEN-LOG-FIN.

      *----------------------------------------------------------------- 
       
       0400-APL-CRE-LOG-DEB.

      * Appel du sous-programme crelog pour l'insertion du log dans la
      * base de données SQL. Il prend le message de log généré, le type
      * de log défini dans ce programme et l'id utilisateur en 
      * arguments. 

           CALL "crelog" USING WS-MSG-LOG
                               WS-TYP-LOG
                               WS-IDF-UTI
           
           END-CALL.

           EXIT.

       0400-APL-CRE-LOG-FIN.

