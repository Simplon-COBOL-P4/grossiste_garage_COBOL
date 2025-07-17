      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * LE PROGRAMME PREND EN PARAMÈTRE LES DONNÉES NÉCESSAIRES À      *
      * L'INSERTION D'UNE livraison_piece.                             *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AJU=AJOUT; DEP=DEPLACER; IDF=IDENTIFIANT; LIV=LIVRAISON;       *
      * PIE,PI=PIECE; QTE=QUANTITE; REQ=REQUÊTE; VAR=VARIABLE;         *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajulivpi.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDF-LIV              PIC 9(10).
       01 PG-IDF-PIE               PIC 9(10).
       01 PG-QTE-PIE               PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDF-LIV              PIC 9(10).
       01 LK-IDF-PIE               PIC 9(10).
       01 LK-QTE-PIE               PIC 9(10).
      * Arguments de sortie.

       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-IDF-LIV,
                                LK-IDF-PIE,
                                LK-QTE-PIE,
                                LK-AJU-RET.


           PERFORM 0100-AJU-LIV-PIE-DEB
              THRU 0100-AJU-LIV-PIE-FIN.

           EXIT PROGRAM.
           

      ****************************PARAGRAPHES***************************
       0100-AJU-LIV-PIE-DEB.

       0110-DEP-VAR-DEB.
           MOVE LK-IDF-LIV   TO PG-IDF-LIV.
           MOVE LK-IDF-PIE    TO PG-IDF-PIE.
           MOVE LK-QTE-PIE    TO PG-QTE-PIE.
       0110-DEP-VAR-FIN.

       0120-REQ-SQL-DEB.

           EXEC SQL
               INSERT INTO livraison_piece (id_liv, id_pie, qt_liv_pie)
               VALUES (:PG-IDF-LIV, :PG-IDF-PIE, :PG-QTE-PIE)
           END-EXEC.
  
           EVALUATE SQLCODE
               WHEN 0
                   SET LK-AJU-RET-OK TO TRUE
                   EXEC SQL COMMIT END-EXEC
               WHEN -400
                   SET LK-AJU-RET-FK-ERR TO TRUE
                   EXEC SQL ROLLBACK END-EXEC
               WHEN OTHER
                   SET LK-AJU-RET-ERR TO TRUE
                   EXEC SQL ROLLBACK END-EXEC
           END-EVALUATE.
       0120-REQ-SQL-FIN.    
       
       0100-AJU-LIV-PIE-FIN.
           