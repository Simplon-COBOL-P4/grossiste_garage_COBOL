      ******************************************************************
      * Programme pour lire une livraison à partir de son identifiant  *
      * et retourner ses infos.                                        *
      *                                                                *
      * TRIGRAMMES                                                     *
      * LIR=LIRE; IDT=IDENTIFIANT; LIV=LIVRAISON; FOU=FOURNISSEUR;     *
      * CLI=CLIENT; TYP=TYPE; STA=STATUT; DAT=DATE; ENC=ENCORE;        *
      * TER=TERMINER; ENT=ENTRER; SOR=SORTIE; DEP=DEPLACER;            *
      * VAR=VARIABLE; GES=GESTION; ERR=ERREUR;                         *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridliv.
       AUTHOR. Yassine.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDT-LIV          PIC 9(10).
       01 PG-DAT-LIV          PIC X(10).
       01 PG-STA-LIV          PIC 9(01).
       01 PG-IDT-SOR          PIC 9(10).
       01 PG-NOM-SOR          PIC X(50).
       01 PG-TYP-LIV          PIC 9(01).
       EXEC SQL END DECLARE SECTION END-EXEC.

       LINKAGE SECTION.
      * Argument d'entrée
       01 LK-IDT-LIV         PIC 9(10).

      * Arguments de sortie
       01 LK-DAT-LIV         PIC X(10).

       01 LK-STA-LIV         PIC 9(01).
           88 LK-STA-ENC VALUE 0.
           88 LK-STA-TER VALUE 1.

       01 LK-TYP-LIV         PIC 9(01).
           88 LK-TYP-ENT VALUE 0.
           88 LK-TYP-SOR VALUE 1.

      * Identifiant et nom fournisseur si entrante,
      * et client si sortante.
       01 LK-IDT-SOR         PIC 9(10).
       01 LK-NOM-SOR         PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

      ******************************************************************
      ******************************************************************
       PROCEDURE DIVISION USING LK-IDT-LIV,
                                LK-DAT-LIV,
                                LK-STA-LIV,
                                LK-TYP-LIV,
                                LK-IDT-SOR,
                                LK-NOM-SOR,
                                LK-LIR-RET.

           PERFORM 0100-LIR-LIV-DEB
              THRU 0100-LIR-LIV-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *********************   LitR une livraison   *********************
      ******************************************************************

       0100-LIR-LIV-DEB.
       0110-DEP-VAR-ENT-DEB.
           MOVE LK-IDT-LIV             TO PG-IDT-LIV.
       0110-DEP-VAR-ENT-FIN.
       0120-SQL-DEB.
           EXEC SQL
               SELECT livraison.date_deb_liv, livraison.statut_liv,
               COALESCE(client.nom_cli, fournisseur.nom_fou) AS nom_sor,
               COALESCE(client.id_cli, fournisseur.id_fou) AS id_sor,
               CASE 
                   WHEN client.id_cli IS NOT NULL THEN 1
                   WHEN fournisseur.id_fou IS NOT NULL THEN 0
               END AS type_liv
               INTO :PG-DAT-LIV,
                    :PG-STA-LIV,
                    :PG-NOM-SOR,
                    :PG-IDT-SOR,
                    :PG-TYP-LIV
               FROM livraison
               LEFT JOIN client
                         ON livraison.id_cli = client.id_cli
               LEFT JOIN fournisseur
                         ON livraison.id_fou = fournisseur.id_fou
               WHERE livraison.id_liv = :PG-IDT-LIV
           END-EXEC.
       0120-SQL-FIN.
       0130-GES-ERR-DEB.
           IF SQLCODE = 0
               MOVE PG-DAT-LIV         TO LK-DAT-LIV
               MOVE PG-STA-LIV         TO LK-STA-LIV
               MOVE PG-NOM-SOR         TO LK-NOM-SOR
               MOVE PG-IDT-SOR         TO LK-IDT-SOR
               MOVE PG-TYP-LIV         TO LK-TYP-LIV
               SET LK-LIR-RET-OK       TO TRUE
           ELSE
               SET LK-LIR-RET-ERR      TO TRUE
           END-IF.
       0130-GES-ERR-FIN.
       0100-LIR-LIV-FIN.