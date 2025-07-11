      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Programme qui récupère les fournisseurs par page, et les       *
      * retourne au programme appelant.                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; PG=PAGE; FOU=FOURNISSEUR; TAB=tableau; NB=nombre     *
      * EMA=email; TEL=telephone; IDE=identifiant; ADR=adresse         *
      * CP=code postal; IND=indicatif; VI=ville;                       *
      * ELT=element; AJO=ajout                                         *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpgfou.
       AUTHOR. lucas.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.

       EXEC SQL INCLUDE SQLCA END-EXEC.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NB                   PIC 9(02). *> Min 1 - Max 25.
      * L'offset pour la requête SQL
       01 PG-OFS                   PIC 9(03).
       01 PG-IDE                   PIC 9(10).
       01 PG-NOM                   PIC X(50).
       01 PG-ADR                   PIC X(50).
       01 PG-VI                    PIC X(50).
       01 PG-CP                    PIC 9(05).
       01 PG-IND                   PIC 9(03).
       01 PG-TEL                   PIC 9(10).
       01 PG-EMA                   PIC X(50).
       
       EXEC SQL END DECLARE SECTION END-EXEC.
       

      *le nombre d'élément ajouter dans le tableau
       01 WS-ELT-AJO        PIC 9(02) VALUE 0.
       
       
       LINKAGE SECTION.
      * Arguments d'entrée.
       77 LK-PG                            PIC 9(02).
       77 LK-NB                            PIC 9(02).
      * Arguments de sortie.
       01 LK-TAB.
           05 LK-FOU OCCURS 25 TIMES.
               10 LK-IDE                   PIC 9(10).
               10 LK-NOM                   PIC X(50).
               10 LK-ADR                   PIC X(50).
               10 LK-VI                    PIC X(50).
               10 LK-CP                    PIC 9(05).
               10 LK-IND                   PIC 9(03).
               10 LK-TEL                   PIC 9(10).
               10 LK-EMA                   PIC X(50).
           
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-NB,
                                LK-PG,
                                LK-TAB,
                                LK-LIR-RET.


           PERFORM 0100-OFS-DEB
              THRU 0100-OFS-FIN.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.


      

           EXIT PROGRAM.

       0100-OFS-DEB.
      * Récupération de l'offset.
           MULTIPLY LK-PG BY LK-NB GIVING PG-OFS.
           MOVE LK-NB TO PG-NB.
       0100-OFS-FIN.

       0200-SQL-DEB. 
      * Requête sql + déclaration du curseur.
           EXEC SQL
           DECLARE curseur CURSOR FOR 
           SELECT id_fou, nom_fou, adresse_fou, ville_fou, cp_fou,
           tel_fou, mail_fou,
           indic_fou     
           FROM Fournisseur    
           LIMIT :PG-NB
           OFFSET :PG-OFS
           FOR READ ONLY
           END-EXEC.

      * On ouvre le curseur.
           EXEC SQL
               OPEN curseur
           END-EXEC. 
      * Si l'ouverture du curseur se passe mal, on arrête en renvoyant
      * un code d'erreur
           IF SQLCODE NOT EQUAL 0
               SET LK-LIR-RET-ERR TO TRUE 
               EXIT PROGRAM
           END-IF.

      * On lit le curseur tant que le sqlcode n'est pas à 100.
           PERFORM UNTIL SQLCODE = 100 
               EXEC SQL
                   FETCH curseur into 
                   :PG-IDE, 
                   :PG-NOM, 
                   :PG-ADR, 
                   :PG-VI,
                   :PG-CP,
                   :PG-TEL,
                   :PG-EMA,
                   :PG-IND
               END-EXEC

      * On incrémente le nombre d'élément du tableau de 1.
               ADD 1 TO WS-ELT-AJO
      * On met les éléments dans le tableau
               MOVE PG-IDE  TO LK-IDE(WS-ELT-AJO)        
               MOVE PG-NOM  TO LK-NOM(WS-ELT-AJO)                  
               MOVE PG-ADR  TO LK-ADR(WS-ELT-AJO)                  
               MOVE PG-VI   TO LK-VI(WS-ELT-AJO)                  
               MOVE PG-CP   TO LK-CP(WS-ELT-AJO)              
               MOVE PG-IND  TO LK-IND(WS-ELT-AJO)               
               MOVE PG-TEL  TO LK-TEL(WS-ELT-AJO)                 
               MOVE PG-EMA  TO LK-EMA(WS-ELT-AJO)                  
           END-PERFORM.

      * On ferme le curseur.
           EXEC SQL
               CLOSE curseur
           END-EXEC.
           SET LK-LIR-RET-OK TO TRUE. 
       0200-SQL-FIN.
