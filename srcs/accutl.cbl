      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * accesUTL vérifie si un utilisateur est dans la base de donnée  *
      * via son nom et son mot de passe. Vous êtes déjà connectée à la *
      * base de donnée via le main ou un autre sous-programme.         *
      *                           TRIGRAMMES                           *
      *                                                                *
      * MDP=mot de passe; UTL=utilisateur; DEB= début; POU = poubelle; *
      * COR=correct; INI=initialisation; VAR=variable; ACC= accès      *
      * STT=STATUT; ERR=ERREUR; ADM=ADMIN; STD=STANDARD; ROL=ROLE      *
      * ID=IDENTIFIANT;                                                *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. accutl.
       AUTHOR. lucas.
       DATE-WRITTEN. 25-06-2025 (fr).


       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ROL     PIC X(14).

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.

      * Le nom et le mot de passe du client.
       01 LK-NOM     PIC X(20).
       01 LK-MDP     PIC X(20).
       01 LK-ID      PIC 9(10).

       01 LK-COR     PIC 9(01).
           88 LK-STT-ERR       VALUE 0.
           88 LK-STT-ADM       VALUE 1.
           88 LK-STT-STD       VALUE 2.

       PROCEDURE DIVISION USING LK-NOM,
                                LK-MDP,
                                LK-ID,
                                LK-COR.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.


           EXIT PROGRAM.

       0200-SQL-DEB.
           CALL "letutl"
               USING
               LK-NOM
               LK-MDP
               WS-ROL
               LK-ID
           END-CALL.

           IF SQLCODE = 0 THEN
      * L'utilisateur est dans la table.
               EVALUATE WS-ROL
                   WHEN "ADMIN"
                       SET LK-STT-ADM TO TRUE
                   WHEN "STANDARD"
                       SET LK-STT-STD TO TRUE
                   WHEN OTHER
                       SET LK-STT-ERR TO TRUE
               END-EVALUATE
           ELSE
      * L'utilisateur n'est pas dans la table ou la table n'existe pas.
               SET LK-STT-ERR TO TRUE
           END-IF.
       0200-SQL-FIN.

           