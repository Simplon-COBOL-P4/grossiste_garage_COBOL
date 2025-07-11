      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Créer le sous programme ecrmjliv qui contient une SCREEN       *
      * SECTION. Cet écran permet à l’utilisateur de rentrer l’id      *
      * d’une livraison, afin de mettre à jour son statut à “terminé”. *
      * Il ne sert à rien de mettre à jour une livraison déjà terminée,*
      * il est donc impératif de vérifier si elle l’est ou non avant de* 
      * la mettre à jour. Après avoir mis à jour la livraison entrante,*
      * il est impératif d’effectuer les opérations sur le stock.      *
      * Il faut donc, pour chaque Livraison_Piece, rajouter la quantité* 
      * indiquée à la pièce en question. Pour récupérer les            *
      * Livraison_Piece, il faut utiliser le programme fetlivpi, qui   *
      * lit une ligne à chaque appel.                                  *
      * TRÈS IMPORTANT Se référer à la maquette pour l’agencement,     *
      * ainsi que le chemin des écrans, ET LA LOGIQUE.                 *
      *                                                                * 
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; MJ=MISE A JOUR; LIV=LIVRAISON; IDF=IDENTIFIANT;     *
      * DAT=DATE; STA=STATUT; CRS=COURS; TRM=TERMINE; TYP=TYPE;        *
      * ENT=ENTRANTE; SRT=SORTANTE; FOU=FOURNISSEUR; CLI=CLIENT;       *
      * RET=RETOUR; LCT=LECTURE; DON=DONNEE; PIE=PIECE; QTE=QUANTITE;  *
      * CHG=CHANGEMENT; AJU=AJOUT; RTR=RETRAIT; STI=SORTIE;            *
      * CRG=CROCHET GAUCHE; CRD=CROCHET DROIT; CHX=CHOIX; ROL=ROLE;    *
      * UTI=UTILISATEUR; AFF=AFFICHAGE; EVA=EVALUATION; LRR=LEURRE;    *
      * VID=VIDE; VRF=VERIFICATION; BCL=BOUCLE.                        *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjliv IS INITIAL.
       AUTHOR. Thomas D.
       DATE-WRITTEN. 10-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Déclaration des variables correspondant à l'identifiant et à la 
      * date de livraison.  
       01 WS-IDF-LIV              PIC 9(10).
       01 WS-DAT-LIV              PIC X(10).

      * Déclaration de la variable (flag) correspondant au statut de la 
      * livraison. Elle prend 2 valeurs : 0 pour une livraison en cours
      * et 1 pour une livraison terminée. 
       01 WS-STA-LIV              PIC 9(01).
           88 WS-STA-LIV-EN-CRS                 VALUE 0.
           88 WS-STA-LIV-TRM                    VALUE 1.

      * Déclaration de la variable (flag) correspondant au type de la  
      * livraison. Elle prend 2 valeurs : 0 pour une livraison entrante
      * et 1 pour une livraison sortante.
       01 WS-TYP-LIV              PIC 9(01).
           88 WS-TYP-LIV-ENT                    VALUE 0.
           88 WS-TYP-LIV-SRT                    VALUE 1.

      * Déclaration de la variable de sortie d'appel du sous-programme 
      * "liridliv". Elle correspond à l'identifiant et au nom du 
      * fournisseur si la livraison est entrante, et à l'identifiant et
      * au nom du client si la livraison est sortante.
       01 WS-IDF-STI              PIC 9(10).
       01 WS-NOM-STI              PIC X(50).

      * Copies des codes retour pour la lecture par id et la mise à 
      * jour de livraison.
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

      * Déclaration de la variable (flag) correspondant à l'état de    
      * lecture ligne par ligne des informations des pièces d'une   
      * livraison (id_pie et qte_pie). Elle prend 2 valeurs : 
      * 0 pour une lecture en cours et 1 pour la fin de lecture. 
       01 WS-RET-LCT              PIC 9(01).
           88 WS-RET-DON-LUE                VALUE 0.
           88 WS-RET-FIN-LCT                VALUE 1.
       
      * Déclaration des variables correspondant à l'identifiant et à la 
      * quantité de la pièce (à transmettre au sous-programme "majpie"
      * et au sous-programme "fetlivpi"). 
       01 WS-IDF-PIE              PIC 9(10).
       01 WS-QTE-PIE              PIC 9(10).

      * Déclaration de la variable (flag) correspondant au type de   
      * changement à faire sur la quantité. Elle prend 2 valeurs : 
      * 0 pour un ajout et 1 pour un retrait
      * (à transmettre au sous-programme "majpie").
       01 WS-TYP-CHG              PIC 9(01).
           88 WS-CHG-AJU                    VALUE 0.
           88 WS-CHG-RTR                    VALUE 1.

       
      * Déclaration de la variable de choix de l'utilisateur à l'écran 
      * (pour mettre à jour une livraison ou annuler l'opération et 
      * retourner au programme appelant). 
       01 WS-CHX-UTI   PIC X(01).
       
      * Déclaration de variables utilisées pour l'affichage à l'écran. 
       01 WS-ROL-UTI   PIC X(10)   VALUE "ADMIN".
       01 WS-CRG       PIC X(01)   VALUE "[".
       01 WS-CRD       PIC X(01)   VALUE "]".
       01 WS-LRR       PIC X(01).
       01 WS-VID       PIC X(78).
       

       SCREEN SECTION.
       COPY ecrprn.
       
       01 S-ECR-MJ-LIV.
           05 LINE 04 COLUMN 03 VALUE "Connecte en tant que : ".    
           05 LINE 04 COLUMN 26 PIC X(10) FROM WS-ROL-UTI. 
           05 LINE 06 COLUMN 24 VALUE "ID livraison : ".    
           05 LINE 06 COLUMN 40 PIC X(01) FROM WS-CRG. 
           05 LINE 06 COLUMN 41 PIC Z(10) TO WS-IDF-LIV. 
           05 LINE 06 COLUMN 51 PIC X(01) FROM WS-CRD. 
           05 LINE 22 COLUMN 20 VALUE "1 - Valider la reception".    
           05 LINE 22 COLUMN 47 VALUE "0 - Annuler". 
           05 LINE 23 COLUMN 40 PIC X(01) FROM WS-CRG. 
           05 LINE 23 COLUMN 41 PIC X(01) TO WS-CHX-UTI. 
           05 LINE 23 COLUMN 42 PIC X(01) FROM WS-CRD. 
           
           
           
       PROCEDURE DIVISION.
           
           PERFORM 0100-BCL-ECR-DEB
              THRU 0100-BCL-ECR-FIN.

           
           EXIT PROGRAM.
           


      ******************************************************************
      *                         PARAGRAPHES                            * 
      ****************************************************************** 
       0100-BCL-ECR-DEB.

      * Affichage en boucle de l'écran tant que l'utilisateur ne rentre
      * pas 0 pour annuler. Une fois qu'il entre 0, la boucle s'arrête
      * le programme se ferme et on revient au programme appelant.

           PERFORM UNTIL WS-CHX-UTI = '0' 

               PERFORM 0200-AFF-ECR-MJ-LIV-DEB
                  THRU 0200-AFF-ECR-MJ-LIV-FIN   
               
           END-PERFORM.     
           EXIT.
       0100-BCL-ECR-FIN.    
           
      *-----------------------------------------------------------------     
           
       0200-AFF-ECR-MJ-LIV-DEB.

      * Affichage de l'écran de mise à jour de livraison. 
           DISPLAY S-FND-ECR.
           ACCEPT S-ECR-MJ-LIV.

      * Evaluation du choix saisi par l'utilisateur.       
           PERFORM 0300-EVA-CHX-UTI-DEB
              THRU 0300-EVA-CHX-UTI-FIN.

           EXIT.
       0200-AFF-ECR-MJ-LIV-FIN.

      *-----------------------------------------------------------------     

       0300-EVA-CHX-UTI-DEB.
           
           EVALUATE WS-CHX-UTI

      * Si l'utilisateur entre 1...         
               WHEN '1'

      * ... et qu'il ne rentre pas d'ID de livraison, alors un message 
      * est affiché à l'écran pour l'inviter à remplir le champ 
      * correspondant.             
                   IF WS-IDF-LIV = 0

                       DISPLAY WS-VID 
                       AT LINE 22 COL 02

                       DISPLAY "Veuillez saisir un ID de livraison"
                       AT LINE 22 COL 03 

                       ACCEPT WS-LRR   
                       AT LINE 22 COL 38

      * ... et qu'il rentre l'ID de livraison alors on procède à la 
      * lecture de l'ID de livraison et on va chercher les informations
      * correspondant à la livraison choisie.    
      * Ensuite le statut de la livraison (entrante ou sortante) est 
      * vérifié.

                   ELSE 
                    
                       PERFORM 0400-LCT-IDF-LIV-DEB
                          THRU 0400-LCT-IDF-LIV-FIN

       
                       PERFORM 0500-VRF-STA-LIV-DEB
                          THRU 0500-VRF-STA-LIV-FIN

                   END-IF

      * Si l'utilisateur entre autre chose que 0 ou 1 alors un message
      * est affiché à l'écran pour inviter l'utilisateur à saisir une 
      * des options existantes.

               WHEN <> '0'

                   DISPLAY WS-VID 
                   AT LINE 22 COL 02

                   DISPLAY "Veuillez saisir une des options existantes"
                   AT LINE 22 COL 03 
                   
                   ACCEPT WS-LRR   
                   AT LINE 22 COL 46

           END-EVALUATE.
           EXIT.
       0300-EVA-CHX-UTI-FIN.        
       
      *-----------------------------------------------------------------     
       
       0400-LCT-IDF-LIV-DEB.

      * Lecture des informations de livraison à l'aide de l'ID.

           CALL "liridliv"
               USING
      * Arguments d'entrée
               WS-IDF-LIV
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-DAT-LIV
               WS-STA-LIV
               WS-TYP-LIV
               WS-IDF-STI
               WS-NOM-STI
               WS-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

           EXIT.
       0400-LCT-IDF-LIV-FIN.
       
      *-----------------------------------------------------------------     
           
       0500-VRF-STA-LIV-DEB.

      * Vérification du statut de la livraison.

      * Si la livraison est en cours, la mise à jour de celle-ci s'opère
      * et un message de confirmation est affiché à l'écran.

           IF WS-STA-LIV-EN-CRS

               PERFORM 0600-MJ-LIV-DEB
                  THRU 0600-MJ-LIV-FIN
               
               DISPLAY "Le statut de la livraison selectionnee a ete"
               AT LINE 13 COL 20 
               DISPLAY "mis a jour" 
               AT LINE 14 COL 20 

               ACCEPT WS-LRR   
               AT LINE 22 COL 75

      * Si la livraison est déjà terminée alors on le précise à 
      * l'aide d'un message à l'écran et rien n'est fait.

           ELSE 
               DISPLAY "La livraison selectionnee est deja terminee"
               AT LINE 13 COL 20 
               
               ACCEPT WS-LRR   
               AT LINE 22 COL 64

           END-IF.

           EXIT.
       0500-VRF-STA-LIV-FIN.

      *-----------------------------------------------------------------     

       0600-MJ-LIV-DEB.

      * Mise à jour du statut de livraison (de "en cours" à "terminée").

           CALL "majliv"
               USING
      * Arguments d'entrée
               WS-IDF-LIV
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-MAJ-RET
      * Fin des arguments de sortie
           END-CALL.
           

      * Si la livraison est entrante, alors il faut modifier les 
      * quantités des pièces en stock pour la livraison correspondante. 
           IF WS-TYP-LIV-ENT THEN
               
               SET WS-CHG-AJU TO TRUE 
               PERFORM 0700-MJ-QTE-PIE-LIV-DEB
                  THRU 0700-MJ-QTE-PIE-LIV-FIN

           END-IF.
           
           EXIT.
       0600-MJ-LIV-FIN.  
           
      *-----------------------------------------------------------------     
       
       0700-MJ-QTE-PIE-LIV-DEB.
       
      * Lecture séquentielle des pièces d'une livraison. Pour chaque 
      * pièce on récupère les informations nécessaires pour la mise à 
      * jour du stock.

           PERFORM UNTIL WS-RET-FIN-LCT
               CALL "fetlivpi"
                   USING
      * Arguments d'entrée
                   WS-IDF-LIV
      * Fin des arguments d'entrée
      * Début des arguments de sortie
                   WS-IDF-PIE
                   WS-QTE-PIE
                   WS-RET-LCT
      * Fin des arguments de sortie
               END-CALL
               

      * Mise à jour du stock des pièces comprises dans la livraison 
      * correspondante.
               IF WS-RET-DON-LUE
                   CALL "majpie"
                       USING
                       WS-IDF-PIE
                       WS-QTE-PIE
                       WS-TYP-CHG
                   END-CALL
               END-IF 

           END-PERFORM.
           
           EXIT.

       0700-MJ-QTE-PIE-LIV-FIN.
