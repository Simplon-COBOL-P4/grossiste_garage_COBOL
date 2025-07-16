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
      *  ecrcxbdd = ecr-ecran  cx-connexion  bdd-base de donnée
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
       PROGRAM-ID. ecrcxbdd.
       AUTHOR.    Benoit.
       DATE-WRITTEN. 25-06-2025 (fr).

      ******************************************************************
      *
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION. 

       77 WS-NUL               PIC X(01).

       LINKAGE SECTION.
       01 LK-STT                PIC 9(01).
           88 LK-STT-OK                   VALUE 1.
           88 LK-STT-ERR                  VALUE 2.
      
       SCREEN SECTION.
       COPY ecrprn.
       
       01 S-ECR-SSI.
           05  LINE 21 COL 3   PIC X(36)
               VALUE  'Demarrage du processus de connexion'. 
           05  LINE 22 COL 3   PIC X(34) 
               VALUE  'Connexion a la base de donnees...'.

      ******************************************************************
      *
      ******************************************************************
       PROCEDURE DIVISION USING LK-STT.

           PERFORM 0100-APL-PRG-DEB
              THRU 0100-APL-PRG-FIN.

           EXIT PROGRAM.

       0100-APL-PRG-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-SSI.

           CALL 'cnxbdd'
               USING
               LK-STT
           END-CALL.

           IF LK-STT-ERR THEN
               DISPLAY 'Connexion echouee.' AT LINE 23 COL 3
           ELSE 
               DISPLAY 'Connexion etablie' AT LINE 23 COL 3
           END-IF.
           ACCEPT WS-NUL AT LINE 23 COL 20.
           
       0100-APL-PRG-FIN.
