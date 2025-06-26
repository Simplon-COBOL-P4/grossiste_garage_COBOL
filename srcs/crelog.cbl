      *** TRIGRAMMES:
      * DETAIL=DTL; TYPE=TYP; DEPLACE=DEP; VARIABLE=VAR; INSERTION=INS;
      * DONNEES=DON; LOG=LG (EXCEPTION);

      *** FONCTION DU PROGRAMME:
      * IL PREND LES INFORMATIONS CONCERNANT LA CRÉATION D'UN LOG ET
      * INSÈRE LES DONNÉES DANS LA TABLE 'logs'.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. crelog.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-DTL-LG       PIC X(100).
       01 PG-TYP-LG       PIC X(12).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       01 LK-DTL-LG       PIC X(100).
       01 LK-TYP-LG       PIC X(12).


       PROCEDURE DIVISION USING LK-DTL-LG
                                LK-TYP-LG.

      * DEPLACE LES VARIABLES.
           PERFORM 0100-DEP-LES-VAR-DEB
              THRU 0100-DEP-LES-VAR-FIN.

      * INSERTION DES DONNEES DANS LA TABLE "logs".
           PERFORM 0200-INS-DON-DEB
              THRU 0200-INS-DON-FIN.

           EXIT PROGRAM.


      ******************************************************************
      ***************************PARAGRAPHES****************************

       0100-DEP-LES-VAR-DEB.
           MOVE LK-DTL-LG   TO PG-DTL-LG.
           MOVE LK-TYP-LG   TO PG-TYP-LG.
       0100-DEP-LES-VAR-FIN.

       0200-INS-DON-DEB.
       EXEC SQL
           INSERT INTO logs (detail_log, type_log)
           VALUES (:PG-DTL-LG, :PG-TYP-LG)
       END-EXEC.
       EXEC SQL COMMIT WORK END-EXEC.
       0200-INS-DON-FIN.



















      