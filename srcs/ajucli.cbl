      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *** TRIGRAMMES:                                                  *
      * AJOUT=AJU; CLIENT=CLI; EMAIL=EML; INDICATIF=IND; TELEPHONE=TEL;*
      * CODE-POSTAL=COP; VILLE=VIL; ADRESSE=ADR;
      *                                                                *
      *** FONCTION DU PROGRAMME:                                       *
      * IL AJOUTE UN CLIENT DANS LA TABLE 'client'.
      ******************************************************************
     
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajucli.
       AUTHOR.Anaisktl.
       DATE-WRITTEN. 26-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NOM-CLI          PIC X(80).
       01 PG-EML-CLI          PIC X(160).
       01 PG-IND-CLI          PIC 9(03).
       01 PG-TEL-CLI          PIC 9(10).
       01 PG-COP-CLI          PIC 9(05).
       01 PG-VIL-CLI          PIC X(80).
       01 PG-ADR-CLI          PIC X(160).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-NOM-CLI           PIC X(80).
       01 LK-EML-CLI           PIC X(160).
       01 LK-IND-CLI           PIC 9(03).
       01 LK-TEL-CLI           PIC 9(10).
       01 LK-COP-CLI           PIC 9(05).
       01 LK-VIL-CLI           PIC X(80).
       01 LK-ADR-CLI           PIC X(160).

       PROCEDURE DIVISION USING LK-NOM-CLI,
                                LK-EML-CLI,
                                LK-IND-CLI,
                                LK-TEL-CLI,
                                LK-COP-CLI,
                                LK-VIL-CLI,
                                LK-ADR-CLI.

      * DEPLACE LES VARIABLES.
           PERFORM 0100-DEP-LES-VAR-DEB
              THRU 0100-DEP-LES-VAR-FIN.

      * AJOUT D'UN CLIENT DANS LA TABLE 'client'.        
           PERFORM 0200-AJU-CLI-DEB
              THRU 0200-AJU-CLI-FIN.

           EXIT PROGRAM.


      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************    

       0100-DEP-LES-VAR-DEB.
           MOVE LK-NOM-CLI    TO PG-NOM-CLI
           MOVE LK-EML-CLI    TO PG-EML-CLI
           MOVE LK-IND-CLI    TO PG-IND-CLI
           MOVE LK-TEL-CLI    TO PG-TEL-CLI
           MOVE LK-COP-CLI    TO PG-COP-CLI
           MOVE LK-VIL-CLI    TO PG-VIL-CLI
           MOVE LK-ADR-CLI    TO PG-ADR-CLI.
       0100-DEP-LES-VAR-FIN.

       0200-AJU-CLI-DEB.  
       EXEC SQL
           INSERT INTO client (nom_cli, adresse_cli, ville_cli,
                                cp_cli, tel_cli, mail_cli, indic_cli)
           VALUES (:PG-NOM-CLI, :PG-ADR-CLI, :PG-VIL-CLI, :PG-COP-CLI,
                   :PG-TEL-CLI, :PG-EML-CLI, :PG-IND-CLI)
       END-EXEC.
       EXEC SQL COMMIT WORK END-EXEC.
       0200-AJU-CLI-FIN.