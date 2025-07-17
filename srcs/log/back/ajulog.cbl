      *** TRIGRAMMES:
      * DETAIL=DTL; TYPE=TYP; DEPLACE=DEP; VARIABLE=VAR; INSERTION=INS;
      * DONNEES=DON; LOG=LG (EXCEPTION); UTI=UTILISATEUR; ID=IDENTIFIANT

      *** FONCTION DU PROGRAMME:
      * IL PREND LES INFORMATIONS CONCERNANT LA CRÉATION D'UN LOG ET
      * INSÈRE LES DONNÉES DANS LA TABLE 'logs'.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajulog.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-DTL-LG       PIC X(100).
       01 PG-TYP-LG       PIC X(12).
       01 PG-UTI-ID       PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       01 LK-DTL-LG       PIC X(100).
       01 LK-TYP-LG       PIC X(12).
       01 LK-UTI-ID       PIC 9(10).

       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.


       PROCEDURE DIVISION USING LK-DTL-LG,
                                LK-TYP-LG,
                                LK-UTI-ID,
                                LK-AJU-RET.

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
           MOVE LK-UTI-ID   TO PG-UTI-ID.
       0100-DEP-LES-VAR-FIN.

       0200-INS-DON-DEB.
           IF PG-UTI-ID EQUAL 0 THEN
               EXEC SQL
                   INSERT INTO logs (detail_log, type_log)
                   VALUES (:PG-DTL-LG, :PG-TYP-LG)
               END-EXEC
           ELSE
               EXEC SQL
                   INSERT INTO logs (detail_log, type_log, id_uti)
                   VALUES (:PG-DTL-LG, :PG-TYP-LG, :PG-UTI-ID)
               END-EXEC
           END-IF.

           IF SQLCODE EQUAL 0 THEN
               EXEC SQL COMMIT WORK END-EXEC
               SET LK-AJU-RET-OK TO TRUE
           ELSE
               EXEC SQL ROLLBACK END-EXEC
               SET LK-AJU-RET-ERR TO TRUE
           END-IF.
       0200-INS-DON-FIN.

      
