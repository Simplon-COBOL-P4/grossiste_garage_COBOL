      ******************************************************************
      * Le programme lie un client dans la base de donnée par son ID   *
      * et envoye les informations dans la LINKAGE SECTION.            *
      *                                                                *
      * Trigrammes :                                                   *
      * ADR=ADRESSE; CP=CODE POSTAL; EML=MAIL; IDT=IDENTIFIANT;        *
      * IND=INDICATIF; LIR=LIRE; CLI=CLIENT; TEL=TELEPHONE;            *
      * VIL=VILLE.                                                     *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridcli.
       AUTHOR. Yssine.
       DATE-WRITTEN. 02-07-2025(fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Variable pour stocker temporairement l'ID du client
       01 WS-IDT-CLI       PIC 9(09).

      * Variables pour stocker temporairement les infos récupérées
       01 WS-NOM-CLI       PIC X(50).
       01 WS-EML-CLI       PIC X(50).
       01 WS-IND-CLI       PIC 9(03).
       01 WS-TEL-CLI       PIC 9(10).
       01 WS-CP-CLI        PIC 9(05).
       01 WS-VIL-CLI       PIC X(50).
       01 WS-ADR-CLI       PIC X(50).

       LINKAGE SECTION.
      * Argument d’entrée
       01 LK-IDT-CLI       PIC 9(09).

      * Arguments de sortie
       01 LK-NOM-CLI       PIC X(50).
       01 LK-EML-CLI       PIC X(50).
       01 LK-IND-CLI       PIC 9(03).
       01 LK-TEL-CLI       PIC 9(10).
       01 LK-CP-CLI        PIC 9(05).
       01 LK-VIL-CLI       PIC X(50).
       01 LK-ADR-CLI       PIC X(50).

       PROCEDURE DIVISION USING LK-IDT-CLI, 
                                LK-NOM-CLI, 
                                LK-EML-CLI, 
                                LK-IND-CLI, 
                                LK-TEL-CLI,
                                LK-CP-CLI,
                                LK-VIL-CLI, 
                                LK-ADR-CLI.

      ******************************************************************
      *                      Programme principal                       *
      ******************************************************************
           PERFORM 0100-LIR-ID-CLI-DEB
              THRU 0100-LIR-ID-CLI-FIN

           EXIT PROGRAM.

      ******************************************************************
      *                     Lire un client par l'ID                    *
      ******************************************************************
       0100-LIR-ID-CLI-DEB.

      * On copie l'ID reçu dans WS-IDT-CLI.
           MOVE LK-IDT-CLI TO WS-IDT-CLI

           EXEC SQL
               SELECT id_cli,
                      nom_cli,
                      mail_cli,
                      indic_cli,
                      tel_cli,
                      cp_cli,
                      ville_cli,
                      adresse_cli
               INTO :WS-IDT-CLI
                    :WS-NOM-CLI,
                    :WS-EML-CLI,
                    :WS-IND-CLI,
                    :WS-TEL-CLI,
                    :WS-CP-CLI,
                    :WS-VIL-CLI,
                    :WS-ADR-CLI
               FROM client
               WHERE id_cli = :WS-IDT-CLI
           END-EXEC

           IF SQLCODE = 0
      * Si le client est trouvé, on copie les valeur 
      * dans la LINKAGE SECTION
               MOVE WS-NOM-CLI   TO LK-NOM-CLI
               MOVE WS-EML-CLI   TO LK-EML-CLI
               MOVE WS-IND-CLI   TO LK-IND-CLI
               MOVE WS-TEL-CLI   TO LK-TEL-CLI
               MOVE WS-CP-CLI    TO LK-CP-CLI
               MOVE WS-VIL-CLI   TO LK-VIL-CLI
               MOVE WS-ADR-CLI   TO LK-ADR-CLI
           END-IF.

       0100-LIR-ID-CLI-FIN.
           EXIT.
