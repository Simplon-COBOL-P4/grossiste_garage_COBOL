      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme permettant de créer un utilisateur en entrant   *
      * toutes les informations nécessaires à l'aide de la SCREEN      *
      * SECTION. Le programme appellera le sous-programme ajuuti afin  *
      * d'insérer les informations dans la base de données.            *
      *                                                                *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * UTI=UTILISATEUR; MDP=MOT DE PASSE; ROL=ROLE; ECR=ECRAN;        *
      * CRE=CREATION; LRR=LEURRE; CLR=COULEUR; CDE=CODE; RTR=RETOUR;   *
      * DJA=DEJA; EXS=EXISTANT; TXT=TEXTE; FND=FOND; PLS=PLUS;         *
      * TRT=TIRET; BAR=BARRE; CRG=CROCHET GAUCHE; CRD=CROCHET DROIT;   *
      * CHX=CHOIX; CFM=CONFIRMATION; AFF=AFFICHAGE; DEB=DEBUT;         *
      * MSG=MESSAGE; ERR=ERREUR; BCL=BOUCLE; APL=APPEL; PRG=PROGRAMME  *
      * VID=VIDE; APP=APPUI; ENT=ENTREE; PCP=PRINCIPALE.               *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajuti.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 25-06-2025 (fr).
       
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Simulation d'un code retour pour l'insertion des informations
      * de l'utilisateur dans la base de donnée.

       01 WS-CDE-RTR           PIC 9(01).
           88 WS-CDE-RTR-BON               VALUE 0.
           88 WS-CDE-RTR-DJA-EXS           VALUE 1.
           88 WS-CDE-RTR-ERR               VALUE 2.

      * Déclaration de valeurs d'affichage pour la SCREEN SECTION. 
       01 WS-VID               PIC X(30)   VALUE ALL " ".

      * Booléen de contrôle de fin de boucle. 
       01 WS-FIN-BCL           PIC X(01)   VALUE SPACE.
           88 WS-FIN-BCL-OUI               VALUE "O".
           88 WS-FIN-BCL-NON               VALUE "N".

      * Variables correspondant aux informations entrées par 
      * l'utilisateur. 
       01 WS-IDF-UTI           PIC X(20).
       01 WS-MDP-UTI           PIC X(20).
       01 WS-MDP-UTI-CFM       PIC X(20).
       01 WS-ROL-UTI           PIC X(14).

       01 WS-CHX               PIC X(01).
       01 WS-LRR               PIC X(01).

       
       01 WS-CLR-TXT           PIC 9(01)       VALUE 7. *> Blanc
       01 WS-CLR-FND           PIC 9(01)       VALUE 0. *> Noir

       COPY utiglb.

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       SCREEN SECTION.

       COPY ecrprn.

       01 S-ECR-CRE-UTI 
           FOREGROUND-COLOR WS-CLR-TXT    
           BACKGROUND-COLOR WS-CLR-FND.
           COPY ecrutlin.
           05 LINE 07 COL 03 VALUE "Nom :".
           05 LINE 07 COL 30 PIC X(01) VALUE "[".
           05 LINE 07 COL 31 PIC X(30) TO   WS-IDF-UTI.
           05 LINE 07 COL 61 PIC X(01) VALUE "]".

           05 LINE 09 COL 03 VALUE "Mot de passe :".
           05 LINE 09 COL 30 PIC X(01) VALUE "[".
           05 LINE 09 COL 31 PIC X(30) TO   WS-MDP-UTI.
           05 LINE 09 COL 61 PIC X(01) VALUE "]".
           
           05 LINE 11 COL 03 VALUE "Confirmer mot de passe :".
           05 LINE 11 COL 30 PIC X(01) VALUE "[".
           05 LINE 11 COL 31 PIC X(30) TO   WS-MDP-UTI-CFM.
           05 LINE 11 COL 61 PIC X(01) VALUE "]".
           
           05 LINE 13 COL 03 VALUE "Role :".
           05 LINE 13 COL 30 PIC X(01) VALUE "[".
           05 LINE 13 COL 31 PIC X(14) TO   WS-ROL-UTI.
           05 LINE 13 COL 45 PIC X(01) VALUE "]".

           05 LINE 17 COL 20 VALUE "1 - Creer un utilisateur".
           05 LINE 17 COL 47 VALUE "0 - Annuler".

           05 LINE 19 COL 33 PIC X(01) VALUE "[".
           05 LINE 19 COL 34 PIC X(01) TO   WS-CHX.
           05 LINE 19 COL 35 PIC X(01) VALUE "]".


       PROCEDURE DIVISION.

           PERFORM 0100-BCL-PCP-DEB
              THRU 0100-BCL-PCP-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

      * Affichage de l'écran de création d'utilisateur.
      * Tant que le mot de passe n'est pas confirmé ou que 
      * l'utilisateur ne choisit pas l'une des 2 options proposées, on
      * reste dans la boucle et l'utilisateur peut à nouveau saisir 
      * ses données.
       0100-BCL-PCP-DEB.
           SET WS-FIN-BCL-NON TO TRUE.
           DISPLAY S-FND-ECR.

           PERFORM UNTIL WS-FIN-BCL-OUI

               ACCEPT S-ECR-CRE-UTI

               PERFORM 0150-EVA-CHX-UTI-DEB
                  THRU 0150-EVA-CHX-UTI-FIN

           END-PERFORM.

       0100-BCL-PCP-FIN.

      * Evaluation du choix de l'utilisateur.     
       
       0150-EVA-CHX-UTI-DEB.

           EVALUATE WS-CHX

               WHEN 1
                   
                   PERFORM 0160-CFM-MDP-UTI-DEB
                      THRU 0160-CFM-MDP-UTI-FIN
                   
               WHEN 0

                   SET WS-FIN-BCL-OUI TO TRUE

               WHEN OTHER 

      * Affichage d'un message d'erreur.  

                   PERFORM 0170-MSG-ERR-CHX-DEB
                      THRU 0170-MSG-ERR-CHX-FIN

           END-EVALUATE.

       0150-EVA-CHX-UTI-FIN.
      *-----------------------------------------------------------------

      * Confirmation ou non du mot de passe entré.         
       0160-CFM-MDP-UTI-DEB.

      * Si le mot de passe est confirmé alors on affiche un message
      * de réussite de la création d'utilisateur, sinon un message
      * d'échec.

           DISPLAY S-FND-ECR.

           IF WS-MDP-UTI-CFM = WS-MDP-UTI
                
               PERFORM 0200-APL-PRG-DEB
                  THRU 0200-APL-PRG-FIN

               PERFORM 0250-CDE-ERR-MSG-DEB
                  THRU 0250-CDE-ERR-MSG-FIN

           ELSE 

               DISPLAY "Les mots de passe ne correspondent pas."
               AT LINE 22 COL 03  
               
           END-IF.
           
       0160-CFM-MDP-UTI-FIN.

      *----------------------------------------------------------------- 

      * Message d'erreur si l'utilisateur ne rentre pas les options 
      * proposées. 
       0170-MSG-ERR-CHX-DEB.
       
           DISPLAY S-FND-ECR.

           DISPLAY "Erreur de saisie, veuillez choisir 1 ou 0"
           AT LINE 22 COL 03. 

       0170-MSG-ERR-CHX-FIN.

      *----------------------------------------------------------------- 

      * Appel du sous-programme d'insertion des informations dans la 
      * base de données. 
       0200-APL-PRG-DEB.
       
           CALL "ajuuti" 
                USING 
                WS-IDF-UTI
                WS-MDP-UTI
                WS-ROL-UTI
                WS-AJU-RET
           END-CALL.

       0200-APL-PRG-FIN.

      *----------------------------------------------------------------- 
       
      * Simulation d'un code retour d'erreur selon les informations
      * entrées par l'utilisateur. 
       0250-CDE-ERR-MSG-DEB.
           
           EVALUATE TRUE 

      * Si le code retour indique une réussite de l'insertion dans la 
      * base de données, affiche un message à l'utilisateur à l'écran.

               WHEN WS-AJU-RET-OK
                   
                   DISPLAY WS-VID 
                   AT LINE 22 COL 03

                   DISPLAY "Utilisateur enregistre"
                   AT LINE 22 COL 03

      * Si le nom d'utilisateur entré existe déjà dans la base de 
      * données, affiche un message à l'utilisateur à l'écran.
      * TEMPORAIREMENT NON UTILISE, COPYBOOK AJURET A FAIRE EVOLUER

               WHEN FALSE

                   DISPLAY WS-VID 
                   AT LINE 22 COL 03

                   DISPLAY "Utilisateur deja existant"
                   AT LINE 22 COL 03

      * S'il y a une erreur d'insertion dans la base de données autre 
      * que le nom d'utilisateur déjà existant, affiche un message à 
      * l'utilisateur à l'écran. 

               WHEN WS-AJU-RET-ERR

                   DISPLAY WS-VID 
                   AT LINE 22 COL 03

                   DISPLAY "Erreur, utilisateur non enregistre"
                   AT LINE 22 COL 03

           END-EVALUATE.
       0250-CDE-ERR-MSG-FIN.
