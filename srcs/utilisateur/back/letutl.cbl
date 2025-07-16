      *** TRIGRAMMES:
      * MOT DE PASSE=MDP; ROLE=RLE; UTILISATEUR=UTL; LECTURE=LET; 
      * DEPLACE=DEP; VARIABLE=VAR; RETOURNE=RET; DONNEES=DON;
      * IDENTIFIANT=ID;
       
      *** FONCTION DU PROGRAMME:
      * IL RETOURNE TOUTES LES DONNÉES DE L'UTILISATEUR DANS LA
      * TABLE SQL 'utilisateur'.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. letutl.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 24-06-2025 (fr)

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NOM-UTL      PIC X(20).
       01 PG-MDP-UTL      PIC X(20).
       01 PG-RLE-UTL      PIC X(14).
       01 PG-ID-UTL       PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       01 LK-NOM-UTL      PIC X(20).
       01 LK-MDP-UTL      PIC X(20).
       01 LK-RLE-UTL      PIC X(14).
       01 LK-ID-UTL       PIC 9(10).
      

       PROCEDURE DIVISION USING LK-NOM-UTL,
                                LK-MDP-UTL,
                                LK-RLE-UTL,
                                LK-ID-UTL.

      * RETOURNE LES DONNEES.
           PERFORM 0100-RET-DON-DEB
              THRU 0100-RET-DON-FIN.

      * DEPLACE LES VARIABLES.
           PERFORM 0200-DEP-LES-VAR-DEB
              THRU 0200-DEP-LES-VAR-FIN.
         
           EXIT PROGRAM.


      ******************************************************************
      ***************************PARAGRAPHES****************************  
     
       0100-RET-DON-DEB.
           MOVE LK-NOM-UTL TO PG-NOM-UTL.
           MOVE LK-MDP-UTL TO PG-MDP-UTL.
       EXEC SQL
           SELECT id_uti, nom_uti, mdp_uti, role_uti
      * 2 variables poubelles qui servent uniquement pour pouvoir faire
      * la requête SQL.
           INTO :PG-ID-UTL, :PG-NOM-UTL , :PG-MDP-UTL, :PG-RLE-UTL
           FROM utilisateur
           WHERE nom_uti = :PG-NOM-UTL
           and mdp_uti = encode(digest(:PG-MDP-UTL, 'sha256'), 
           'hex')
       END-EXEC.
       EXEC SQL COMMIT WORK END-EXEC.
       0100-RET-DON-FIN.

       0200-DEP-LES-VAR-DEB.
           MOVE PG-ID-UTL    TO LK-ID-UTL.
           MOVE PG-NOM-UTL   TO LK-NOM-UTL.
           MOVE PG-MDP-UTL   TO LK-MDP-UTL.
           MOVE PG-RLE-UTL   TO LK-RLE-UTL.
       0200-DEP-LES-VAR-FIN.

    