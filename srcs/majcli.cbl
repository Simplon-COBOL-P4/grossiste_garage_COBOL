      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Le programme met un client dans la base de donnée, on reçoit   *
      * tous les paramètres nécessaires pour la mise à jour dans la    *
      * base de donnée.                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * MAJ = mise à jour; CLI=client; IDN=identifiant; TEL=telephone; *
      * EMA=email; INF=indicatif; CP=code postal; VI=ville;            *
      * INI=initialisation; VAR=variable; ADR=adresse.                 *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. majcli.
       AUTHOR. lucas.
       DATE-WRITTEN. 4-07-25 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDN                PIC 9(10).
       01 PG-NOM                PIC X(50).
       01 PG-EMA                PIC X(50).
       01 PG-INF                PIC 9(03).
       01 PG-TEL                PIC 9(10).
       01 PG-CP                 PIC 9(05).
       01 PG-VI                 PIC X(50).
       01 PG-ADR                PIC X(50).

       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-IDN                PIC 9(10).
       01 LK-NOM                PIC X(50).
       01 LK-EMA                PIC X(50).
       01 LK-INF                PIC 9(03).
       01 LK-TEL                PIC 9(10).
       01 LK-CP                 PIC 9(05).
       01 LK-VI                 PIC X(50).
       01 LK-ADR                PIC X(50).

       PROCEDURE DIVISION USING LK-IDN,
                                LK-NOM,
                                LK-EMA,
                                LK-INF,
                                LK-TEL,
                                LK-CP,
                                LK-VI,
                                LK-ADR.

           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.
          
           EXIT PROGRAM.

       0100-INI-VAR-DEB.
      * On commence par mettre les éléments de la linkage dans la 
      * working-storage.

           MOVE LK-IDN TO PG-IDN.
           MOVE LK-NOM TO PG-NOM.
           MOVE LK-EMA TO PG-EMA.
           MOVE LK-INF TO PG-INF.
           MOVE LK-TEL TO PG-TEL.
           MOVE LK-CP  TO PG-CP.
           MOVE LK-VI  TO PG-VI.
           MOVE LK-ADR TO PG-ADR.

       0100-INI-VAR-FIN.

       0200-SQL-DEB.
           EXEC SQL
               UPDATE client 
               SET nom_cli  = :PG-NOM,
               adresse_cli  = :PG-ADR,
               ville_cli    = :PG-VI,
               cp_cli       = :PG-CP,
               tel_cli      = :PG-TEL, 
               mail_cli     = :PG-EMA,
               indic_cli    = :PG-INF
               WHERE id_cli = :PG-IDN
           END-EXEC.

           IF SQLCODE = 0
      * L'utilisateur est modifié avec succès.
               EXEC SQL COMMIT END-EXEC
           ELSE
      * L'utilisateur n'est pas dans la table ou la table n'existe pas.
               EXEC SQL ROLLBACK END-EXEC
           END-IF.
           
       0200-SQL-FIN.
