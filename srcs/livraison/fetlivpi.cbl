      ******************************************************************
      * Programme pour recupérer les id pièces et leur quantités       * 
      * associés liès à une livraison ligne par ligne                  *
      *                                                                *
      * TRIGRAMMES                                                     *
      * FET=FETCH; ID=IDENTIFIANT; LIV=LIVRAISON; PIE=PIECE;           *
      * QTE=QUANTITE; CUR=CURSEUR; ETA=ETAT; OUV=OUVERT; FER=FERME;    *
      * DEC=DECLARER; ERR=ERREUR; RET=RETOUR.                          *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. fetlivpi.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 10-07-2025 (fr).

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-ID-LIV               PIC 9(10).
       01  PG-ID-PIE               PIC 9(10).
       01  PG-QTE                  PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Curseur ouvert ou fermer
       01  WS-CUR-ETA              PIC X VALUE 'N'.
           88 WS-CUR-FER           VALUE 'N'.
           88 WS-CUR-OUV           VALUE 'Y'.

       LINKAGE SECTION.

      * Argument d'entrée
       01  LK-ID-LIV               PIC 9(10).

      * Arguments de sortie 
       01  LK-ID-PIE               PIC 9(10).
       01  LK-QTE                  PIC 9(10).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.
       
       PROCEDURE DIVISION USING LK-ID-LIV,
                                LK-ID-PIE,
                                LK-QTE,
                                LK-LIR-RET.
           
           PERFORM 0100-DEC-CUR-DEB
              THRU 0100-DEC-CUR-FIN.
              
           PERFORM 0200-OUV-CUR-DEB
              THRU 0200-OUV-CUR-FIN.

           PERFORM 0300-FET-LIV-PIE-DEB
              THRU 0300-FET-LIV-PIE-FIN.

           PERFORM 0400-FER-CUR-DEB
              THRU 0400-FER-CUR-FIN.
               
           EXIT PROGRAM.

      * Déclaration du curseur
       0100-DEC-CUR-DEB.
           IF WS-CUR-FER
               MOVE LK-ID-LIV TO PG-ID-LIV
               EXEC SQL 
                   DECLARE CUR_LIV CURSOR FOR
                   SELECT id_pie, qt_liv_pie
                   FROM livraison
                   INNER JOIN livraison_piece
                   ON livraison.id_liv = livraison_piece.id_liv
                   WHERE livraison.id_liv = :PG-ID-LIV
               END-EXEC
           END-IF.    
       0100-DEC-CUR-FIN.

      * Ouverture du curseur
       0200-OUV-CUR-DEB.
           IF WS-CUR-FER
               EXEC SQL 
                   OPEN CUR_LIV
               END-EXEC
               IF SQLCODE NOT = 0
                   SET LK-LIR-RET-ERR TO TRUE
               END-IF
               SET WS-CUR-OUV TO TRUE
           END-IF.    
       0200-OUV-CUR-FIN.

      * Lecture d'une ligne 
       0300-FET-LIV-PIE-DEB.
           EXEC SQL
               FETCH CUR_LIV INTO :PG-ID-PIE, :PG-QTE
           END-EXEC.

           IF SQLCODE = 0
               MOVE PG-ID-PIE TO LK-ID-PIE
               MOVE PG-QTE    TO LK-QTE
           ELSE
               IF SQLCODE = 100
                   SET LK-LIR-RET-OK TO TRUE
                   SET WS-CUR-FER    TO TRUE
               ELSE
                   SET LK-LIR-RET-ERR TO TRUE
                   SET WS-CUR-FER     TO TRUE
               END-IF
           END-IF.
       0300-FET-LIV-PIE-FIN.

      * Fermeture du curseur
       0400-FER-CUR-DEB.
           IF WS-CUR-FER
               EXEC SQL
                   CLOSE CUR_LIV
               END-EXEC
               IF SQLCODE NOT = 0
                   SET LK-LIR-RET-ERR TO TRUE
               END-IF
           END-IF.    
       0400-FER-CUR-FIN.
       
