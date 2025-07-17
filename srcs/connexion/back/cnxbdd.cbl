      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * conbase est un sous programme qui se connecte à la base de     *
      * donnée, puis retourne un code erreur au programme appelant.    *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * MDP=mot de passe; BDD=base de donnée; CON=connexion;           *
      * BSE=base; DON=donnée; STT=statut; ERR=erreur                   *
      ******************************************************************       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. cnxbdd.
       AUTHOR. lucas.
       DATE-WRITTEN. 25-06-2025 (fr).


       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-UTILISATEUR       PIC X(30) VALUE "postgres".
       01  PG-MDP               PIC X(30) VALUE "mdp".
      * Le nom de la base de donnée sera peut-être à changer.
       01  PG-BDD               PIC X(10) VALUE "logiparts".
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.

      * Il est à 0 si la connexion à la base de donnée se passe bien,
      * sinon il est à 1.
       01 LK-STT                PIC 9(01).
           88 LK-STT-OK                   VALUE 1.
           88 LK-STT-ERR                  VALUE 2.

       PROCEDURE DIVISION USING LK-STT.

           PERFORM 0100-CON-BSE-DON-DEB
              THRU 0100-CON-BSE-DON-FIN.

           EXIT PROGRAM.

       0100-CON-BSE-DON-DEB.
           EXEC SQL
                CONNECT :PG-UTILISATEUR IDENTIFIED BY :PG-MDP 
                USING :PG-BDD
           END-EXEC.
           
           IF SQLCODE EQUAL 0
               SET LK-STT-OK TO TRUE
           ELSE
               SET LK-STT-ERR TO TRUE
           END-IF.
      
       0100-CON-BSE-DON-FIN.

           
