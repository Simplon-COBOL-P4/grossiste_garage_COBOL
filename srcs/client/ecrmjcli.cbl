      ******************************************************************
      * Ce programme permet à l'admin de modifier les informations     *
      * d’un client dan la base de donnée.                             *
      *                                                                *
      * TRIGRAMMES:                                                    *
      * ECR=ECRAN; MAJ=MISE A JOUR; CLI=CLIENT; ADM=ADMIN;             *
      * IND=INDICATIF; TEL=TELEPHONE; EML=EMAIL; VIL=VILLE;            *
      * ADR=ADRESSE; CP=CODEPOSTAL; CHX=CHOIX; IDT=IDANTIFIANT;        *
      * AFG=AFFICHAGE.                                                 *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjcli.
       AUTHOR. Yassine.
       DATE-WRITTEN. 04-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-IDT-CLI            PIC 9(10).
       01 WS-NOM-CLI            PIC X(50).
       01 WS-EML-CLI            PIC X(50).
       01 WS-IND-CLI            PIC 9(03).
       01 WS-TEL-CLI            PIC 9(10).
       01 WS-CP-CLI             PIC 9(05).
       01 WS-VIL-CLI            PIC X(50).
       01 WS-ADR-CLI            PIC X(50).

       01 WS-CHX-ADM            PIC X(01).

       SCREEN SECTION.
       COPY ecrprn.

       01 S-ECR-CLI.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : Admin".
           05 LINE 06 COLUMN 24 VALUE "ID du client : ".
           05 LINE 06 COLUMN 40 PIC Z(10) TO WS-IDT-CLI.
           05 LINE 06 COLUMN 39 VALUE "[".
           05 LINE 06 COLUMN 50 VALUE "]".

           05 LINE 08 COLUMN 03 VALUE "Nom : ".
           05 LINE 09 COLUMN 04 PIC X(50) TO WS-NOM-CLI.
           05 LINE 09 COLUMN 03 VALUE "[".
           05 LINE 09 COLUMN 54 VALUE "]".

           05 LINE 10 COLUMN 03 VALUE "Email : ".
           05 LINE 11  COLUMN 04 PIC X(50) TO WS-EML-CLI.
           05 LINE 11 COLUMN 03 VALUE "[".
           05 LINE 11 COLUMN 54 VALUE "]".

           05 LINE 12 COLUMN 03 VALUE "Indicatif / Telephone : ".
           05 LINE 13 COLUMN 05 PIC Z(03) TO WS-IND-CLI.
           05 COLUMN 09 PIC Z(10) TO WS-TEL-CLI AUTO.
           05 LINE 13 COLUMN 03 VALUE "[+".
           05 LINE 13 COLUMN 19 VALUE "]".

           05 LINE 14 COLUMN 03 VALUE "Adresse : ".
           05 LINE 15 COLUMN 04 PIC X(50) TO WS-ADR-CLI.
           05 LINE 15 COLUMN 03 VALUE "[".
           05 LINE 15 COLUMN 54 VALUE "]".

           05 LINE 16 COLUMN 03 VALUE "Ville : ".
           05 LINE 17 COLUMN 04 PIC X(50) TO WS-VIL-CLI.
           05 LINE 17 COLUMN 03 VALUE "[".
           05 LINE 17 COLUMN 54 VALUE "]".

           05 LINE 18 COLUMN 03 VALUE "Code postal : ".
           05 LINE 19 COLUMN 04 PIC Z(05) TO WS-CP-CLI.
           05 LINE 19 COLUMN 03 VALUE "[".
           05 LINE 19 COLUMN 09 VALUE "]".

           05 LINE 20 COLUMN 30 VALUE "Confirmer modifications ?".
           05 LINE 22 COLUMN 30 VALUE "1 - Oui  0 - Annuler ".
           05 LINE 23 COLUMN 41 PIC X(01) TO WS-CHX-ADM.
           05 LINE 23 COLUMN 40 VALUE "[".
           05 LINE 23 COLUMN 42 VALUE "]".

           

      * Écran pour afficher les infos de client récupérées avant 
      * modification.
       01 S-ECR-AFG.
           05 LINE 09 COLUMN 04 PIC X(50) USING WS-NOM-CLI.
           05 LINE 11 COLUMN 04 PIC X(50) USING WS-EML-CLI.
           05 LINE 13 COLUMN 05 PIC 9(03) USING WS-IND-CLI.
           05 LINE 13 COLUMN 09 PIC 9(10) USING WS-TEL-CLI.
           05 LINE 15 COLUMN 04 PIC X(50) USING WS-ADR-CLI.
           05 LINE 17 COLUMN 04 PIC X(50) USING WS-VIL-CLI.
           05 LINE 19 COLUMN 04 PIC 9(05) USING WS-CP-CLI.
           05 LINE 23 COLUMN 41 PIC X(01) USING WS-CHX-ADM.

     

      ******************************************************************
       PROCEDURE DIVISION.
           PERFORM 0100-MAJ-CLI-DEB
              THRU 0100-MAJ-CLI-FIN.
           EXIT PROGRAM.

      ******************************************************************
      *               Lecture et modification du client                *
      ******************************************************************
       0100-MAJ-CLI-DEB.
      * On affiche l'écran pour saisir un id de client.
           DISPLAY S-FND-ECR
           DISPLAY S-ECR-CLI
           ACCEPT  S-ECR-CLI

           CALL "liridcli" USING WS-IDT-CLI,
                                 WS-NOM-CLI,
                                 WS-EML-CLI,
                                 WS-IND-CLI,
                                 WS-TEL-CLI,
                                 WS-CP-CLI,
                                 WS-VIL-CLI,
                                 WS-ADR-CLI
           END-CALL.                      
                                

           PERFORM UNTIL WS-CHX-ADM = "1" OR WS-CHX-ADM = "0"

      * Si le client existe on affiche ses info en on peux les modifier.     
              DISPLAY S-ECR-AFG
              ACCEPT  S-ECR-AFG
      
      * Si l'admin tape "1" on appelle le programme (majcli) pour
      * modifier.
              IF WS-CHX-ADM = "1"
                 CALL "majcli" USING WS-IDT-CLI,
                                     WS-NOM-CLI,
                                     WS-EML-CLI,
                                     WS-IND-CLI,
                                     WS-TEL-CLI,
                                     WS-CP-CLI,
                                     WS-VIL-CLI,
                                     WS-ADR-CLI
                 END-CALL                  
                                     
               END-IF
           END-PERFORM.                        

       0100-MAJ-CLI-FIN.

