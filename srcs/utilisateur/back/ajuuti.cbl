      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme prenant en entrée les informations fournies pour*
      * la création d'un utilisateur et les insère dans la table       *
      * "utilisateur" de la BDD SQL.                                   *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * ajuuti=Création utilisateur, CRE=création; UTI=utilisateur     *
      * UTI=UTILISATEUR; MDP=MOT DE PASSE; ROL=ROLE;                   *
      * AFC=AFFECTATION; VAR=VARIABLE; DEB=DEBUT; INS=INSERTION        *
      ****************************************************************** 
       
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajuuti.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 24-06-2025 (fr).
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Déclaration des variables correspondant aux attributs
      * (identifiant, mot de passe et role) de la table utilisateur.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.

       01 PG-NOM-UTI         PIC X(20).
       01 PG-MDP-UTI         PIC X(20).
       01 PG-ROL-UTI         PIC X(14).
       
       EXEC SQL END DECLARE SECTION END-EXEC.
       
      * Inclusion des codes d'erreur SQLCA.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Déclaration des variables du sous-programme. 
       LINKAGE SECTION. 
       01 LK-NOM-UTI         PIC X(20).
       01 LK-MDP-UTI         PIC X(20).
       01 LK-ROL-UTI         PIC X(14).

       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-NOM-UTI,
                                LK-MDP-UTI,
                                LK-ROL-UTI,
                                LK-AJU-RET.


      * Affectation des valeurs des variables du programme appelant 
      * dans les variables correspondant aux attributs SQL.

           PERFORM 0100-AFC-VAR-DEB
              THRU 0100-AFC-VAR-FIN.
       
      * Insertion des variables dans la table Utilisateur 
      * la base de donnée SQL.
           PERFORM 0150-INS-SQL-DEB
              THRU 0150-INS-SQL-FIN.
       
           EXIT PROGRAM.
       
      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

       0100-AFC-VAR-DEB.

           MOVE LK-NOM-UTI     
           TO   PG-NOM-UTI.

           MOVE LK-MDP-UTI    
           TO   PG-MDP-UTI.

           MOVE LK-ROL-UTI   
           TO   PG-ROL-UTI.
       
       0100-AFC-VAR-FIN.

      *-----------------------------------------------------------------

       0150-INS-SQL-DEB.
                   
           EXEC SQL 
               INSERT INTO utilisateur(nom_uti, mdp_uti, role_uti)
               VALUES (
                :PG-NOM-UTI, 
                encode(digest(:PG-MDP-UTI,'sha256'),'hex'),
                :PG-ROL-UTI)
           END-EXEC 
               
           IF SQLCODE = 0
               EXEC SQL COMMIT END-EXEC 
               SET LK-AJU-RET-OK TO TRUE
           ELSE
               EXEC SQL ROLLBACK END-EXEC
               SET LK-AJU-RET-ERR TO TRUE 
           END-IF.

       0150-INS-SQL-FIN.
