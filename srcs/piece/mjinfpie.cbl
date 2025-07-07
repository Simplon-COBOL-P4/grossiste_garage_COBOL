      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * MJ=MISE A JOUR; INF=INFO; PIE=PIECE; IDF=IDENTIFIANT;          *
      * SUL= SEUIL; FOU=FOURNISSEUR; VAR=VARIABLE; INI= INITIALISATION;*
      * MSG=MESSAGE; EDT=EDITION;                                      *
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

       01 WS-IDF-PIE-EDT       PIC Z(10).

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

           EXIT PROGRAM.
       

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ****************************************************************** 

       0100-INI-VAR-DEB.
           
           MOVE LK-IDF-PIE
           TO   PG-IDF-PIE.
           
           MOVE LK-NOM-PIE
           TO   PG-NOM-PIE.

           MOVE LK-SUL-PIE
           TO   PG-SUL-PIE.
           
           MOVE LK-IDF-FOU-PIE
           TO   PG-IDF-FOU-PIE.
           
      * Alimentation de la variable correspondant au type de log.     
           MOVE 'piece'
           TO   WS-TYP-LOG.
           
           EXIT.
       0100-INI-VAR-FIN

      *----------------------------------------------------------------- 
       0200-SQL-DEB.
           
           EXEC SQL 
               UPDATE piece 
               SET nom_pie = :PG-NOM-PIE,
                   seuil_pie = :PG-SUL-PIE,
                   id_fou = :PG-IDF-FOU-PIE
               WHERE id_pie = :PG-IDF-PIE
           END-EXEC.
           
             IF SQLCODE = 0
      * L'utilisateur est modifié avec succès.
               EXEC SQL COMMIT END-EXEC
           ELSE
      * L'utilisateur n'est pas dans la table ou la table n'existe pas.
               EXEC SQL ROLLBACK END-EXEC
           END-IF.

           EXIT.
       0200-SQL-FIN.

      *----------------------------------------------------------------- 
       
       0300-GEN-LOG-DEB.
           
           STRING '[' DELIMITED BY SIZE 
                  FUNCTION TRIM (WS-IDF-PIE-EDT) DELIMITED BY SIZE 
                  '] ' DELIMITED BY SIZE 
                  'Modifications des informations sur la piece'
           INTO WS-MSG-LOG
           END-STRING.

           EXIT.
       0300-GEN-LOG-FIN.

      *----------------------------------------------------------------- 
       
