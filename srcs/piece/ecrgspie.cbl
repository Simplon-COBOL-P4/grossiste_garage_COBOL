      ******************************************************************
      *                             ENTÊTE                             *
      * Ce programme affiche le menu de gestion des pièces.            *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; GS=GESTION; PIE=PIECE; STD=SANDARD; RLE=ROLE        *
      * MNU=MENU; ADM=ADMIN; CHX=CHOIX; UTL=UTILISATEUR                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrgspie.
       AUTHOR. Yassine.
       DATE-WRITTEN. 30-06-2025(fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77 WS-CHX-MNU            PIC X(01).
       77 WS-RLE-UTL            PIC X(14).  
       77 WS-STATUT             PIC X(30).


       LINKAGE SECTION.
      * Arguments d'entrée.
      * Rôle de l'utilisateur, ADMIN ou STANDARD actuellement.
       01 ROLE                  PIC X(14).


       SCREEN SECTION.
       COPY ecrprn.
       01 S-MNU-STD.
           05 LINE 04 COLUMN 01 VALUE " Connecte en tant que : User".
           05 LINE 10 COLUMN 30 VALUE "Gestion du stock".
           05 LINE 12 COLUMN 30 VALUE "1 - Ajouter une piece".
           05 LINE 13 COLUMN 30 VALUE "2 - Afficher une piece".
           05 LINE 14 COLUMN 30 VALUE "3 - Modifier une piece".
           05 LINE 20 COLUMN 30 VALUE "0 - Retour au menu".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : ".
           05 LINE 22 COLUMN 52 VALUE "[".
           05 LINE 22 COLUMN 54 VALUE "]".
           05 LINE 22 COLUMN 53 PIC X(01) TO   WS-CHX-MNU.

       01 S-MNU-ADM.    
           05 LINE 04 COLUMN 01 VALUE " Connecte en tant que : Admin".
           05 LINE 10 COLUMN 30 VALUE "Gestion du stock".
           05 LINE 12 COLUMN 30 VALUE "1 - Ajouter une piece".
           05 LINE 13 COLUMN 30 VALUE "2 - Afficher une piece".
           05 LINE 14 COLUMN 30 VALUE "3 - Modifier une piece".
           05 LINE 15 COLUMN 30 VALUE "4 - Supprimer une piece".
           05 LINE 20 COLUMN 30 VALUE "0 - Retour au menu".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix : ".
           05 LINE 22 COLUMN 52 VALUE "[".
           05 LINE 22 COLUMN 54 VALUE "]".
           05 LINE 22 COLUMN 53 PIC X(01) TO   WS-CHX-MNU.

      ******************************************************************     
       PROCEDURE DIVISION USING ROLE.
     
           MOVE ROLE TO WS-RLE-UTL.

           PERFORM 0050-CHX-RLE-DEB
              THRU 0050-CHX-RLE-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *         Gère l’affichage de l'ecran selon le rôle.
      ******************************************************************
       0050-CHX-RLE-DEB.
     
      * Mettre les lettres en majuscules.
            MOVE FUNCTION UPPER-CASE(WS-RLE-UTL) TO WS-RLE-UTL
       
           EVALUATE WS-RLE-UTL
      * Si le rôle est  admin, on afficher le menu admin.
               WHEN "ADMIN"
                   PERFORM 0200-AFF-MNU-ADM-DEB
                      THRU 0200-AFF-MNU-ADM-FIN

      * Si le rôle est  admin, on afficher le menu admin.
               WHEN "STANDARD"
                   PERFORM 0100-AFF-MNU-STD-DEB
                      THRU 0100-AFF-MNU-STD-FIN
                      
               WHEN OTHER
                   MOVE "Role invalide" TO WS-STATUT
           END-EVALUATE.
       0050-CHX-RLE-FIN.
           EXIT.  

      ******************************************************************
      *                      Affiche le menu admin
      ******************************************************************   

       0200-AFF-MNU-ADM-DEB.
           MOVE SPACES TO WS-CHX-MNU

           PERFORM UNTIL WS-CHX-MNU = '0'
               DISPLAY S-FND-ECR
               DISPLAY S-MNU-ADM
               ACCEPT  S-MNU-ADM
       
       
           
               EVALUATE WS-CHX-MNU

                   WHEN '1'
                       CALL "ecrajpie"
        
                       END-CALL
                   WHEN '2'
                       CALL "affpie"
        
                       END-CALL
                   WHEN '3'
                       CALL "ecrmjpie"
        
                       END-CALL
                   WHEN '4'
                       CALL "ecrsppie"
        
                       END-CALL
                END-EVALUATE
           END-PERFORM.

       0200-AFF-MNU-ADM-FIN.
           EXIT.

      ******************************************************************
      *    Affiche le menu principal commun à tous les utilisateurs.
      ******************************************************************
       0100-AFF-MNU-STD-DEB.
           MOVE SPACES TO WS-CHX-MNU

           PERFORM UNTIL WS-CHX-MNU = '0'
               DISPLAY   S-FND-ECR
               DISPLAY   S-MNU-STD
               ACCEPT    S-MNU-STD

               EVALUATE WS-CHX-MNU
                   WHEN '1'
                        CALL "ecrajpie" 

                        END-CALL  

                   WHEN '2'
                        CALL "affpie"

                        END-CALL 
                   WHEN '3'
                        CALL "ecrmjpie"
                        
                        END-CALL 
                   WHEN '0'
                       MOVE "Retour au menu..."          TO WS-STATUT

                   WHEN OTHER
                       MOVE "Choix invalide. Réessayez." TO WS-STATUT
               END-EVALUATE
           END-PERFORM.
       0100-AFF-MNU-STD-FIN.
           EXIT.
