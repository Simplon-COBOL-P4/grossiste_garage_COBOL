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
           01 PG_IDT_PIE         PIC 9(20).
           01 PG_NOM_PIE         PIC X(80).
           01 PG_QTE_PIE         PIC 9(04).
           01 PG_SUI_PIE         PIC 9(04).
           01 PG_IDT_FOU         PIC 9(20).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       77  LK-ID-PIE          PIC 9(10).

       PROCEDURE DIVISION USING LK-ID-PIE.

           PERFORM 0100-SUP-PIE-DEB 
              THRU 0100-SUP-PIE-FIN.

           EXIT PROGRAM. 
       
       0100-SUP-PIE-DEB.
           MOVE LK-ID-PIE TO id_pie
           EXEC SQL 
                DELETE FROM  piece 
                WHERE id_pie = :id_pie
           END-EXEC.
           EXEC SQL COMMIT END-EXEC.
           
       0100-SUP-PIE-FIN.
           EXIT.

