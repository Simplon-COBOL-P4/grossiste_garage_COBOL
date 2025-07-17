      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * lirpie lis la database pour récupèrer les pièces et fournisseur*
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * LIRE=LIR; PIE=PIECE; CUR=curseur; VAR=variable; IDN=identifiant*
      * QUA=quantité; SEU=seuil; FOU=fournisseur; TEM=temporaire;      *
      * AJO=ajout; OFS=offset; SEN=sens; IDX=index; PAG=page           *
      * TAB=tableau; ARG=argument                                      * 
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpie.
       AUTHOR. lucas.
       DATE-WRITTEN. 26-06-25 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-QRY.
           05 PG-QRY-BOD    PIC X(500).
           05 FILLER        PIC X(1)  VALUE X"00".

       01 PG-SEN-TRI        PIC 9(01).
       01 PG-IDN-TEM        PIC 9(10).
       01 PG-NOM-TEM        PIC X(50).
       01 PG-QUA-TEM        PIC 9(10).
       01 PG-SEU-TEM        PIC 9(10).
       01 PG-NOM-FOU-TEM    PIC X(50).
      * Pour pouvoir faire le order by dans la requête sql.
       01 PG-TRI-SQL PIC X(7).  
       01 PG-QUA            PIC 9(02). *> Min 1 - Max 25.
      * L'offset pour la requête SQL
       01 PG-OFS            PIC 9(03).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       
       01 WS-TRI            PIC 9(01).

      *le nombre d'élément ajouter dans le tableau
       01 WS-ELT-AJO        PIC 9(02) VALUE 0.

       01 WS-SEN-TRI        PIC X(04)  VALUE "DESC".

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-TRI            PIC 9(01).
       
       01 LK-SEN-TRI        PIC 9(01).

       01 LK-QUA            PIC 9(02). *> Min 1 - Max 25.

       01 LK-PAG            PIC 9(10). *> Min 0 - Max 1,000,000,000.

      * Arguments de sortie.
       01 LK-TAB. 
           05 LK-TAB-ARG OCCURS 25 TIMES. *> Max quantité.
              10 LK-IDN     PIC 9(10).
              10 LK-NOM     PIC X(50).
              10 LK-TAB-QUA PIC 9(10).
              10 LK-SEU     PIC 9(10).
              10 LK-NOM-FOU PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-TRI, *>colonne de tri
                                LK-SEN-TRI, *> sens de tri
                                LK-QUA, *>le nombre d'élément 
                                LK-PAG,
                                LK-TAB,
                                LK-LIR-RET.
      
           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-CUR-DEB
              THRU 0200-CUR-FIN.
           
           EXIT PROGRAM.


       0100-INI-VAR-DEB.

           
      * Une page faisant LK-QUA pieces, on multiplie le numéro de la 
      * page par LK-QUA.
           MULTIPLY LK-PAG BY LK-QUA GIVING PG-OFS.

      * Comme on ne peux pas utiliser les variables de la linkage 
      * section dans une requête SQL, on les move dans la 
      * working-storage section
           MOVE LK-QUA TO PG-QUA.
              
      * Pour le order by.
           IF LK-TRI EQUAL 0
              MOVE "nom_pie" to PG-TRI-SQL
           ELSE IF LK-TRI EQUAL 1 
              MOVE "qt_pie" TO PG-TRI-SQL
           ELSE 
              MOVE "nom_fou" TO PG-TRI-SQL
           END-IF.

           IF LK-SEN-TRI EQUAL 1 THEN
               MOVE "DESC" TO WS-SEN-TRI
           ELSE
               MOVE "ASC" TO WS-SEN-TRI
           END-IF.

           MOVE LK-SEN-TRI TO PG-SEN-TRI.

       0100-INI-VAR-FIN.



       0200-CUR-DEB.
           MOVE SPACE TO PG-QRY-BOD.

           STRING
               "SELECT id_pie, nom_pie, qt_pie, seuil_pie, nom_fou "
               "FROM Piece INNER JOIN Fournisseur ON"
               " Piece.id_fou = Fournisseur.id_fou "
               "ORDER BY " DELIMITED BY SIZE
               PG-TRI-SQL DELIMITED BY SPACE
               SPACE DELIMITED BY SIZE
               WS-SEN-TRI DELIMITED BY SPACE
               " LIMIT " DELIMITED BY SIZE
               PG-QUA DELIMITED BY SIZE
               " OFFSET " DELIMITED BY SIZE
               PG-OFS DELIMITED BY SIZE
               " FOR READ ONLY" DELIMITED BY SIZE
               INTO PG-QRY-BOD
           END-STRING.

OCESQL     CALL "OCESQLCursorDeclare" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE "lirpie_curseur" & X"00"
OCESQL          BY REFERENCE PG-QRY
OCESQL     END-CALL.

           IF SQLCODE NOT EQUAL 0
               EXEC SQL ROLLBACK END-EXEC
               SET LK-LIR-RET-ERR TO TRUE
               EXIT PROGRAM
           END-IF.
           
      * On ouvre le curseur.
           EXEC SQL
               OPEN curseur
           END-EXEC.

           IF SQLCODE NOT EQUAL 0
               EXEC SQL ROLLBACK END-EXEC
               SET LK-LIR-RET-ERR TO TRUE
               EXIT PROGRAM
           END-IF.

      * On lit le curseur tant que le sqlcode n'est pas à 100 ou que le
      * nombre d'élément à ajouter est atteint.
           MOVE 0 TO WS-ELT-AJO.
           PERFORM UNTIL SQLCODE NOT EQUAL 0
               EXEC SQL
                   FETCH curseur into :PG-IDN-TEM, 
                   :PG-NOM-TEM, 
                   :PG-QUA-TEM, 
                   :PG-SEU-TEM,
                   :PG-NOM-FOU-TEM
               END-EXEC

               IF SQLCODE EQUAL 0
                   ADD 1 TO WS-ELT-AJO
 
                   MOVE PG-IDN-TEM     TO LK-IDN(WS-ELT-AJO)  
                   MOVE PG-NOM-TEM     TO LK-NOM(WS-ELT-AJO)
                   MOVE PG-QUA-TEM     TO LK-TAB-QUA(WS-ELT-AJO)
                   MOVE PG-SEU-TEM     TO LK-SEU(WS-ELT-AJO)
                   MOVE PG-NOM-FOU-TEM TO LK-NOM-FOU(WS-ELT-AJO)
               END-IF
           END-PERFORM.

           MOVE WS-ELT-AJO TO LK-QUA

           EVALUATE SQLCODE
               WHEN 0
                   SET LK-LIR-RET-OK TO TRUE
                   EXEC SQL COMMIT END-EXEC
               WHEN 100
                   SET LK-LIR-RET-OK TO TRUE
                   EXEC SQL COMMIT END-EXEC
               WHEN OTHER
                   SET LK-LIR-RET-ERR TO TRUE
                   EXEC SQL ROLLBACK END-EXEC
           END-EVALUATE.

      * On ferme le curseur.
           EXEC SQL
               CLOSE curseur
           END-EXEC.

           IF SQLCODE NOT EQUAL 0
               EXEC SQL ROLLBACK END-EXEC
               SET LK-LIR-RET-ERR TO TRUE
               EXIT PROGRAM
           END-IF.
       0200-CUR-FIN.
