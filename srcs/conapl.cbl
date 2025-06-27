      ******************************************************************
      * Ce programme sert à connecter un utilisateur à l'application.
      * L'utilisateur doit entrer son numéro d'identification et son mot
      * de passe via un écran de saisie puis taper sur la touche ENTREE.
      * Seules 3 tentative de connexion sont autorisées.
      *
      * Trigram:
      *  APL = Application
      *  CDR = Cadre
      *  COD = Code
      *  CON = Connexion
      *  ECR = Ecran
      *  EFC = Efface
      *  FND = Fond
      *  MDP = Mot De Passe
      *  NBR = Nombre
      *  NOM = nom
      *  RET = Retour
      *  RST = Reste
      *  SSI = Saisie
      *  TXT = Test
      *  UTL = Utilisateur

      * WS-NOM-UTL > nom de l'utilisateur
      * WS-MDP-UTL > mot de passe de l'utilisateur 
      * LK-COD-RET > code retour, 0=OK, 1=KO
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
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

      ******************************************************************
      *
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77  WS-COL-TXT           PIC 9(01) VALUE 7.  *> Blanc
       77  WS-COL-FND           PIC 9(01) VALUE 1.  *> Bleu

       77  WS-NBR-CON           PIC 9(02).
       77  WS-NBR-RST           PIC 9(02).

       77  S-NOM-UTL            PIC 9(20).
       77  S-MDP-UTL            PIC X(20).

       77  S-CDR-001            PIC X(01) VALUE '+'.
       77  S-CDR-002            PIC X(78) VALUE ALL '-'.
       77  S-CDR-003            PIC X(01) VALUE '|'.
       77  S-CDR-004            PIC X(05) VALUE 'HIMYC'.

       77  S-CDR-005            PIC X(13) VALUE 'Identifiant :'.

       77  S-CDR-006            PIC X(01) VALUE '['.
       77  S-CDR-007            PIC X(01) VALUE ']'.

       77  S-CDR-008           PIC X(14) VALUE 'Mot de passe :'.

       LINKAGE SECTION.
       77  LK-COD-RET           PIC 9(01).

       SCREEN SECTION.
       01  ECR-SSI-01.
           05  LINE 1  COL 1   PIC X(01) FROM S-CDR-001.
           05  LINE 1  COL 2   PIC X(78) FROM S-CDR-002.
           05  LINE 1  COL 80  PIC X(01) FROM S-CDR-001.
           05  LINE 2  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 2  COL 36  PIC X(37) FROM S-CDR-004.
           05  LINE 2  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 3  COL 1   PIC X(01) FROM S-CDR-001.
           05  LINE 3  COL 2   PIC X(78) FROM S-CDR-002.
           05  LINE 3  COL 80  PIC X(01) FROM S-CDR-001.
           05  LINE 4  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 4  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 5  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 5  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 6  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 6  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 7  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 7  COL 34  PIC X(13) FROM S-CDR-005.
           05  LINE 7  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 8  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 8  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 9  COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 9  COL 29  PIC X(01) FROM S-CDR-006.
           05  LINE 9  COL 50  PIC X(34) FROM S-CDR-007.
           05  LINE 9  COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 10 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 10 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 11 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 11 COL 34  PIC X(14) FROM S-CDR-008.
           05  LINE 11 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 12 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 12 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 13 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 13 COL 29  PIC X(01) FROM S-CDR-006.
           05  LINE 13 COL 50  PIC X(34) FROM S-CDR-007.
           05  LINE 13 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 14 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 14 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 15 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 15 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 16 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 16 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 17 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 17 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 18 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 18 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 19 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 19 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 20 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 20 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 21 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 21 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 22 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 22 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 23 COL 1   PIC X(01) FROM S-CDR-003.
           05  LINE 23 COL 80  PIC X(01) FROM S-CDR-003.
           05  LINE 24 COL 1   PIC X(01) FROM S-CDR-001.
           05  LINE 24 COL 2   PIC X(78) FROM S-CDR-002.
           05  LINE 24 COL 80  PIC X(01) FROM S-CDR-001.
           05  LINE 9  COL 30  PIC X(20) TO S-NOM-UTL AUTO.
           05  LINE 13 COL 30  PIC X(20) TO S-MDP-UTL SECURE AUTO
               FOREGROUND-COLOR WS-COL-TXT
               BACKGROUND-COLOR WS-COL-FND.

       01  ECR-SSI-02.
           05 LINE 22 COL 10   VALUE "Identifiant et/ou mot de passe 
      -                                                   " incorrecte".
           05 LINE 23 COL 10   VALUE "Nombre de tentative restant: ".
           05 LINE 23 COL 39   PIC X(01) FROM WS-NBR-RST.

       01  ECR-EFC.
           05 BLANK SCREEN.
      ******************************************************************
      *
      ******************************************************************
       PROCEDURE DIVISION USING LK-COD-RET.

           PERFORM 0100-CON-DEB THRU 0100-CON-FIN.

           EXIT PROGRAM.

       0100-CON-DEB.
           DISPLAY ECR-EFC.
           MOVE 1 TO LK-COD-RET.
           DISPLAY 'Nombre de tentative restant: 03' AT LINE 23 COL 10
           PERFORM VARYING WS-NBR-CON FROM 1 BY 1 UNTIL WS-NBR-CON > 3 
                   OR LK-COD-RET = 0
             DISPLAY ECR-SSI-01
             ACCEPT ECR-SSI-01
      * Appel sous-progrmme
             CALL 'subprog' USING LK-COD-RET
             IF LK-COD-RET <> 0 THEN
                DISPLAY 'Identifiant et/ou mot de passe incorrecte' AT
                                                          LINE 22 COL 10
                DISPLAY 'Nombre de tentative restant: ' AT LINE 23 COL
                                                                      10
                COMPUTE WS-NBR-RST = 3 - WS-NBR-CON
                DISPLAY WS-NBR-RST AT LINE 23 COL 39
             END-IF
           END-PERFORM.

       0100-CON-FIN.
       EXIT.
      
           

