      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *** TRIGRAMMES:                                                  *
      * SUPPRIMER=SUP; CLIENT=CLI; IDENTIFIANT=IDF;                    *
      *                                                                *
      *** FONCTION DU PROGRAMME:                                       *
      * IL SUPPRIME UN CLIENT PAR SON ID DANS LA TABLE 'client'        *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. supcli.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 27-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
OCESQL*EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDF-CLI         PIC 9(10).
OCESQL*EXEC SQL END DECLARE SECTION END-EXEC.
OCESQL*EXEC SQL INCLUDE SQLCA END-EXEC.
OCESQL     copy "sqlca.cbl".

OCESQL*
OCESQL 01  SQ0001.
OCESQL     02  FILLER PIC X(036) VALUE "DELETE FROM client WHERE id_cl"
OCESQL  &  "i = $1".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDF-CLI         PIC 9(10).

       PROCEDURE DIVISION USING LK-IDF-CLI.

      * SUPPRIME UN CLIENT.
           PERFORM 0100-SUP-CLI-DEB
              THRU 0100-SUP-CLI-FIN.

           EXIT PROGRAM.


      ******************************************************************
      *                          PARAGRAPHES                           * 
      ******************************************************************
       0100-SUP-CLI-DEB.
           MOVE LK-IDF-CLI   TO PG-IDF-CLI.
           
OCESQL*EXEC SQL
OCESQL*    DELETE FROM client
OCESQL*    WHERE id_cli = :PG-IDF-CLI
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 1
OCESQL          BY VALUE 10
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE PG-IDF-CLI
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecParams" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0001
OCESQL          BY VALUE 1
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL.
OCESQL*EXEC SQL COMMIT WORK END-EXEC.
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE "COMMIT" & x"00"
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL.
       0100-SUP-CLI-FIN.
       0100-SUP-CLI-FIN.
       0100-SUP-CLI-FIN.
