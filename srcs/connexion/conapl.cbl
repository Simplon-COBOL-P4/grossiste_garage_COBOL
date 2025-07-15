      ******************************************************************
      * Ce programme sert à connecter un utilisateur à l'application.
      * L'utilisateur doit entrer son numéro d'identification et son mot
      * de passe via un écran de saisie puis taper sur la touche ENTREE.
      * Seules 3 tentative de connexion sont autorisées.
      *
      * Trigram:
      *  ADM = Admin
      *  APL = Application
      *  CDR = Cadre
      *  COD = Code
      *  CON = Connexion
      *  DTL = Detail
      *  ECR = Ecran
      *  EFC = Efface
      *  ERR = Erreur
      *  FND = Fond
      *  ID  = Identifiant
      *  LG  = Log
      *  MDP = Mot De Passe
      *  NBR = Nombre
      *  NOM = nom
      *  RET = Retour
      *  RST = Reste
      *  SSI = Saisie
      *  STT = Statut
      *  STD = Standard
      *  SUC = Succes
      *  TXT = Test
      *  TYP = Type
      *  UTL = Utilisateur


      * WS-NOM-UTL > nom de l'utilisateur
      * WS-MDP-UTL > mot de passe de l'utilisateur 
      * WS-NBR-CON > nombre de connexions tentative
      * WS-NBR-RST > nombre de tentative restant
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. conapl.
       AUTHOR.    Benoit.
       DATE-WRITTEN. 25-06-2025 (fr).

      ******************************************************************
      *
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77  WS-COL-TXT           PIC 9(01) VALUE 7.  *> Blanc
       77  WS-COL-FND           PIC 9(01) VALUE 1.  *> Bleu

       77  WS-NBR-CON           PIC 9(02).
       77  WS-NBR-RST           PIC 9(02).

       01  WS-DTL-LG            PIC X(100).
       01  WS-TYP-LG            PIC X(12).

       77  WS-NOM-UTL           PIC X(20).
       77  WS-MDP-UTL           PIC X(20).
       01  WS-ID-UTL            PIC 9(10).


       77  WS-CDR-005           PIC X(13) VALUE 'Identifiant :'.

       77  WS-CDR-006           PIC X(01) VALUE '['.
       77  WS-CDR-007           PIC X(01) VALUE ']'.

       77  WS-CDR-008           PIC X(14) VALUE 'Mot de passe :'.

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       LINKAGE SECTION.
       01  LK-COD-RET           PIC 9(01).
           88 LK-STT-ERR                  VALUE 0.
           88 LK-STT-ADM                  VALUE 1.
           88 LK-STT-STD                  VALUE 2.

       SCREEN SECTION.
       COPY ecrprn.

       01  ECR-SSI-01.
           05  LINE 7  COL 34  PIC X(13) FROM WS-CDR-005.
           05  LINE 9  COL 29  PIC X(01) FROM WS-CDR-006.
           05  LINE 9  COL 50  PIC X(01) FROM WS-CDR-007.
           05  LINE 13 COL 29  PIC X(01) FROM WS-CDR-006.
           05  LINE 13 COL 50  PIC X(01) FROM WS-CDR-007.
           05  LINE 9  COL 30  PIC X(20) TO WS-NOM-UTL AUTO.
           05  LINE 13 COL 30  PIC X(20) TO WS-MDP-UTL SECURE AUTO
               FOREGROUND-COLOR WS-COL-TXT
               BACKGROUND-COLOR WS-COL-FND.

       01  ECR-SSI-02.
           05 LINE 22 COL 10   VALUE
                         "Identifiant et/ou mot de passe incorrecte".
           05 LINE 23 COL 10   VALUE "Nombre de tentative restant: ".
           05 LINE 23 COL 39   PIC X(01) FROM WS-NBR-RST.

      ******************************************************************
      *
      ******************************************************************
       PROCEDURE DIVISION USING LK-COD-RET.

           PERFORM 0100-CON-DEB
              THRU 0100-CON-FIN.

           EXIT PROGRAM.

       0100-CON-DEB.
           SET LK-STT-ERR TO TRUE.
           DISPLAY S-FND-ECR
           DISPLAY 'Nombre de tentative restant: 03' AT LINE 23 COL 10
           PERFORM VARYING WS-NBR-CON FROM 1 BY 1 UNTIL WS-NBR-CON > 3 
                   OR NOT LK-STT-ERR
               DISPLAY ECR-SSI-01
               ACCEPT ECR-SSI-01
      * Appel sous-progrmme
               CALL 'accutl' 
                   USING
                   WS-NOM-UTL
                   WS-MDP-UTL
                   WS-ID-UTL
                   LK-COD-RET
               END-CALL
               IF LK-STT-ERR THEN
                   DISPLAY 'Identifiant et/ou mot de passe incorrecte'
                       AT LINE 22 COL 10
                   DISPLAY 'Nombre de tentative restant: ' 
                       AT LINE 23 COL 10

                   COMPUTE WS-NBR-RST = 3 - WS-NBR-CON

                   DISPLAY WS-NBR-RST 
                       AT LINE 23 COL 39

                   MOVE "CON_ERR" TO WS-TYP-LG
                   MOVE SPACE TO WS-DTL-LG
                   STRING
                       FUNCTION TRIM(WS-NOM-UTL) SPACE
                       WS-NBR-RST " restants."
                       DELIMITED BY SIZE 
                       INTO WS-DTL-LG 
                   END-STRING
                   MOVE 0 TO WS-ID-UTL
                   CALL "ajulog"
                       USING
                       WS-DTL-LG
                       WS-TYP-LG
                       WS-ID-UTL
                       WS-AJU-RET
                   END-CALL
               ELSE
                   MOVE "CON_SUC" TO WS-TYP-LG
                   MOVE SPACE TO WS-DTL-LG
                   STRING
                       FUNCTION TRIM(WS-NOM-UTL)
                       " connecte."
                       DELIMITED BY SIZE 
                       INTO WS-DTL-LG 
                   END-STRING
                   CALL "ajulog"
                       USING
                       WS-DTL-LG
                       WS-TYP-LG
                       WS-ID-UTL
                       WS-AJU-RET
                   END-CALL
               END-IF
           END-PERFORM.

       0100-CON-FIN.
       EXIT.
      
           

