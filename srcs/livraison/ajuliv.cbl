      ******************************************************************
      *                             ENTÊTE                             *
      *  Programme qui ajoute une livraison à la BDD.                  *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AJU=AJOUT; LIV=LIVRAISON; STA=statut; DAT=date; TYP=type;      *
      * IDN=identifiant; INI=initialisation; VAR=variable;             *
      * DTL=détail; LG=log; UTI=UTILISATEUR; ENT=entrante;             *
      * SOR=sortante; CRS=cours                                        * 
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajuliv.
       AUTHOR. lucas.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-DAT-DEB                    PIC X(10).
       01 PG-DAT-FIN                    PIC X(10).
       01 PG-STA                        PIC 9(01).
       01 PG-IDN                        PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * variable pour créer le log
       01 WS-DTL-LG                     PIC X(100).
       01 WS-TYP-LG                     PIC X(12).
       01 WS-UTI-ID                     PIC 9(10) VALUE 1.


       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-DAT-DEB              PIC X(10).
       01 LK-DAT-FIN              PIC X(10).
       01 LK-STA                  PIC 9(01).
           88 LK-STA-EN-CRS                 VALUE 0.
           88 LK-STA-FIN                    VALUE 1.
       01 LK-TYP                  PIC 9(01).
           88 LK-TYP-ENT                    VALUE 0.
           88 LK-TYP-SOR                    VALUE 1.
      * Identifiant fournisseur si entrante, et client si sortante.
       01 LK-IDN                  PIC 9(10).
      * Arguments de sortie.
       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.


       PROCEDURE DIVISION USING LK-DAT-DEB,
                                LK-DAT-FIN, 
                                LK-STA,
                                LK-TYP,
                                LK-IDN,
                                LK-AJU-RET.


           PERFORM 0100-INI-VAR-DEB
              THRU 0100-INI-VAR-FIN.

           PERFORM 0200-SQL-DEB
              THRU 0200-SQL-FIN.

           EXIT PROGRAM.

       0100-INI-VAR-DEB.
      * on met les valeurs de la linkage dans la working.
           MOVE LK-DAT-DEB        TO PG-DAT-DEB.
           MOVE LK-DAT-FIN        TO PG-DAT-FIN.
           MOVE LK-STA            TO PG-STA.
           MOVE LK-IDN            TO PG-IDN.
       0100-INI-VAR-FIN.

       0200-SQL-DEB.

      * Si on a l'identificant du client.
           IF LK-TYP-SOR
               EXEC SQL
               INSERT INTO livraison(date_deb_liv, date_fin_liv, 
               statut_liv, id_cli)
               VALUES(:PG-DAT-DEB, :PG-DAT-FIN, 
               :PG-STA, :PG-IDN)
               END-EXEC

      * Si on a l'identificant du fournisseur.
           ELSE 
               EXEC SQL
               INSERT INTO livraison(date_deb_liv, date_fin_liv, 
               statut_liv, id_fou)
               VALUES(:PG-DAT-DEB, :PG-DAT-FIN, 
               :PG-STA, :PG-IDN)
               END-EXEC

           END-IF.

           IF SQLCODE = 0
      * On rajoute, pour le log, si l'ajout dans la bdd est un succès 
      * ou non.     
               EXEC SQL COMMIT WORK END-EXEC
               PERFORM 0300-LG-DEB
                  THRU 0300-LG-FIN
               SET LK-AJU-RET-OK TO TRUE
           ELSE 
               EXEC SQL ROLLBACK WORK END-EXEC
               SET LK-AJU-RET-ERR TO TRUE
           END-IF.
       0200-SQL-FIN.

       0300-LG-DEB.
           MOVE "ajout d'une livraison" TO WS-DTL-LG.
           MOVE "utilisateur" TO WS-TYP-LG.
           CALL "ajulog" USING WS-DTL-LG,
                               WS-TYP-LG,
                               WS-UTI-ID
                               LK-AJU-RET
           END-CALL.
       0300-LG-FIN.
