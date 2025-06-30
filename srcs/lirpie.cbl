      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * lirpie lis la database pour récupèrer les pièces et fournisseur*
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * LIRE=LIR; PIE=PIECE; CUR=curseur; VAR=variable                 *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpie.
       AUTHOR. lucas.
       DATE-WRITTEN. 26-06-25 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       EXEC SQL INCLUDE SQLCA END-EXEC.
       01 WS-SENS-TRI            PIC 9(01).
           88 WS-ASCENDANT                 VALUE 0.
           88 WS-DESCENDANT                VALUE 1.
       
       01 WS-TRI                 PIC 9(01).
           88 WS-TRI-NOM                   VALUE 0.
           88 WS-TRI-QUANTITE              VALUE 1.
           88 WS-TRI-FOURNISSEUR           VALUE 2.

      *pour pouvoir faire le order by dans la requête sql
       01 WS-TRI-SQL PIC X(7).
       01 WS-SENS-TRI-SQL PIC X(5).  

       01 WS-TABLEAU. 
           05 WS-TABLEAU-ARGUMENT OCCURS 25 TIMES. *> Max quantité.
              10 WS-IDENTIFIANT       PIC 9(10).
              10 WS-NOM               PIC X(80).
              10 WS-T-QUANTITE        PIC 9(10).
              10 WS-SEUIL             PIC 9(10).
              10 WS-NOM-FOURNISSEUR   PIC X(80).
       
       01 WS-IDENTIFIANT-TEMPO        PIC 9(10).
       01 WS-NOM-TEMPO                PIC X(80).
       01 WS-T-QUANTITE-TEMPO         PIC 9(10).
       01 WS-SEUIL-TEMPO              PIC 9(10).
       01 WS-NOM-FOURNISSEUR-TEMPO    PIC X(80).


       01 WS-QUANTITE            PIC 9(02). *> Min 1 - Max 25.

      *le nombre d'élément ajouter dans le tableau
       01 WS-ELT-AJOUT           PIC 9(02) VALUE 0.

      * l'offset pour la requête SQL
       01 WS-OFFSET              PIC 9(03).

       01 WS-INDEX PIC 9(2).


       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-TRI                 PIC 9(01).
           88 LK-TRI-NOM                   VALUE 0.
           88 LK-TRI-QUANTITE              VALUE 1.
           88 LK-TRI-FOURNISSEUR           VALUE 2.
       
       01 LK-SENS-TRI            PIC 9(01).
           88 LK-ASCENDANT                 VALUE 0.
           88 LK-DESCENDANT                VALUE 1.

       01 LK-QUANTITE            PIC 9(02). *> Min 1 - Max 25.

       01 LK-PAGE-P              PIC 9(10). *> Min 0 - Max 1,000,000,000.

      * Arguments de sortie.
       01 LK-TABLEAU. 
           05 LK-TABLEAU-ARGUMENT OCCURS 25 TIMES. *> Max quantité.
              10 LK-IDENTIFIANT       PIC 9(10).
              10 LK-NOM               PIC X(80).
              10 LK-T-QUANTITE        PIC 9(10).
              10 LK-SEUIL             PIC 9(10).
              10 LK-NOM-FOURNISSEUR   PIC X(80).

       

       PROCEDURE DIVISION USING LK-TRI, *>colonne de tri
                                LK-SENS-TRI, *> sens de tri
                                LK-QUANTITE, *>le nombre d'élément 
                                LK-PAGE-P, *>une page est de taille 15,
                                LK-TABLEAU.

      
           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-CUR-DEB
              THRU 0200-CUR-FIN.


           DISPLAY "à la fin". 
           DISPLAY WS-ELT-AJOUT.

           DISPLAY "on affiche le tableau"
           PERFORM VARYING WS-INDEX from 1 by 1 UNTIL WS-INDEX GREATER
           THAN LK-QUANTITE 
           DISPLAY "affichage inutile"
           DISPLAY "l'index: " WS-INDEX
           DISPLAY  LK-IDENTIFIANT(WS-INDEX)   
           DISPLAY LK-NOM(WS-INDEX)              
           DISPLAY LK-T-QUANTITE(WS-INDEX)         
           DISPLAY LK-SEUIL(WS-INDEX)            
           DISPLAY LK-NOM-FOURNISSEUR(WS-INDEX)   
           END-PERFORM.
           

           EXIT PROGRAM.


       0100-INI-VAR-DEB.
           MOVE LK-QUANTITE TO WS-QUANTITE.
           MULTIPLY LK-PAGE-P BY 15 GIVING WS-OFFSET.

      * Pour le order by.
           IF WS-TRI EQUAL 0
              MOVE "nom_pie" to WS-TRI-SQL
           ELSE IF WS-TRI EQUAL 1 
              MOVE "qte_pie" TO WS-TRI-SQL
           ELSE 
              MOVE "nom_fou" TO WS-TRI-SQL
           END-IF. 

           IF LK-SENS-TRI EQUAL 0 
              MOVE "ASC" TO WS-SENS-TRI-SQL
           ELSE
              MOVE "DESC" TO WS-SENS-TRI-SQL
           END-IF.

      * On initialise la taille du tableau.
           MOVE 0 TO WS-QUANTITE.
           MOVE LK-TRI TO WS-TRI.
           MOVE LK-SENS-TRI TO WS-SENS-TRI.

       0100-INI-VAR-FIN.
           EXIT.



       0200-CUR-DEB.

      * On déclare le curseur.
           IF LK-SENS-TRI EQUAL 1
              EXEC SQL
                  DECLARE curseur CURSOR FOR
                  SELECT id_pie, nom_pie, qt_pie, seuil_pie, nom_fou
                  FROM Piece JOIN Fournisseur on Piece.id_fou = 
                  Fournisseur.id_fou
                  ORDER BY :WS-TRI-SQL "DESC"
      *            LIMIT :WS-QUANTITE
      *           LIMIT :WS-QUANTITE OFFSET :WS-OFFSET
                  FOR READ ONLY
              END-EXEC
           ELSE 
              EXEC SQL
                  DECLARE curseur CURSOR FOR
                  SELECT id_pie, nom_pie, qt_pie, seuil_pie, nom_fou
                  FROM Piece JOIN Fournisseur on Piece.id_fou = 
                  Fournisseur.id_fou
                  ORDER BY :WS-TRI-SQL "ASC"
      *            LIMIT :WS-QUANTITE
      *           LIMIT :WS-QUANTITE OFFSET :WS-OFFSET
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
               OR WS-ELT-AJOUT EQUAL LK-QUANTITE
                 EXEC SQL
                    FETCH curseur into :WS-IDENTIFIANT-TEMPO, 
                    :WS-NOM-TEMPO, 
                    :WS-T-QUANTITE-TEMPO, 
                    :WS-SEUIL-TEMPO,
                    :WS-NOM-FOURNISSEUR-TEMPO
                 END-EXEC
                        
                  ADD 1 TO WS-ELT-AJOUT
                  MOVE WS-IDENTIFIANT-TEMPO 
                  TO LK-IDENTIFIANT(WS-ELT-AJOUT) 
                  DISPLAY "identifiant: " WS-IDENTIFIANT-TEMPO 
                  MOVE WS-NOM-TEMPO TO LK-NOM(WS-ELT-AJOUT)
                  DISPLAY "nom tempo: " WS-NOM-TEMPO
                  MOVE WS-T-QUANTITE-TEMPO 
                  TO LK-T-QUANTITE(WS-ELT-AJOUT)
                  DISPLAY "quantite-t: " WS-T-QUANTITE-TEMPO
                  MOVE WS-SEUIL-TEMPO TO LK-SEUIL(WS-ELT-AJOUT)
                  DISPLAY "seuil: " WS-SEUIL-TEMPO
                  MOVE WS-NOM-FOURNISSEUR-TEMPO 
                  TO LK-NOM-FOURNISSEUR(WS-ELT-AJOUT)
                  DISPLAY "nom-fou: " WS-NOM-FOURNISSEUR-TEMPO
               END-PERFORM.

      * On ferme le curseur.
              EXEC SQL
                 CLOSE curseur
              END-EXEC.

           DISPLAY  "fin du paragraphe 2".
       0200-CUR-FIN.
           EXIT.