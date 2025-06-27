      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme permettant récupérer les clients en BDD avec    *
      * le nombre d'entrée et la page voulu                            *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * lir=Lire,pg=page ,adr=adresse; vil=ville, dec=declaration,     *
      * cpc=code postal client, tel=telephone, mai=mail, ind=indicatif,*
      * pag=page, nbe=nombre d'entree, idx=index, cli=client           *
      ******************************************************************    
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpgcli.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 27-06-2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       
      *Déclaration des variables correspondants aux attributs de la 
      *table client ainsi que de la limit et l'offset  
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.       
       01  PG-ID                PIC 9(10).
       01  PG-NOM               PIC X(30).
       01  PG-ADR               PIC X(100).
       01  PG-VIL               PIC X(30).
       01  PG-CPC               PIC 9(05).
       01  PG-TEL               PIC 9(10).
       01  PG-MAI               PIC X(100).
       01  PG-IND               PIC 9(03).
       01  PG-PAG               PIC 9(02).
       01  PG-NBE               PIC 9(02).
       EXEC SQL END DECLARE SECTION END-EXEC.

      * Déclaration d'un index
       77  WS-IDX               PIC 9(02).

      * Déclaration d'une variable d'erreur
       77  WS-ERR               PIC S9(9) COMP-5. 

      * Inclusion des codes d'erreur SQLCA.
       EXEC SQL INCLUDE SQLCA END-EXEC.
       
      * Déclaration des variables du sous-programme. 
       LINKAGE SECTION.
       
       01  LK-TAB-CLI.
           05  LK-CLI           OCCURS 25 TIMES.
                  10  LK-ID     PIC 9(10).
                  10  LK-NOM    PIC X(30).
                  10  LK-ADR    PIC X(100).
                  10  LK-VIL    PIC X(30).
                  10  LK-CPC    PIC 9(05).
                  10  LK-TEL    PIC 9(10).
                  10  LK-MAI    PIC X(100).
                  10  LK-IND    PIC 9(03).

       77  LK-PAG               PIC 9(02).
       77  LK-NBE               PIC 9(02).

       PROCEDURE DIVISION USING LK-NBE LK-PAG LK-TAB-CLI.
           
      * Initialisation des variables.
           PERFORM 0100-INI-VAR-DEB
           THRU    0100-INI-VAR-FIN.

      * Déclaration du curseur.
           PERFORM 0200-DEC-CUR-DEB
           THRU    0200-DEC-CUR-FIN.  

      * Ouverture du curseur.
           PERFORM 0300-OUV-CUR-DEB
           THRU    0300-OUV-CUR-FIN.             

      * Affectation des données en bdd avec celle du sous programme 
      * précédent.
           PERFORM 0400-FET-CLI-DEB
           THRU    0400-FET-CLI-FIN.     

      * Fermeture du curseur.     
           PERFORM 0500-FER-CUR-DEB
           THRU    0500-FER-CUR-FIN.     

           EXIT PROGRAM.  

      ******************************************************************

       0100-INI-VAR-DEB.
           COMPUTE PG-PAG EQUAL LK-PAG * LK-NBE.
           MOVE LK-NBE TO PG-NBE.
           MOVE 0 TO WS-IDX.
       0100-INI-VAR-FIN.                   

       0200-DEC-CUR-DEB.
           EXEC SQL 
                  DECLARE CUR_CLI CURSOR FOR
                  SELECT id_cli, nom_cli, adresse_cli, ville_cli,
                         cp_cli, tel_cli, mail_cli, indic_cli
                  FROM client
                  LIMIT :PG-NBE
                  OFFSET :PG-PAG      
           END-EXEC.
       0200-DEC-CUR-FIN.   

       0300-OUV-CUR-DEB.
           EXEC SQL 
                  OPEN CUR_CLI
           END-EXEC.
           IF SQLCODE NOT = 0
                  MOVE SQLCODE TO WS-ERR
           END-IF.
       0300-OUV-CUR-FIN.   

       0400-FET-CLI-DEB.
           PERFORM UNTIL SQLCODE NOT = 0 OR WS-IDX > LK-NBE    

                  EXEC SQL 
                         FETCH CUR_CLI INTO :PG-ID, :PG-NOM, :PG-ADR,
                                :PG-VIL, :PG-CPC, :PG-TEL, :PG-MAI,
                                :PG-IND
                  END-EXEC

                  IF SQLCODE = 0
                         ADD 1 TO WS-IDX
                         MOVE PG-ID  TO LK-ID(WS-IDX)
                         MOVE PG-NOM TO LK-NOM(WS-IDX)
                         MOVE PG-ADR TO LK-ADR(WS-IDX)
                         MOVE PG-VIL TO LK-VIL(WS-IDX)
                         MOVE PG-CPC TO LK-CPC(WS-IDX)
                         MOVE PG-TEL TO LK-TEL(WS-IDX)
                         MOVE PG-MAI TO LK-MAI(WS-IDX)
                         MOVE PG-IND TO LK-IND(WS-IDX)
                  ELSE IF SQLCODE = 100
                         MOVE SQLCODE TO WS-ERR
                  ELSE 
                         MOVE SQLCODE TO WS-ERR
                  END-IF
           END-PERFORM.

           MOVE WS-IDX TO LK-NBE.
       0400-FET-CLI-FIN.  

       0500-FER-CUR-DEB.
           EXEC SQL 
                  CLOSE CUR_CLI
           END-EXEC.

           IF SQLCODE NOT = 0
                  MOVE SQLCODE TO WS-ERR
           END-IF.
       0500-FER-CUR-FIN. 

