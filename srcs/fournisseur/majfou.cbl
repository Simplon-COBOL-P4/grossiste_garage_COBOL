      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Le programme met un fournisseur dans la base de donnée, on     *
      * reçoit tous les paramètres nécessaires pour la mise à jour dans*
      * la base de donnée.                                             *
      *                           TRIGRAMMES                           *
      *                                                                *
      * MAJ = mise à jour; FOU=fournisseur; ID=identifiant;            *
      * EMA=email; INF=indicatif; CP=code postal; VI=ville;            *
      * INI=initialisation; VAR=variable; ADR=adresse; TEL=telephone;  * 
      * DET=detail.                                                    *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. majfou.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 07-07-2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-ID                   PIC 9(10).
       01  PG-NOM                  PIC X(50).
       01  PG-EMA                  PIC X(50).
       01  PG-INF                  PIC 9(03).
       01  PG-TEL                  PIC 9(10).
       01  PG-CP                   PIC 9(05).
       01  PG-VI                   PIC X(50).
       01  PG-ADR                  PIC X(50).

       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       77  WS-LOG-DET              PIC X(100). 

       LINKAGE SECTION.
      * Arguments d'entrée.
       01  LK-ID                   PIC 9(10).
       01  LK-NOM                  PIC X(50).
       01  LK-ADR                  PIC X(50).
       01  LK-VI                   PIC X(50).
       01  LK-CP                   PIC 9(05).
       01  LK-INF                  PIC 9(03).
       01  LK-TEL                  PIC 9(10).
       01  LK-EMA                  PIC X(50).
       01  LK-UTI-ID               PIC 9(10).

      * Arguments de sortie.

       COPY majret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-ID,
                                LK-NOM,
                                LK-ADR,
                                LK-VI,
                                LK-CP,
                                LK-INF,
                                LK-TEL,
                                LK-EMA,
                                LK-UTI-ID,
                                LK-MAJ-RET.

           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.
          
           EXIT PROGRAM.

       0100-INI-VAR-DEB.
      * On commence par mettre les éléments de la linkage dans la 
      * working-storage.

           MOVE LK-ID  TO PG-ID.
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
               UPDATE fournisseur 
               SET nom_fou  = :PG-NOM,
               adresse_fou  = :PG-ADR,
               ville_fou    = :PG-VI,
               cp_fou       = :PG-CP,
               tel_fou      = :PG-TEL, 
               mail_fou     = :PG-EMA,
               indic_fou    = :PG-INF
               WHERE id_fou = :PG-ID
           END-EXEC.

           IF SQLCODE = 0
      * L'utilisateur est modifié avec succès.
               EXEC SQL COMMIT END-EXEC
               STRING "["
                      LK-ID
                      "] Mise a jour"
                      INTO WS-LOG-DET
               END-STRING
               CALL "crelog"
                     USING 
                     WS-LOG-DET
                     "Fournisseur"
                     LK-UTI-ID
               END-CALL      
           ELSE
      * L'utilisateur n'est pas dans la table ou la table n'existe pas.
               EXEC SQL ROLLBACK END-EXEC
           END-IF.
           
       0200-SQL-FIN.

