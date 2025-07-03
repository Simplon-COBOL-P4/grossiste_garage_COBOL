      ******************************************************************
      * Le programme Lie un client dans la base de donnée par son nom  *
      * et envoye les informations dans la LINKAGE SECTION.            *
      *                                                                *
      * Trigrammes :                                                   *
      * ADR=ADRESSE; CP=CODE POSTAL; EML=MAIL; IDT=IDENTIFIANT;        *
      * IND=INDICATIF; LIR=LIRE; CLI=CLIENT; TEL=TELEPHONE;            *
      * VIL=VILLE.                                                     *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirnocli.
       AUTHOR. Yassine.
       DATE-WRITTEN. 02-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Variables temporaires pour stocker les infos.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDT-CLI     PIC 9(09).
       01 PG-NOM-CLI     PIC X(50).
       01 PG-EML-CLI     PIC X(50).
       01 PG-IND-CLI     PIC 9(03).
       01 PG-TEL-CLI     PIC 9(10).
       01 PG-CP-CLI      PIC 9(05).
       01 PG-VIL-CLI     PIC X(50).
       01 PG-ADR-CLI     PIC X(50).
       EXEC SQL END DECLARE SECTION END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-NOM-CLI     PIC X(50).

      * Arguments de sortie.
       01 LK-IDT-CLI     PIC 9(09).
       01 LK-EML-CLI     PIC X(50).
       01 LK-IND-CLI     PIC 9(03).
       01 LK-TEL-CLI     PIC 9(10).
       01 LK-CP-CLI      PIC 9(05).
       01 LK-VIL-CLI     PIC X(50).
       01 LK-ADR-CLI     PIC X(50).

       PROCEDURE DIVISION USING LK-IDT-CLI,
                                LK-NOM-CLI,
                                LK-EML-CLI,
                                LK-IND-CLI,
                                LK-TEL-CLI,
                                LK-CP-CLI,
                                LK-VIL-CLI,
                                LK-ADR-CLI.
                                

      ******************************************************************
      *                     Programme principal
      ******************************************************************
           PERFORM 0100-LIR-NOM-CLI-DEB
              THRU 0100-LIR-NOM-CLI-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *                  Lire un client par son nom                    *
      ******************************************************************
       0100-LIR-NOM-CLI-DEB.
    
      * on copie le nom reçu dans WS-NOM-RECH.
           MOVE LK-NOM-CLI TO PG-NOM-CLI

           EXEC SQL
               SELECT id_cli, 
                      nom_cli, 
                      mail_cli, 
                      indic_cli, 
                      tel_cli,
                      cp_cli, 
                      ville_cli, 
                      adresse_cli
               INTO :PG-IDT-CLI, 
                    :PG-NOM-CLI, 
                    :PG-EML-CLI, 
                    :PG-IND-CLI,
                    :PG-TEL-CLI, 
                    :PG-CP-CLI, 
                    :PG-VIL-CLI, 
                    :PG-ADR-CLI
               FROM client
               WHERE nom_cli = :PG-NOM-CLI
           END-EXEC


           IF SQLCODE = 0
      * Si le client est trouvé on envoye les infos.
               MOVE PG-IDT-CLI  TO LK-IDT-CLI
               MOVE PG-NOM-CLI  TO LK-NOM-CLI
               MOVE PG-EML-CLI  TO LK-EML-CLI
               MOVE PG-IND-CLI  TO LK-IND-CLI
               MOVE PG-TEL-CLI  TO LK-TEL-CLI
               MOVE PG-CP-CLI   TO LK-CP-CLI
               MOVE PG-VIL-CLI  TO LK-VIL-CLI
               MOVE PG-ADR-CLI  TO LK-ADR-CLI
           END-IF.
       0100-LIR-NOM-CLI-FIN.
           EXIT.
