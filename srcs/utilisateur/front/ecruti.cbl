      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme permettant de créer un utilisateur en entrant   *
      * toutes les informations nécessaires à l'aide de la SCREEN      *
      * SECTION. Le programme appellera le sous-programme creuti afin  *
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
       PROGRAM-ID. ecruti.
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
       01 WS-CRG               PIC X(01)   VALUE "[".
       01 WS-CRD               PIC X(01)   VALUE "]".
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



       SCREEN SECTION.

       COPY ecrprn.

       01 S-ECR-CRE-UTI 
           FOREGROUND-COLOR WS-CLR-TXT    
           BACKGROUND-COLOR WS-CLR-FND.
           05 LINE 07 COL 03 VALUE "Nom :".
           05 LINE 07 COL 30 PIC X(01) FROM WS-CRG.
           05 LINE 07 COL 31 PIC X(30) TO   WS-IDF-UTI.
           05 LINE 07 COL 61 PIC X(01) FROM WS-CRD.

           05 LINE 09 COL 03 VALUE "Mot de passe :".
           05 LINE 09 COL 30 PIC X(01) FROM WS-CRG.
           05 LINE 09 COL 31 PIC X(30) TO   WS-MDP-UTI.
           05 LINE 09 COL 61 PIC X(01) FROM WS-CRD.
           
           05 LINE 11 COL 03 VALUE "Confirmer mot de passe :".
           05 LINE 11 COL 30 PIC X(01) FROM WS-CRG.
           05 LINE 11 COL 31 PIC X(30) TO   WS-MDP-UTI-CFM.
           05 LINE 11 COL 61 PIC X(01) FROM WS-CRD.
           
           05 LINE 13 COL 03 VALUE "Role :".
           05 LINE 13 COL 30 PIC X(01) FROM WS-CRG.
           05 LINE 13 COL 31 PIC X(14) TO   WS-ROL-UTI.
           05 LINE 13 COL 45 PIC X(01) FROM WS-CRD.

           05 LINE 17 COL 20 VALUE "1 - Creer un utilisateur".
           05 LINE 17 COL 47 VALUE "2 - Annuler".

           05 LINE 19 COL 33 PIC X(01) FROM WS-CRG.
           05 LINE 19 COL 34 PIC X(01) TO   WS-CHX.
           05 LINE 19 COL 35 PIC X(01) FROM WS-CRD.


       PROCEDURE DIVISION.

           PERFORM 0090-BCL-PCP-DEB
              THRU 0090-BCL-PCP-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

      * Affichage de l'écran de création d'utilisateur.
      * Tant que le mot de passe n'est pas confirmé ou que 
      * l'utilisateur ne choisit pas l'une des 2 options proposées, on
      * reste dans la boucle et l'utilisateur peut à nouveau saisir 
      * ses données.
       0090-BCL-PCP-DEB.
           SET WS-FIN-BCL-NON TO TRUE.

           PERFORM UNTIL WS-FIN-BCL-OUI
               PERFORM 0100-AFF-ECR-UTI-DEB
                  THRU 0100-AFF-ECR-UTI-FIN

           END-PERFORM.

       0090-BCL-PCP-FIN.

       0100-AFF-ECR-UTI-DEB.

      * Saisie des informations de l'utilisateur sur l'écran affiché.

           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-CRE-UTI.
           ACCEPT  S-ECR-CRE-UTI.

           PERFORM 0150-EVA-CHX-UTI-DEB
              THRU 0150-EVA-CHX-UTI-FIN.

           EXIT.
           
       0100-AFF-ECR-UTI-FIN.
      *-----------------------------------------------------------------

      * Evaluation du choix de l'utilisateur.     
       
       0150-EVA-CHX-UTI-DEB.

           EVALUATE WS-CHX

               WHEN 1
                   PERFORM 0155-CFM-MDP-UTI-DEB
                      THRU 0155-CFM-MDP-UTI-FIN
                   
               WHEN 2

      * L'utilisateur quitte le programme.

                   EXIT PROGRAM

               WHEN OTHER 

      * Affichage d'un message d'erreur.  

                   PERFORM 0157-MSG-ERR-CHX-DEB
                      THRU 0157-MSG-ERR-CHX-FIN
                   

           END-EVALUATE.
           EXIT.

       0150-EVA-CHX-UTI-FIN.
      *-----------------------------------------------------------------

      * Confirmation ou non du mot de passe entré.         
       0155-CFM-MDP-UTI-DEB.

      * Si le mot de passe est confirmé alors on affiche un message
      * de réussite de la création d'utilisateur, sinon un message
      * d'échec.

           IF WS-MDP-UTI-CFM = WS-MDP-UTI
               DISPLAY "Utilisateur cree avec succes !"
               AT LINE 22 COL 03

               PERFORM 0156-APP-ENT-DEB
                  THRU 0156-APP-ENT-FIN
                
               
               PERFORM 0200-APL-PRG-DEB
                  THRU 0200-APL-PRG-FIN

               SET WS-FIN-BCL-OUI TO TRUE  

           ELSE 
               DISPLAY "Echec lors de la creation de l'utilisateur"
               AT LINE 22 COL 03  
               
               PERFORM 0156-APP-ENT-DEB
                  THRU 0156-APP-ENT-FIN
               
           END-IF.
           EXIT.
           
       0155-CFM-MDP-UTI-FIN.
       
      *-----------------------------------------------------------------
      
      * Demande à l'utilisateur d'appuyer sur entrée pour passer à la 
      * suite.

       0156-APP-ENT-DEB.
           DISPLAY "Appuyez sur entree"
           AT LINE 23 COL 03. 

           ACCEPT WS-LRR 
           AT LINE 23 COL 21.

           EXIT.
       0156-APP-ENT-FIN.

      *----------------------------------------------------------------- 

      * Message d'erreur si l'utilisateur ne rentre pas les options 
      * proposées. 
       0157-MSG-ERR-CHX-DEB.
       
           DISPLAY "Erreur de saisie, veuillez choisir 1 ou 2"
           AT LINE 22 COL 03. 
       
           PERFORM 0156-APP-ENT-DEB
              THRU 0156-APP-ENT-FIN.
               
           EXIT.

       0157-MSG-ERR-CHX-FIN.

      *----------------------------------------------------------------- 

      * Appel du sous-programme d'insertion des informations dans la 
      * base de données. 
       0200-APL-PRG-DEB.
       
           CALL "creuti" USING WS-IDF-UTI
                               WS-MDP-UTI
                               WS-ROL-UTI
           END-CALL. 

           PERFORM 0250-CDE-ERR-MSG-DEB
              THRU 0250-CDE-ERR-MSG-FIN.

           EXIT.
       0200-APL-PRG-FIN.



      *----------------------------------------------------------------- 
       
      * Simulation d'un code retour d'erreur selon les informations
      * entrées par l'utilisateur. 
       0250-CDE-ERR-MSG-DEB.
           

           SET WS-CDE-RTR-BON TO TRUE. 

           EVALUATE TRUE 

      * Si le code retour indique une réussite de l'insertion dans la 
      * base de données, affiche un message à l'utilisateur à l'écran.

               WHEN WS-CDE-RTR-BON
                   
                   DISPLAY WS-VID 
                   AT LINE 22 COL 03

                   DISPLAY "Utilisateur enregistre"
                   AT LINE 22 COL 03
                   
                   PERFORM 0156-APP-ENT-DEB
                      THRU 0156-APP-ENT-FIN


      * Si le nom d'utilisateur entré existe déjà dans la base de 
      * données, affiche un message à l'utilisateur à l'écran.

               WHEN WS-CDE-RTR-DJA-EXS

                   DISPLAY WS-VID 
                   AT LINE 22 COL 03

                   DISPLAY "Utilisateur deja existant"
                   AT LINE 22 COL 03

                   PERFORM 0156-APP-ENT-DEB
                      THRU 0156-APP-ENT-FIN


      * S'il y a une erreur d'insertion dans la base de données autre 
      * que le nom d'utilisateur déjà existant, affiche un message à 
      * l'utilisateur à l'écran. 

               WHEN WS-CDE-RTR-ERR

                   DISPLAY WS-VID 
                   AT LINE 22 COL 03

                   DISPLAY "Erreur, utilisateur non enregistre"
                   AT LINE 22 COL 03

                   PERFORM 0156-APP-ENT-DEB
                      THRU 0156-APP-ENT-FIN

           END-EVALUATE.
           EXIT.
       0250-CDE-ERR-MSG-FIN.




