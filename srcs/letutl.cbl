      *** TRIGRAMMES:
      * MOT DE PASSE=MDP; ROLE=RLE; UTILISATEUR=UTL; LECTURE=LET; 
      * DEPLACE=DEP; VARIABLE=VAR; RETOURNE=RET; DONNEES=DON
       
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
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
       01 LK-NOM-UTL      PIC X(20).
       01 LK-MDP-UTL      PIC X(20).
       01 LK-RLE-UTL      PIC X(14).
      

       PROCEDURE DIVISION USING LK-NOM-UTL LK-MDP-UTL LK-RLE-UTL.

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
       EXEC SQL 
           SELECT nom_uti, mdp_uti, role_uti 
           INTO :PG-NOM-UTL, :PG-MDP-UTL, :PG-RLE-UTL
           FROM utilisateur
       END-EXEC.
       EXEC SQL COMMIT WORK END-EXEC.
       0100-RET-DON-FIN.

       0200-DEP-LES-VAR-DEB.
           MOVE PG-NOM-UTL   TO LK-NOM-UTL.
           MOVE PG-MDP-UTL   TO LK-MDP-UTL.
           MOVE PG-RLE-UTL   TO LK-RLE-UTL.
       0200-DEP-LES-VAR-FIN.

    