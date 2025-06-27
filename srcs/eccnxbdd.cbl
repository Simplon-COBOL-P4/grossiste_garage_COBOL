      ******************************************************************
      *Ce programme appel un sous-programme dont le role est de  
      *connecter un utilisateur à la base de donnée et de transmettre un
      *code retour. Il vérifie ensuite le code retour et affiche un
      *message informatif qui indique si la connexion a réussi ou non,
      *puis transfère le contrôle au programme appelant.
      *
      *Trigram:
      *  APL = Appel
      *  CDR = Cadre
      *  COD = Code
      *  ECR = Ecran
      *  EFC = Efface
      *  PRG = Programme
      *  RET = Retour
      *  SSI = Saisie
      *  eccnxbdd = ec-ecran  cnx-connexion  bdd-base de donnée
      *
      *SCREEN-SECTION:
      *  ECR-SSI  Ecran-Saisie ou Saisie Ecran
      *  ECR-EFC  Ecran-Efface ou Efface Ecran
      *
      *Paragraphe
      *  0100-APL-PRG. Appel sous Programme
      * 
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. eccnxbdd.
       AUTHOR.    Benoit.
       DATE-WRITTEN. 25-06-2025 (fr).

      ******************************************************************
      *
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION. 

       77  WS-CDR-001          PIC X(01) VALUE '+'.
       77  WS-CDR-002          PIC X(78) VALUE ALL '-'.
       77  WS-CDR-003          PIC X(01) VALUE '|'.
       77  WS-CDR-004          PIC X(05) VALUE 'HIMYC'.

       77 WS-NUL               PIC X(01).

       LINKAGE SECTION.
       77  LK-COD-RET          PIC 9(01).
      
       SCREEN SECTION.
       01  ECR-SSI.
           05  LINE 1  COL 1   PIC X(01) FROM WS-CDR-001.
           05  LINE 1  COL 2   PIC X(78) FROM WS-CDR-002.
           05  LINE 1  COL 80  PIC X(01) FROM WS-CDR-001.
           05  LINE 2  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 2  COL 36  PIC X(37) FROM WS-CDR-004.
           05  LINE 2  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 3  COL 1   PIC X(01) FROM WS-CDR-001.
           05  LINE 3  COL 2   PIC X(78) FROM WS-CDR-002.
           05  LINE 3  COL 80  PIC X(01) FROM WS-CDR-001.
           05  LINE 4  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 4  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 5  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 5  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 6  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 6  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 7  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 7  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 8  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 8  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 9  COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 9  COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 10 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 10 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 11 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 11 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 12 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 12 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 13 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 13 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 14 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 14 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 15 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 15 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 16 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 16 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 17 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 17 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 18 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 18 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 19 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 19 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 20 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 20 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 21 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 21 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 22 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 22 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 23 COL 1   PIC X(01) FROM WS-CDR-003.
           05  LINE 23 COL 80  PIC X(01) FROM WS-CDR-003.
           05  LINE 24 COL 1   PIC X(01) FROM WS-CDR-001.
           05  LINE 24 COL 2   PIC X(78) FROM WS-CDR-002.
           05  LINE 24 COL 80  PIC X(01) FROM WS-CDR-001.
           05  LINE 21 COL 3   PIC X(36) VALUE 'Demarrage du processus 
      -                                                  'de connexion'. 
           05  LINE 22 COL 3   PIC X(34) VALUE 'Connexion a la base de 
      -                                                    'donnees...'.

           01 ECR-EFC.
           05 BLANK SCREEN.

      ******************************************************************
      *
      ******************************************************************
       PROCEDURE DIVISION USING LK-COD-RET.
           PERFORM 0100-APL-PRG-DEB THRU 0100-APL-PRG-FIN.

           EXIT PROGRAM.

       0100-APL-PRG-DEB.
           DISPLAY ECR-EFC.
           DISPLAY ECR-SSI.

           CALL 'subprog' USING LK-COD-RET.
           IF LK-COD-RET <> 0 THEN
              DISPLAY 'Connexion echouee.' AT LINE 23 COL 3
              ACCEPT WS-NUL AT LINE 23 COL 20
           ELSE 
              DISPLAY 'Connexion etablie' AT LINE 23 COL 3
              ACCEPT WS-NUL AT LINE 23 COL 20
           END-IF.        
           
       0100-APL-PRG-FIN.
           EXIT.           
