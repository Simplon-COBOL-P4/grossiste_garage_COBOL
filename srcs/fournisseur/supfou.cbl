      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *** TRIGRAMMES:                                                  *
      * SUPPRIMER=SUP; FOURNISSEUR=FOU; IDENTIFIANT=ID; DETAIL=DET;    *
      * UTILISATEUR=UTI                                                *
      *** FONCTION DU PROGRAMME:                                       *
      * IL SUPPRIME UN FOURNISSEUR PAR SON ID DANS LA TABLE            * 
      * 'fournisseur'                                                  *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. supfou.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-ID-FOU         PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.

       77  WS-LOG-DET        PIC X(100).
       01  WS-UTI-ID         PIC 9(10).

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-ID-FOU         PIC 9(10).

       COPY supret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-ID-FOU,
                                LK-SUP-RET.

      * SUPPRIME UN FOURNISSEUR.
           PERFORM 0100-SUP-FOU-DEB
              THRU 0100-SUP-FOU-FIN.

           EXIT PROGRAM.


      ******************************************************************
      *                          PARAGRAPHES                           * 
      ******************************************************************
       0100-SUP-FOU-DEB.
           MOVE LK-ID-FOU   TO PG-ID-FOU.
           
           EXEC SQL
               DELETE FROM fournisseur
               WHERE id_fou = :PG-ID-FOU
           END-EXEC.
           IF SQLCODE = 0
      * Le fournisseur est supprimé avec succès.
               EXEC SQL COMMIT END-EXEC
               STRING "["
                      LK-ID-FOU
                      "] Suppresion"
                      INTO WS-LOG-DET
               END-STRING
               CALL "ajulog"
                     USING 
                     WS-LOG-DET
                     "Fournisseur"
                     WS-UTI-ID
                     WS-AJU-RET
               END-CALL
               SET LK-SUP-RET-OK       TO TRUE       
           ELSE
      * Le fournisseur n'est pas dans la table ou la table n'existe pas.
               EXEC SQL ROLLBACK END-EXEC
               SET LK-SUP-RET-ERR      TO TRUE
           END-IF.
       0100-SUP-FOU-FIN.
