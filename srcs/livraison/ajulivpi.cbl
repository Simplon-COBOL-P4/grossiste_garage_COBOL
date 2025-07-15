      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * LE PROGRAMME PREND EN PARAMÈTRE LES DONNÉES NÉCESSAIRES À      *
      * L'INSERTION D'UNE livraison_piece.                             *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AJU=AJOUT; DEP=DEPLACER; IDF=IDENTIFIANT; LIV=LIVRAISON;       *
      * PI=PIECE; QTE=QUANTITE; REQ=REQUÊTE; VAR=VARIABLE;             *
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
       01 PG-IDF-PI               PIC 9(10).
       01 PG-QTE-PI               PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDF-LIV              PIC 9(10).
       01 LK-IDF-PI               PIC 9(10).
       01 LK-QTE-PI               PIC 9(10).
      * Arguments de sortie.

       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-IDF-LIV,
                                LK-IDF-PI,
                                LK-QTE-PI,
                                LK-AJU-RET.


           PERFORM 0100-AJU-LIV-PI-DEB
              THRU 0100-AJU-LIV-PI-FIN.

           EXIT PROGRAM.
           

      ****************************PARAGRAPHES***************************
       0100-AJU-LIV-PI-DEB.

       0110-DEP-VAR-DEB.
           MOVE LK-IDF-LIV   TO PG-IDF-LIV.
           MOVE LK-IDF-PI    TO PG-IDF-PI.
           MOVE LK-QTE-PI    TO PG-QTE-PI.
       0110-DEP-VAR-FIN.

       0120-REQ-SQL-DEB.    
       EXEC SQL
           INSERT INTO livraison_piece (id_liv, id_pie, qt_liv_pie)
           VALUES (:PG-IDF-LIV, :PG-IDF-PI, :PG-QTE-PI)
       END-EXEC.
  
           IF SQLCODE = 0 THEN

               SET LK-AJU-RET-OK TO TRUE

               EXEC SQL COMMIT END-EXEC

           ELSE 
           
               SET LK-AJU-RET-ERR TO TRUE

           END-IF.
       0120-REQ-SQL-FIN.    
       
       0100-AJU-LIV-PI-FIN.
           
