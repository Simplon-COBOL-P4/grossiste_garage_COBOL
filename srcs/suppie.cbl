      ******************************************************************
      * Ce programme supprime une pièce du fichier 'piéce'. L'identité 
      * du pièce à supprimer est délivré par le programme appelant.
      * Un code retour est renvoyé pour notifier le programme appelant
      * si la suppression a été effectuée avec succès (0) ou non 1).
      *
      *Trigram:
      *  COD = Code
      *  PIE = Pièce
      *  RET = Retour
      *  suppie =  sup-supprimé   pie-pièce
      *Paragraphe
      *  0100-APL-PRG. Appel sous Programme
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. suppie.
       AUTHOR.    Benoit.
       DATE-WRITTEN. 27-06-2025 (fr).

      ******************************************************************
      *
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION. 

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
           01 id_pie             PIC 9(20).
           01 nom_pie            PIC X(80).
           01 qt_pie             PIC 9(04).
           01 seuil_pie          PIC 9(04).
           01 id_fou             PIC 9(20).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       77  LK-COD-RET         PIC 9(01).
       77  LK-ID-PIE          PIC 9(20).

       PROCEDURE DIVISION USING LK-COD-RET LK-ID-PIE.

           PERFORM 0100-SUP-PIE-DEB 
              THRU 0100-SUP-PIE-FIN.

           EXIT PROGRAM.
       
       0100-SUP-PIE-DEB.
           MOVE LK-ID-PIE TO id_pie
      * Selectioné l'enrégistrement à supprimer     
           EXEC SQL  
            SELECT id_pie,nom_pie,qt_pie,seuil_pie,id_fou
            INTO :id_pie :nom_pie :qt_pie :seuil_pie :id_fou
            FROM piece
            WHERE id_pie = :id_pie
           END-EXEC.

      * Vérifié le code retour 
           IF SQLCODE = 0 THEN
              EXEC SQL 
                   DELETE FROM  piece 
                   WHERE id_pie = :id_pie
              END-EXEC
              IF  SQLCODE = 0 THEN
                  EXEC SQL COMMIT END-EXEC
                  MOVE 0 TO LK-COD-RET
              ELSE
                  MOVE 1 TO LK-COD-RET
              END-IF
           ELSE 
              MOVE 1 TO LK-COD-RET
           END-IF.
           
       0100-SUP-PIE-FIN.
           EXIT.

