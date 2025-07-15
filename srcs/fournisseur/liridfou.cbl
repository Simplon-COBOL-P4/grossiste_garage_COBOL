      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Sous programme lisant un fournisseur par l'id                  *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; ID=WS-ID; FOU=FOURNISSEUR; ADR=ADRESSE; VIL=VILLE;   *
      * CP=CODE POSTAL; IND=INDICATIF; TEL=TELEPHONE; EMA=EMAIL;       *
      * LIR=LIRE; RET=RETOUR: ERR=ERREUR                               *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridfou.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-ID                    PIC 9(10).
       01 PG-NOM                   PIC X(50).
       01 PG-ADR                   PIC X(50).
       01 PG-VIL                   PIC X(50).
       01 PG-CP                    PIC 9(05).
       01 PG-IND                   PIC 9(03).
       01 PG-TEL                   PIC 9(10).
       01 PG-EMA                   PIC X(50).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-ID                    PIC 9(10).

      * Arguments de sortie.
       01 LK-NOM                   PIC X(50).
       01 LK-ADR                   PIC X(50).
       01 LK-VIL                   PIC X(50).
       01 LK-CP                    PIC 9(05).
       01 LK-IND                   PIC 9(03).
       01 LK-TEL                   PIC 9(10).
       01 LK-EMA                   PIC X(50).
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-ID,
                                LK-NOM,
                                LK-ADR,
                                LK-VIL,
                                LK-CP,
                                LK-IND,
                                LK-TEL,
                                LK-EMA,
                                LK-LIR-RET.

      ******************************************************************
      *                      Programme principal                       *
      ******************************************************************
           PERFORM 0100-LIR-ID-FOU-DEB
              THRU 0100-LIR-ID-FOU-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *                Lire un fournisseur par l'ID                    *
      ******************************************************************
       0100-LIR-ID-FOU-DEB.

      * On copie l'ID reçu dans WS-IDT-CLI.
           MOVE LK-ID TO PG-ID.

           EXEC SQL
               SELECT nom_fou,
                      adresse_fou,
                      ville_fou,
                      cp_fou,
                      indic_fou,
                      tel_fou,
                      mail_fou
               INTO :PG-NOM,
                    :PG-ADR,
                    :PG-VIL,
                    :PG-CP,
                    :PG-IND,
                    :PG-TEL,
                    :PG-EMA
               FROM fournisseur
               WHERE id_fou = :PG-ID
           END-EXEC.

           IF SQLCODE = 0
      * Si le fournisseur est trouvé, on copie les valeur 
      * dans la LINKAGE SECTION
               MOVE PG-NOM        TO LK-NOM
               MOVE PG-EMA        TO LK-EMA
               MOVE PG-IND        TO LK-IND
               MOVE PG-TEL        TO LK-TEL
               MOVE PG-CP         TO LK-CP
               MOVE PG-VIL        TO LK-VIL
               MOVE PG-ADR        TO LK-ADR
               SET LK-LIR-RET-OK  TO TRUE
           ELSE
               SET LK-LIR-RET-ERR TO TRUE  
           END-IF.

       0100-LIR-ID-FOU-FIN.

