      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Le programme sert a verifier si un couple ID Livraison-Piece   *
      * existe.                                                        *
      *                                                                *
      *                           TRIGRAMMES                           *
      * VRF=VERIFIER; DEP=DEPLACER; IDF=IDENTIFIANT; LIV=LIVRAISON;    *
      * PIE,PI=PIECE; QTE=QUANTITE; REQ=REQUÊTE; VAR=VARIABLE;         *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. vrflivpi.
       AUTHOR. Leocrabe225.
       DATE-WRITTEN. 17-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-POU                   PIC 9(10).
       01 PG-IDF-LIV               PIC 9(10).
       01 PG-IDF-PIE               PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDF-LIV               PIC 9(10).
       01 LK-IDF-PIE               PIC 9(10).
      * Arguments de sortie.

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-IDF-LIV,
                                LK-IDF-PIE,
                                LK-LIR-RET.


           PERFORM 0100-VRF-LIV-PIE-DEB
              THRU 0100-VRF-LIV-PIE-FIN.

           EXIT PROGRAM.
           

      ****************************PARAGRAPHES***************************
       0100-VRF-LIV-PIE-DEB.

       0110-DEP-VAR-DEB.
           MOVE LK-IDF-LIV   TO PG-IDF-LIV.
           MOVE LK-IDF-PIE   TO PG-IDF-PIE.
       0110-DEP-VAR-FIN.

       0120-REQ-SQL-DEB.

           EXEC SQL
               SELECT id_pie
               INTO :PG-POU
               FROM piece
               WHERE id_pie = :PG-IDF-PIE
           END-EXEC.
  
           EVALUATE SQLCODE
               WHEN 0
                   SET LK-LIR-RET-OK TO TRUE
                   EXEC SQL COMMIT END-EXEC
               WHEN 100
                   SET LK-LIR-RET-VID TO TRUE
                   EXEC SQL COMMIT END-EXEC
                   EXIT PROGRAM
               WHEN OTHER
                   SET LK-LIR-RET-ERR TO TRUE
                   EXEC SQL ROLLBACK END-EXEC
                   EXIT PROGRAM
           END-EVALUATE.

           EXEC SQL
               SELECT id_liv
               INTO :PG-POU
               FROM livraison
               WHERE id_liv = :PG-IDF-LIV
           END-EXEC.
  
           EVALUATE SQLCODE
               WHEN 0
                   SET LK-LIR-RET-OK TO TRUE
                   EXEC SQL COMMIT END-EXEC
               WHEN 100
                   SET LK-LIR-RET-VID TO TRUE
                   EXEC SQL COMMIT END-EXEC
                   EXIT PROGRAM
               WHEN OTHER
                   SET LK-LIR-RET-ERR TO TRUE
                   EXEC SQL ROLLBACK END-EXEC
                   EXIT PROGRAM
           END-EVALUATE.
       0120-REQ-SQL-FIN.    
       
       0100-VRF-LIV-PIE-FIN.
           