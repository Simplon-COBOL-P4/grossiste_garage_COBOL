      ******************************************************************
      *                             ENTÊTE                             *
      * Programme qui change le statut à “terminé” d’une livraison.    *
      * Le programme prend en paramètre l’ID d’une livraison.          *
      * À noter qu’il retourne un code erreur (en flag), qui est déjà  *
      * implémenté dans le squelette. Il est impératif de remplir ce   *
      * code erreur avant de rendre la main au programme appelant.     *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ERR=ERREUR                                                     *
      * IDT=IDENTITE                                                   *
      * MAJ=MISE A JOUR                                                *
      * LIV=LIVRAISON                                                  *
      * RET=RETOUR                                                     *
      * STA=STATUT                                                     *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. majliv.
       AUTHOR. Benoit.
       DATE-WRITTEN. 09-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDT-LIV            PIC 9(10).
       01 PG-STA-LIV            PIC 9(01).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDT                     PIC 9(10).
      * Arguments de sortie.
       COPY majret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-IDT,
                                LK-MAJ-RET.
           PERFORM 0100-STA-LIV-DEB
              THRU 0100-STA-LIV-FIN.
           
           EXIT PROGRAM.
      *
      * Positionné le statut d'une livraison à 'terminer'
      *
           0100-STA-LIV-DEB.

               MOVE 1 TO PG-STA-LIV.
               MOVE LK-IDT TO PG-IDT-LIV.
               
               EXEC SQL
                UPDATE livraison
                SET statut_liv = :PG-STA-LIV
                WHERE id_liv = :PG-IDT-LIV
               END-EXEC.
               
               IF SQLCODE = 0 THEN
                  EXEC SQL COMMIT END-EXEC
                  SET LK-MAJ-RET-OK TO TRUE
               ELSE
                  SET LK-MAJ-RET-ERR TO TRUE
               END-IF.

           0100-STA-LIV-FIN.
               EXIT.
