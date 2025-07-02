      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * lirpie lis la database pour récupèrer les pièces et fournisseur*
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * LIRE=LIR; PIE=PIECE; CUR=curseur; VAR=variable; IDENTIFIANT=IDN*
      * QUA=quantité; SEU=seuil; FOU=fournisseur; TEM=temporaire;      *
      * AJO=ajout; OFS=offset; SEN=sens; IDX=index; PAG=page           *
      * TAB=tableau; ARG=argument
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpie.
       AUTHOR. lucas.
       DATE-WRITTEN. 26-06-25 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-SEN-TRI        PIC 9(01).
       01 PG-IDN-TEM        PIC 9(10).
       01 PG-NOM-TEM        PIC X(80).
       01 PG-QUA-TEM        PIC 9(10).
       01 PG-SEU-TEM        PIC 9(10).
       01 PG-NOM-FOU-TEM    PIC X(80).
      *pour pouvoir faire le order by dans la requête sql
       01 PG-TRI-SQL PIC X(7).
       01 PG-SEN-TRI-SQL PIC X(5).  
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       
       
       01 WS-TRI            PIC 9(01). 


       01 WS-QUA            PIC 9(02). *> Min 1 - Max 25.

      *le nombre d'élément ajouter dans le tableau
       01 WS-ELT-AJO        PIC 9(02) VALUE 0.

      * l'offset pour la requête SQL
       01 WS-OFS            PIC 9(03).

       01 WS-IDX            PIC 9(2) VALUE 0.


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
              10 LK-NOM     PIC X(80).
              10 LK-TAB-QUA PIC 9(10).
              10 LK-SEU     PIC 9(10).
              10 LK-NOM-FOU PIC X(80).

       

       PROCEDURE DIVISION USING LK-TRI, *>colonne de tri
                                LK-SEN-TRI, *> sens de tri
                                LK-QUA, *>le nombre d'élément 
                                LK-PAG, *>une page est de taille 15,
                                LK-TAB.

      
           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-CUR-DEB
              THRU 0200-CUR-FIN.
           
           EXIT PROGRAM.


       0100-INI-VAR-DEB.

           
      * Une page faisant LK-QUA pieces, on multiplie le numéro de la 
      * page par LK-QUA.
           MULTIPLY LK-PAG BY LK-QUA GIVING WS-OFS.

      * Comme on ne peux pas utiliser les variables de la linkage 
      * section dans une requête SQL, on les move dans la 
      * working-storage section
           MOVE LK-QUA TO WS-QUA.
              
      * Pour le order by.
           IF WS-TRI EQUAL 0
              MOVE "nom_pie" to PG-TRI-SQL
           ELSE IF WS-TRI EQUAL 1 
              MOVE "qte_pie" TO PG-TRI-SQL
           ELSE 
              MOVE "nom_fou" TO PG-TRI-SQL
           END-IF. 

           IF LK-SEN-TRI EQUAL 0 
              MOVE "ASC" TO PG-SEN-TRI-SQL
           ELSE
              MOVE "DESC" TO PG-SEN-TRI-SQL
           END-IF.

      * On initialise la taille du tableau.
           MOVE 0 TO WS-QUA.
           MOVE LK-TRI TO WS-TRI.
           MOVE LK-SEN-TRI TO PG-SEN-TRI.

       0100-INI-VAR-FIN.
           EXIT.



       0200-CUR-DEB.

      * On déclare le curseur.
           IF LK-SEN-TRI EQUAL 1
              EXEC SQL
                  DECLARE curseur CURSOR FOR 
                  SELECT id_pie, nom_pie, qt_pie, seuil_pie, nom_fou
                  FROM Piece INNER JOIN Fournisseur on Piece.id_fou = 
                  Fournisseur.id_fou
                  ORDER BY :PG-TRI-SQL "DESC"
                  FOR READ ONLY
              END-EXEC
           ELSE 
              EXEC SQL
                  DECLARE curseur CURSOR FOR
                  SELECT id_pie, nom_pie, qt_pie, seuil_pie, nom_fou
                  FROM Piece INNER JOIN Fournisseur on Piece.id_fou = 
                  Fournisseur.id_fou
                  ORDER BY :PG-TRI-SQL "ASC"
                  FOR READ ONLY
              END-EXEC
           END-IF.

           
      * On ouvre le curseur.
              EXEC SQL
                 OPEN curseur
              END-EXEC. 

      * On lit le curseur tant que le sqlcode n'est pas à 100 ou que le
      * nombre d'élément à ajouter est atteint.
               PERFORM UNTIL SQLCODE = 100 
               OR WS-ELT-AJO EQUAL LK-QUA
                 EXEC SQL
                    FETCH curseur into :PG-IDN-TEM, 
                    :PG-NOM-TEM, 
                    :PG-QUA-TEM, 
                    :PG-SEU-TEM,
                    :PG-NOM-FOU-TEM
                 END-EXEC

                 ADD 1 TO WS-IDX
      * Comme je n'arrive pas à mettre de LIMIT et OFFSET dans la 
      * requête SQL, je les implémente coté cobol.
                 IF WS-IDX EQUAL WS-OFS OR GREATER THAN WS-OFS
                        
                  ADD 1 TO WS-ELT-AJO

                  MOVE PG-IDN-TEM     TO LK-IDN(WS-ELT-AJO)  
                  MOVE PG-NOM-TEM     TO LK-NOM(WS-ELT-AJO)
                  MOVE PG-QUA-TEM     TO LK-TAB-QUA(WS-ELT-AJO)
                  MOVE PG-SEU-TEM     TO LK-SEU(WS-ELT-AJO)
                  MOVE PG-NOM-FOU-TEM TO LK-NOM-FOU(WS-ELT-AJO)
                 END-IF
               END-PERFORM.

      * On ferme le curseur.
              EXEC SQL
                 CLOSE curseur
              END-EXEC.

       0200-CUR-FIN.
           EXIT.
