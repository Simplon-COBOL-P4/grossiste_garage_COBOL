      ******************************************************************
      * Programme pour lire une livraison à partir de son identifiant  *
      * et retourner ses infos.                                        *
      *                                                                *
      * TRIGRAMMES                                                     *
      * LIR=LIRE; IDT=IDENTIFIANT; LIV=LIVRAISON; FOU=FOURNISSEUR;     *
      * CLI=CLIENT; TYP=TYPE; STA=STATUT; DAT=DATE; ENC=ENCORE;        *
      * TER=TERMINER; ENT=ENTRER; SOR=SORTIE.                          *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridliv.
       AUTHOR. Yassine.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-IDT-LIV          PIC 9(10).
       01 PG-IDT-FOU          PIC 9(10).
       01 PG-IDT-CLI          PIC 9(10).
       01 PG-NOM-FOU          PIC X(50).
       01 PG-NOM-CLI          PIC X(50).
       01 PG-DAT-LIV          PIC X(10).
       01 PG-STA-LIV          PIC 9(01).
       01 PG-TYP-LIV          PIC 9(01).
       EXEC SQL END DECLARE SECTION END-EXEC.

       01 WS-NULL             PIC X.

       LINKAGE SECTION.
      * Argument d'entrée
       01 LK-IDT-LIV         PIC 9(10).

      * Arguments de sortie
       01 LK-DAT-LIV         PIC X(10).

       01 LK-STA-LIV         PIC 9(01).
           88 LK-STA-ENC VALUE 0.
           88 LK-STA-TER VALUE 1.

       01 LK-TYP-LIV         PIC 9(01).
           88 LK-TYP-ENT VALUE 0.
           88 LK-TYP-SOR VALUE 1.

      * Identifiant et nom fournisseur si entrante,
      * et client si sortante.
       01 LK-IDT-SOR         PIC 9(10).
       01 LK-NOM-SOR         PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

      ******************************************************************
      ******************************************************************
       PROCEDURE DIVISION USING LK-IDT-LIV,
                                LK-DAT-LIV,
                                LK-STA-LIV,
                                LK-TYP-LIV,
                                LK-IDT-SOR,
                                LK-NOM-SOR,
                                LK-LIR-RET.

           PERFORM 0100-LIR-LIV-DEB
              THRU 0100-LIR-LIV-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *********************   LitR une livraison   *********************
      ******************************************************************
       0100-LIR-LIV-DEB.
      * On copie l'argument d'entrée vers la variable PG-IDT-LIV pour
      * la requête SQL.
           MOVE LK-IDT-LIV             TO PG-IDT-LIV.

           EXEC SQL
               SELECT id_liv,
                      date_deb_liv,
                      statut_liv,
                      id_fou,
                      id_cli
               INTO :PG-IDT-LIV,
                    :PG-DAT-LIV,
                    :PG-STA-LIV,
                    :PG-IDT-FOU,
                    :PG-IDT-CLI
               FROM livraison
               WHERE id_liv = :PG-IDT-LIV
           END-EXEC.

      * On vérifie si la livraison a été trouvée.
           IF SQLCODE = 0
               MOVE PG-IDT-LIV          TO LK-IDT-LIV
               MOVE PG-DAT-LIV          TO LK-DAT-LIV
               SET LK-LIR-RET-OK        TO TRUE

      * On détermine le statut si est en cours ou terminé.
               IF PG-STA-LIV = 0
                   SET LK-STA-ENC        TO TRUE
               ELSE
                   SET LK-STA-TER        TO TRUE  
               END-IF

      * Vérifier si c'est une livraison entrante avec l'id de 
      * fournisseur et client.
               IF PG-IDT-FOU > 0 AND PG-IDT-CLI = 0
                   MOVE PG-IDT-FOU       TO LK-IDT-SOR
                   SET LK-TYP-ENT        TO TRUE

      * La requête SQL pour lire le nom du fournisseur.
                   EXEC SQL
                       SELECT nom_fou INTO :PG-NOM-FOU
                       FROM fournisseur
                       WHERE id_fou = :PG-IDT-FOU
                   END-EXEC
       
                   IF SQLCODE = 0
                       MOVE PG-NOM-FOU    TO LK-NOM-SOR
                       SET LK-LIR-RET-OK  TO TRUE
                   ELSE
                       SET LK-LIR-RET-ERR TO TRUE
                   END-IF
      
               ELSE
                   IF PG-IDT-CLI > 0 AND PG-IDT-FOU = 0
                       MOVE PG-IDT-CLI       TO LK-IDT-SOR
                       SET LK-TYP-SOR        TO TRUE
                   
      * La requête SQL pour lire le nom du Client.
                       EXEC SQL
                           SELECT nom_cli INTO :PG-NOM-CLI
                           FROM client
                           WHERE id_cli = :PG-IDT-CLI
                       END-EXEC
              
                       IF SQLCODE = 0
                          MOVE PG-NOM-CLI    TO LK-NOM-SOR
                          SET LK-LIR-RET-OK  TO TRUE
                       ELSE
                          SET LK-LIR-RET-ERR TO TRUE
                       END-IF
                   END-IF 
      
               END-IF

           ELSE
               SET LK-LIR-RET-ERR       TO TRUE
           END-IF.

       0100-LIR-LIV-FIN.
