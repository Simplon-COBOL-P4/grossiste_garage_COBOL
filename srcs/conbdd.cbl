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
      * COR=correct                                                    *
      ******************************************************************       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. conbdd.
       AUTHOR. lucas.
       DATE-WRITTEN. 25-06-2025 (fr).


       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-UTILISATEUR       PIC X(30) VALUE "postgres".
       01  PG-MDP               PIC X(30) VALUE "mdp".
      * Le nom de la base de donnée sera peut-être à changer.
       01  PG-BDD               PIC X(10) VALUE "exobibli".
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.

      * Il est à 0 si la connexion à la base de donnée se passe bien,
      * sinon il est à 1.
       01 LK-COR PIC 9(01).

       PROCEDURE DIVISION USING LK-COR.


           PERFORM 0100-DEB-CONNEXION-BASE-DONNEE
              THRU 0100-FIN-CONNEXION-BASE-DONNEE.
       

           EXIT PROGRAM.

       0100-DEB-CONNEXION-BASE-DONNEE.
           EXEC SQL
                CONNECT :PG-UTILISATEUR IDENTIFIED BY :PG-MDP 
                USING :PG-BDD
           END-EXEC.
           
           IF SQLCODE NOT = 0
      * La connexion à la base de donnée échoue
               MOVE 1 TO LK-COR
           ELSE
      * La connexion à la base de donnée réussi
               MOVE 0 TO LK-COR
           END-IF.

      
       0100-FIN-CONNEXION-BASE-DONNEE.

           
