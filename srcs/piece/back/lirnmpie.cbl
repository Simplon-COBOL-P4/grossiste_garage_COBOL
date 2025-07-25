      ******************************************************************
      * Ce programme lit une pièce depuis la base de donnée            *
      * par son nom et retourne ses infos dans la linkage.             *
      *                                                                *
      * Trigrammes :                                                   *
      * ID=IDENTIFIANT; PIE=PIECE; SEU=SEUIL; QNT=QUANTITE;            *
      * FOR=FOURNISSEUR; LIR=LIRE.                                     *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirnmpie.
       AUTHOR. Yassine.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-ID-PIE          PIC 9(10).
       01 PG-NOM-PIE         PIC X(50).
       01 PG-QNT-PIE         PIC 9(10).
       01 PG-SEU-PIE         PIC 9(10).
       01 PG-ID-FOR          PIC 9(10).
       01 PG-NOM-FOR         PIC X(50).
       EXEC SQL END DECLARE SECTION END-EXEC.


       LINKAGE SECTION.

      * Argument d'entrée.
       01 LK-NOM-PIE         PIC X(50).

      * Arguments de sortie.
       01 LK-ID-PIE          PIC 9(10).
       01 LK-QNT-PIE         PIC 9(10).
       01 LK-SEU-PIE         PIC 9(10).
       01 LK-ID-FOR          PIC 9(10).
       01 LK-NOM-FOR         PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-NOM-PIE,
                                LK-ID-PIE,
                                LK-QNT-PIE,
                                LK-SEU-PIE,
                                LK-ID-FOR,
                                LK-NOM-FOR,
                                LK-LIR-RET.

      ******************************************************************
      *                    Programme principal                         *
      ******************************************************************
           PERFORM 0100-LIR-ID-PIE-DEB
              THRU 0100-LIR-ID-PIE-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *                  Lire une pièce par ID                         *
      ******************************************************************
       0100-LIR-ID-PIE-DEB.

      * On copie le nom d'entrée dans variable de PG-NOM-PIE pour 
      * recarcher dans la base de donnée.
           MOVE LK-NOM-PIE TO PG-NOM-PIE.

       EXEC SQL
           SELECT p.id_pie,
                  p.nom_pie,
                  p.qt_pie,
                  p.seuil_pie,
                  f.id_fou,
                  f.nom_fou
           INTO :PG-ID-PIE,
                :PG-NOM-PIE,
                :PG-QNT-PIE,
                :PG-SEU-PIE,
                :PG-ID-FOR,
                :PG-NOM-FOR
           FROM piece p
                JOIN fournisseur f ON p.id_fou = f.id_fou
           WHERE p.nom_pie = :PG-NOM-PIE
       END-EXEC.

           IF SQLCODE = 0
      * Si la piece est trouvé, on envoye les infos dans la linkage.
               MOVE PG-ID-PIE    TO LK-ID-PIE
               MOVE PG-NOM-PIE   TO LK-NOM-PIE
               MOVE PG-QNT-PIE   TO LK-QNT-PIE
               MOVE PG-SEU-PIE   TO LK-SEU-PIE
               MOVE PG-ID-FOR    TO LK-ID-FOR
               MOVE PG-NOM-FOR   TO LK-NOM-FOR
               SET LK-LIR-RET-OK TO TRUE
           ELSE
               SET LK-LIR-RET-ERR TO TRUE
           END-IF.

       0100-LIR-ID-PIE-FIN.
