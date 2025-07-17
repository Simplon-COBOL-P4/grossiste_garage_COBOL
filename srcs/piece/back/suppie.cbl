      ******************************************************************
      * Ce programme supprime une pièce du fichier 'piéce'. L'identité 
      * du pièce à supprimer est délivré par le programme appelant.
      *
      *Trigram:
      *  COD = Code
      *  PIE = Pièce
      *  RET = Retour
      *  suppie =  sup-supprimé   pie-pièce
      *Paragraphe
      *  0100-APL-PRG. Appel sous Programme
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. suppie.
       AUTHOR. Benoit.
       DATE-WRITTEN. 27-06-2025 (fr).

      ******************************************************************
      *
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION. 

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDT-PIE          PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       77  LK-ID-PIE          PIC 9(10).

       COPY supret REPLACING ==:PREFIX:== BY ==LK==.


       PROCEDURE DIVISION USING LK-ID-PIE,
                                LK-SUP-RET.

           PERFORM 0100-SUP-PIE-DEB 
              THRU 0100-SUP-PIE-FIN.

           EXIT PROGRAM. 
       
       0100-SUP-PIE-DEB.
           MOVE LK-ID-PIE TO PG-IDT-PIE
           EXEC SQL 
                DELETE FROM  piece 
                WHERE id_pie = :PG-IDT-PIE
           END-EXEC.

           EVALUATE SQLCODE
               WHEN 0
                   EXEC SQL COMMIT END-EXEC
                   SET LK-SUP-RET-OK TO TRUE
               WHEN OTHER
                   EXEC SQL ROLLBACK END-EXEC
                   SET LK-SUP-RET-ERR TO TRUE
           END-EVALUATE.
       0100-SUP-PIE-FIN.
