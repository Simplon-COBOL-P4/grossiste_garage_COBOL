      ******************************************************************
      * Ce programme sert à connecter un utilisateur à l'application.
      * L'utilisateur doit entrer son numéro d'identification et son mot
      * de passe via un écran de saisie puis taper sur la touche ENTREE.
      * Seules 3 tentative de connexion sont autorisées.
      *
      * Trigrammes:
      *  ADM = Admin
      *  APL = Application
      *  CDR = Cadre
      *  COD = Code
      *  CON = Connexion
      *  DEP = Deplacer
      *  DTL = Detail
      *  ECR = Ecran
      *  EFC = Efface
      *  ENC = En cours
      *  ERR = Erreur
      *  FND = Fond
      *  GBL = Global
      *  ID  = Identifiant
      *  LG  = Log
      *  MDP = Mot De Passe
      *  NBR = Nombre
      *  NOM = nom
      *  RET = Retour
      *  RLE = Role
      *  RST = Reste
      *  SSI = Saisie
      *  STT = Statut
      *  STD = Standard
      *  SUC = Succes
      *  TXT = Test
      *  TYP = Type
      *  UTL = Utilisateur
      *  VER = Vers
      *
      * WS-NOM-UTL > nom de l'utilisateur
      * WS-MDP-UTL > mot de passe de l'utilisateur 
      * WS-NBR-CON > nombre de connexions tentative
      * WS-NBR-RST > nombre de tentative restant
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. conapl.
       AUTHOR. Benoit.
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
       01  WS-RLE-UTL           PIC X(14).

       01  WS-CHX               PIC X(01) VALUE SPACE.
           88 WS-CHX-VID                  VALUE " ".

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       COPY utiglb.

       SCREEN SECTION.
       COPY ecrprn.

       01  ECR-SSI-01.
           05  LINE 7  COL 34  PIC X(13) VALUE 'Identifiant :'.

           05  LINE 9  COL 29  PIC X(01) VALUE "[".
           05  LINE 9  COL 50  PIC X(01) VALUE "]".

           05  LINE 11 COL 33  PIC X(13) VALUE 'Mot de passe :'.

           05  LINE 13 COL 29  PIC X(01) VALUE "[".
           05  LINE 13 COL 50  PIC X(01) VALUE "]".

           05  LINE 23.
               10 COL 62 VALUE "Retour au menu".
               10 COL 77 VALUE "[".
               10 COL 78 USING PIC X(01) WS-CHX.
               10 COL 79 VALUE "]".
           
           05  LINE 9  COL 30  PIC X(20) TO WS-NOM-UTL AUTO.
           05  LINE 13 COL 30  PIC X(20) TO WS-MDP-UTL SECURE AUTO
               FOREGROUND-COLOR WS-COL-TXT
               BACKGROUND-COLOR WS-COL-FND.

       01  ECR-SSI-02.
           05 LINE 22 COL 10 
               VALUE "Identifiant et/ou mot de passe incorrecte".

      ******************************************************************
      *
      ******************************************************************
       PROCEDURE DIVISION.

           PERFORM 0100-CON-DEB
              THRU 0100-CON-FIN.

           EXIT PROGRAM.

       0100-CON-DEB.
           DISPLAY S-FND-ECR
           MOVE SPACE TO WS-CHX.
           SET WS-ETT-BCL-ENC TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN

               ACCEPT ECR-SSI-01
               
               EVALUATE TRUE 
                   WHEN WS-CHX-VID
                       PERFORM 0150-LGQ-PRN-DEB
                          THRU 0150-LGQ-PRN-FIN

                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE

               END-EVALUATE

           END-PERFORM.

       0100-CON-FIN.
           DISPLAY S-FND-ECR.
      
           CALL "liruti"
               USING
               WS-NOM-UTL
               WS-MDP-UTL
               WS-ROL-UTL
               WS-ID-UTL
               WS-LIR-RET
           END-CALL.

           IF WS-LIR-RET-ERR THEN
               DISPLAY 'Identifiant et/ou mot de passe incorrecte'
                   AT LINE 22 COL 10

               PERFORM 0300-DTL-LOG-ERR-DEB
                  THRU 0300-DTL-LOG-ERR-FIN

               MOVE "CON_ERR" TO WS-TYP-LG
               MOVE 0 TO WS-ID-UTL
           ELSE
               PERFORM 0200-DEP-VER-GBL-DEB
                  THRU 0200-DEP-VER-GBL-FIN
               
               PERFORM 0400-DTL-LOG-SUC-DEB
                  THRU 0400-DTL-LOG-SUC-FIN

               MOVE "CON_SUC" TO WS-TYP-LG
           END-IF.

           CALL "ajulog"
               USING
               WS-DTL-LG
               WS-TYP-LG
               WS-ID-UTL
               WS-AJU-RET
           END-CALL.
       0150-LGQ-PRN-DEB.

       0150-LGQ-PRN-FIN.
      
       0200-DEP-VER-GBL-DEB.
           MOVE WS-NOM-UTL TO G-UTI-NOM.
           MOVE WS-ID-UTL TO G-UTI-ID.
           MOVE WS-RLE-UTL TO G-UTI-RLE.
       0200-DEP-VER-GBL-FIN.

       0300-DTL-LOG-ERR-DEB.
           MOVE SPACE TO WS-DTL-LG

           STRING
               FUNCTION TRIM(WS-NOM-UTL) SPACE
               WS-NBR-RST " restants."
               DELIMITED BY SIZE 
               INTO WS-DTL-LG 
           END-STRING.
       0300-DTL-LOG-ERR-FIN.

       0400-DTL-LOG-SUC-DEB.
           MOVE SPACE TO WS-DTL-LG

           STRING
               FUNCTION TRIM(WS-NOM-UTL)
               " connecte."
               DELIMITED BY SIZE 
               INTO WS-DTL-LG 
           END-STRING.
       0400-DTL-LOG-SUC-FIN.
