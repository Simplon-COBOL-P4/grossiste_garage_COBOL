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
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDF-CLI         PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

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
           
       EXEC SQL
           DELETE FROM client
           WHERE id_cli = :PG-IDF-CLI
       END-EXEC.
       EXEC SQL COMMIT WORK END-EXEC.
       0100-SUP-CLI-FIN.
