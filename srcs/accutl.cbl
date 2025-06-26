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
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. accutl.
       AUTHOR. lucas.
       DATE-WRITTEN. 25-06-2025 (fr).


       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-NOM     PIC X(80).
       01 WS-MDP     PIC X(64).

      * Les variables servant à faire la requête SQL.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-POU-1   PIC X(80).
       01 PG-POU-2   PIC X(64).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.


       LINKAGE SECTION.

      * Le nom et le mot de passe du client.
       01 LK-NOM     PIC X(80).
       01 LK-MDP     PIC X(64).

       01 LK-COR PIC 9(01).

       PROCEDURE DIVISION using LK-NOM LK-MDP LK-COR.

           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.


           EXIT PROGRAM.

       0100-INI-VAR-DEB.
      * On ne peux pas utiliser les variables de la LINKAGE SECTION
      * dans une requête SQL donc on les met dans la 
      * WORKING-STORAGE SECTION.
           MOVE LK-NOM TO WS-NOM.
           MOVE LK-MDP TO WS-MDP.
       0100-INI-VAR-FIN.

       0200-SQL-DEB.

           EXEC SQL
           SELECT nom_uti, mdp_uti
      * 2 variables poubelles qui servent uniquement pour pouvoir faire
      * la requête SQL.
           INTO :PG-POU-1 , :PG-POU-2 
           FROM utilisateur
           WHERE nom_uti = :WS-NOM
           and mdp_uti = encode(digest(:WS-MDP, 'sha256'), 
           'hex')
               
           END-EXEC.

           IF SQLCODE = 0
      * L'utilisateur est dans la table.
               MOVE 0 TO LK-COR 
           ELSE
      * L'utilisateur n'est pas dans la table ou la table n'existe pas.
               MOVE 1 TO LK-COR
           END-IF.
               
           EXEC SQL COMMIT END-EXEC.

       0200-SQL-FIN.

           