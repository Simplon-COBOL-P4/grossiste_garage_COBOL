      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * accesUTL vérifie si un utilisateur est dans la base de donnée  *
      * via son nom et son mot de passe. Vous êtes déjà connectée à la *
      * base de donnée via le main ou un autre sous-programme.         *
      *                           TRIGRAMMES                           *
      *                                                                *
      * MDP=mot de passe; UTL=utilisateur; DEB= début; poub = poubelle *
      *                                                                *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. accesutl.
       AUTHOR. lucas.
       DATE-WRITTEN. 25-06-2025 (fr).


       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       EXEC SQL INCLUDE SQLCA END-EXEC.

       01 WS-NOM    PIC X(80).
       01 WS-MDP    PIC X(64).

      * Les variables servant à faire la requête SQL.
       01 WS-poub1  PIC X(80).
       01 WS-poub2  PIC X(64).

       LINKAGE SECTION.

      * Le nom et le mot de passe du client.
       01 LK-NOM  PIC X(80).
       01 LK-MDP  PIC X(64).

       01 LK-CORRECT PIC 9(01).

       PROCEDURE DIVISION using LK-NOM LK-MDP LK-CORRECT.

           PERFORM 0100-DEB-INITIALISATION-VARIABLE
           THRU 0100-FIN-INITIALISATION-VARIABLE.

           PERFORM 0200-DEB-SQL
           THRU 0200-FIN-SQL.


       0100-DEB-INITIALISATION-VARIABLE.
      * On ne peux pas utiliser les variables de la LINKAGE SECTION
      * dans une requête SQL donc on les met dans la 
      * WORKING-STORAGE SECTION.
           MOVE LK-NOM TO WS-NOM.
           MOVE LK-MDP TO WS-MDP.
       0100-FIN-INITIALISATION-VARIABLE.

       0200-DEB-SQL.

           EXEC SQL
           SELECT nom_uti, mdp_uti
      * 2 variables poubelles qui servent uniquement pour pouvoir faire
      * la requête SQL.
           INTO :WS-poub1, :WS-poub2 
           FROM utilisateur
           WHERE nom_uti = :WS-NOM
      * Le trim du mot de passe est nécessaire mais pourrait poser
      * des problèmes si le mot de passe se termine par un espace.
           and mdp_uti = encode(digest(trim(:WS-MDP), 'sha256'), 
           'hex')
               
           END-EXEC.

           IF SQLCODE = 0
      * L'utilisateur est dans la table.
               MOVE 0 TO LK-CORRECT 
           ELSE
      * L'utilisateur n'est pas dans la table ou la table n'existe pas.
               MOVE 1 TO LK-CORRECT
           END-IF.
               
           EXEC SQL COMMIT END-EXEC.

       0200-FIN-SQL.

           end program accesutl.