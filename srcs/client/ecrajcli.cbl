      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * ecrajcli : écran permettant à l’utilisateur de rentrer les     *
      * paramètres nécessaires à la création d’un client.              *
      * Il appelle le sous programme verema et ajucli. Le programme    *
      * verema retourne une valeur d’erreur, il est impératif de la    *
      * traiter et d’afficher les informations sur l'écran.            *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; AJ=AJOUT; CLI=CLIENT; EMA=EMAIL, IND=INDICATIF      *
      * TEL=TELEPHONE; COP=CODE POSTAL; VIL=VILLE; ADR=ADRESSE;        *
      * VLR=VALEUR; RTR=RETOUR; TRO=TROP; ARO=AROBASE; PNT=POINT;      *
      * CRG=CROCHET GAUCHE; CRD=CROCHET DROIT; AFF=AFFICHAGE;          *
      * BCL=BOUCLE; PRN=PRINCIPAL(E); SSI=SAISIE; APL=APPEL;           *
      * VER=VERIFICATION; MSG=MESSAGE; BDD=BASE DE DONNEE;             *
      * APP=APPUI; ENT=ENTREE; NTG=NETTOYAGE; ZON=ZONE; CHX=CHOIX.     *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajcli IS INITIAL.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 01-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Déclaration des variables à saisir par l'utilisateur pour 
      * l'ajout du client.

       01 WS-NOM-CLI                   PIC X(50).
       01 WS-EMA-CLI                   PIC X(50).
       01 WS-IND-CLI                   PIC 9(03).
       01 WS-TEL-CLI                   PIC 9(10).
       01 WS-ADR-CLI                   PIC X(50).
       01 WS-VIL-CLI                   PIC X(50).
       01 WS-COP-CLI                   PIC 9(05).
       
      * Déclaration de la variable de choix pour l'ajout ou non d'un 
      * client.

       01 WS-CHX                    PIC Z(01). 
           88 WS-CHX-OUI       VALUE 1.
           88 WS-CHX-NON       VALUE 2.

      * Booléen de contrôle de fin de boucle sur la validité de l'email
      * saisi par l'utilisateur.

       01 WS-FIN-BCL           PIC X(01).
           88 WS-FIN-BCL-OUI               VALUE "O".
           88 WS-FIN-BCL-NON               VALUE "N".
       
      * Variable pour le code de retour sur la vérification de l'email. 
         
       01 WS-VLR-RTR           PIC 9(01).
           88 WS-RTR-OK                   VALUE 0.
           88 WS-RTR-TRO-DE-ARO           VALUE 1.
           88 WS-RTR-PAS-DE-ARO           VALUE 2.
           88 WS-RTR-PAS-DE-PNT           VALUE 3.

      * Variable d'affichage pour l'écran. 
       01 WS-CRG               PIC X(01) VALUE "[".
       01 WS-CRD               PIC X(01) VALUE "]".
       01 WS-LRR               PIC X(01).
       01 WS-VID               PIC X(40) VALUE ALL " ".
       01 WS-CLR-TXT           PIC 9(01) VALUE 7. *> Blanc
       01 WS-CLR-FND           PIC 9(01) VALUE 0. *> Noir
       
       

       SCREEN SECTION.
      * Ecran de fond. 
       COPY ecrprn.
       
      * Ecran de saisie des informations sur le client à ajouter.  
       01 S-ECR-AJ-CLI
           FOREGROUND-COLOR WS-CLR-TXT    
           BACKGROUND-COLOR WS-CLR-FND.

           05 LINE 04 COL 03 VALUE "Connecte en tant que :".


           05 LINE 08 COL 03 VALUE "Nom :".
           05 LINE 09 COL 03 PIC X(01) FROM WS-CRG.
           05 LINE 09 COL 04 PIC X(50) TO WS-NOM-CLI.

           05 LINE 09 COL 54 PIC X(01) FROM WS-CRD.


           05 LINE 10 COL 03 VALUE "Email :".
           05 LINE 11 COL 03 PIC X(01) FROM WS-CRG.
           05 LINE 11 COL 04 PIC X(50) TO WS-EMA-CLI.

           05 LINE 11 COL 54 PIC X(01) FROM WS-CRD.


           05 LINE 12 COL 03 VALUE "Indicatif / Telephone :".
           05 LINE 13 COL 03 PIC X(01) FROM WS-CRG.
           05 LINE 13 COL 04 VALUE "+".
           05 LINE 13 COL 05 PIC Z(03) TO WS-IND-CLI.
           05 LINE 13 COL 09 PIC Z(10) TO WS-TEL-CLI.
           
           05 LINE 13 COL 19 PIC X(01) FROM WS-CRD.


           05 LINE 14 COL 03 VALUE "Adresse :".
           05 LINE 15 COL 03 PIC X(01) FROM WS-CRG.
           05 LINE 15 COL 04 PIC X(50) TO WS-ADR-CLI.

           05 LINE 15 COL 54 PIC X(01) FROM WS-CRD.

           05 LINE 16 COL 03 VALUE "Ville :".
           05 LINE 17 COL 03 PIC X(01) FROM WS-CRG.
           05 LINE 17 COL 04 PIC X(50) TO WS-VIL-CLI.

           05 LINE 17 COL 54 PIC X(01) FROM WS-CRD.

           
           05 LINE 18 COL 03 VALUE "Code postal :".
           05 LINE 19 COL 03 PIC X(01) FROM WS-CRG.
           05 LINE 19 COL 04 PIC Z(05) TO WS-COP-CLI.

           05 LINE 19 COL 09 PIC X(01) FROM WS-CRD.

           
           05 LINE 20 COL 33 VALUE "Ajouter client ?".
           05 LINE 22 COL 33 VALUE "1 - Oui".
           05 LINE 22 COL 43 VALUE "2 - Non".
           
           05 LINE 23 COL 40 PIC X(01) FROM WS-CRG.
           05 LINE 23 COL 41 PIC Z(01) TO WS-CHX.

           05 LINE 23 COL 42 PIC X(01) FROM WS-CRD.
       

       PROCEDURE DIVISION.

      * Boucle sur l'affichage de l'écran de saisie.

           PERFORM 0100-BCL-PRN-DEB
              THRU 0100-BCL-PRN-FIN.

           
           EXIT PROGRAM.


      ******************************************************************
      *                         PARAGRAPHES                            * 
      ****************************************************************** 
       0100-BCL-PRN-DEB.

      * Initialisation du booléen à "Non" avant d'entamer la boucle. 
           SET WS-FIN-BCL-NON TO TRUE.
       
      * Affichage en boucle de l'écran tant que la condition sur 
      * l'email n'est pas validée.

           PERFORM UNTIL WS-FIN-BCL-OUI
               
               PERFORM 0200-AFF-SSI-ECR-DEB
                  THRU 0200-AFF-SSI-ECR-FIN

           END-PERFORM.
           EXIT.
           
       0100-BCL-PRN-FIN.

      *----------------------------------------------------------------- 

      * Affichage des écrans de fond et de saisie des informations sur 
      * le client à ajouter. 
       0200-AFF-SSI-ECR-DEB.

           DISPLAY S-FND-ECR.
           DISPLAY S-ECR-AJ-CLI.
           ACCEPT S-ECR-AJ-CLI.

      * Choix d'ajouter ou non un client.

           PERFORM 0300-CHX-AJ-CLI-DEB
              THRU 0300-CHX-AJ-CLI-FIN.
           
           EXIT.
       
       0200-AFF-SSI-ECR-FIN.

      *----------------------------------------------------------------- 
       0300-CHX-AJ-CLI-DEB.

      * Si l'utilisateur choisit d'ajouter un client, l'email saisi 
      * est vérifié avant l'ajout.     
           EVALUATE TRUE 
               
               WHEN WS-CHX-OUI
               
                   PERFORM 0400-APL-VER-EMA-DEB
                      THRU 0400-APL-VER-EMA-FIN

      * Sinon aucun client n'est ajouté et le programme se ferme suite 
      * à la fin de la boucle.

               WHEN WS-CHX-NON 
                   DISPLAY WS-VID 
                   AT LINE 22 COL 33
       
                   DISPLAY "Ajout annule" 
                   AT LINE 22 COL 03 
                   SET WS-FIN-BCL-OUI TO TRUE

      * Appel d'un paragraphe invitant l'utilisateur à appuyer sur 
      * une touche pour passer à la suite. 
                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN
       
      * Affichage d'un message invitant l'utilisateur à choisir l'une 
      * des deux options à l'écran si aucune option n'est choisie. 

               WHEN OTHER
                   DISPLAY WS-VID 
                   AT LINE 22 COL 33

                   DISPLAY "Veuillez choisir une option (1 ou 2)"    
                   AT LINE 22 COL 03 

                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN

           END-EVALUATE.  
           EXIT.
       0300-CHX-AJ-CLI-FIN.

      *-----------------------------------------------------------------

      * Appel du sous-programme "verema" pour la vérification de l'email
      * saisi par l'utilisateur. Ce sous-programme renvoie différents
      * codes de retour selon la saisie de l'email. 
        
       0400-APL-VER-EMA-DEB.

           CALL "verema"
               USING
               WS-EMA-CLI 
               WS-VLR-RTR
           END-CALL.

      * Affichage à l'écran du message de retour après vérification de  
      * l'email saisi.   

           PERFORM 0450-MSG-RTR-DEB
              THRU 0450-MSG-RTR-FIN.

           EXIT.
           
       0400-APL-VER-EMA-FIN.

      *----------------------------------------------------------------- 
       
       0450-MSG-RTR-DEB.

      * Branche conditionnelle sur les différents codes de retour lors
      * de la vérification de l'email.

           EVALUATE TRUE 

      * Affichage d'un message d'erreur si trop d'@ ont été saisis par
      * l'utilisateur.

               WHEN WS-RTR-TRO-DE-ARO 

                   DISPLAY "Email invalide: trop d'@"
                   AT LINE 22 COL 03
                   DISPLAY WS-VID 
                   AT LINE 22 COL 33
                   

                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN
                   
      * Affichage d'un message d'erreur si aucun @ n'a été saisi par
      * l'utilisateur.
             
               WHEN WS-RTR-PAS-DE-ARO
                   
                   DISPLAY "Email invalide: @ manquant"
                   AT LINE 22 COL 03
                   DISPLAY WS-VID 
                   AT LINE 22 COL 33

                   
                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN

      * Affichage d'un message d'erreur si aucun point n'a été saisi par
      * l'utilisateur.

               WHEN WS-RTR-PAS-DE-PNT

                   DISPLAY "Email invalide: point manquant"
                   AT LINE 22 COL 03
                   DISPLAY WS-VID 
                   AT LINE 22 COL 33

                   

                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN
                   
      * Affichage d'un message de retour indiquant la validité de
      * l'email saisi.

               WHEN WS-RTR-OK 

                   DISPLAY "Email valide"
                   AT LINE 22 COL 03
                   DISPLAY WS-VID 
                   AT LINE 22 COL 33

                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN

      * Appel du sous-programe d'ajout du client dans la BDD.

                   PERFORM 0500-APL-AJ-CLI-BDD-DEB
                      THRU 0500-APL-AJ-CLI-BDD-FIN

                   DISPLAY WS-VID 
                   AT LINE 22 COL 33

      * Affichage d'un message de confirmation de l'ajout du client.
 
                   DISPLAY "Client ajoute" AT LINE 22 COL 03
                   PERFORM 0455-APP-ENT-DEB
                      THRU 0455-APP-ENT-FIN

      * Fin de boucle et fermeture du programme. 
                   SET WS-FIN-BCL-OUI TO TRUE

             
           END-EVALUATE. 
           EXIT.

       0450-MSG-RTR-FIN.
       
      *----------------------------------------------------------------- 
       0455-APP-ENT-DEB.
           
           DISPLAY "Appuyez sur entree"
           AT LINE 23 COL 03. 

           ACCEPT WS-LRR 
           AT LINE 23 COL 21.

           EXIT.
       0455-APP-ENT-FIN.
      *----------------------------------------------------------------- 

      * Appel du sous-programme "ajucli" permettant d'ajouter les 
      * clients dans la BDD.  
       0500-APL-AJ-CLI-BDD-DEB.

           CALL "ajucli"
                USING
                WS-NOM-CLI
                WS-EMA-CLI
                WS-IND-CLI
                WS-TEL-CLI
                WS-COP-CLI
                WS-VIL-CLI
                WS-ADR-CLI
           END-CALL.
           EXIT.

       0500-APL-AJ-CLI-BDD-FIN.

