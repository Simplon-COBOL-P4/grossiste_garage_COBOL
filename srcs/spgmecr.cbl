      ******************************************************************
      *                        ENTÊTE                                  *
      *                                                                *
      * C'est un sous-programme qui affiche l'écran d'accueil du       *
      * programme, il affiche les différentes actions de bases :       *
      *    - Connexion                                                 *
      *    - Créer un compte                                           *
      *    - Quitter                                                   * 
      *    - (Touche entrée pour valider)                              *
      *                                                                *
      *                       TRIGRAMMES                               *
      *                                                                *
      *    CHOIX = CHO; MENU=MEN; AFFICHER=AFF; ÉCRAN=ECR;             *
      *    S = SOUS; PGM = PROGRAMME ;                                                             *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. spgmecr.
       AUTHOR. siboryg.
       DATE-WRITTEN 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *    La variable pour enregistrer le choix du menu.
       01  WS-CHO-MEN PIC 9.
       
       LINKAGE SECTION.
      *    La variable permettant de définir le paramètre d'appel.
       01  LK-CHO-MEN PIC 9.
              
      *    La screen section pour lister tous les éléments qui doivent 
      *    apparaitre à l'écran, à noter ligne 41, 
      *    la présence de la variable à enregistrer.
       SCREEN SECTION.
       01  ECRAN.
           05 BLANK SCREEN.
           05 LINE 12 COLUMN 30 VALUE "1 - Connexion".
           05 LINE 13 COLUMN 30 VALUE "2 - Creer un compte".
           05 LINE 14 COLUMN 30 VALUE "0 - Quitter".
           05 LINE 22 COLUMN 30 VALUE "Entrez votre choix [".
           05 LINE 22 COLUMN 52 PIC 9 TO WS-CHO-MEN.
           05 LINE 22 COLUMN 53 VALUE "]".
           05 LINE 23 COLUMN 28 VALUE "(Touche Entree pour valider)".
      
       PROCEDURE DIVISION USING LK-CHO-MEN.
      *    Appel de la procédure pour afficher les éléments listés
      *    dans le terminal.
           PERFORM 0100-AFF-ECR-DEB
           THRU 0100-AFF-ECR-FIN

           EXIT PROGRAM.
       
      *    Procédure pour afficher les éléments définis dans 
      *    la screen section.
       0100-AFF-ECR-DEB.
           DISPLAY ECRAN.
           ACCEPT ECRAN.
       
           MOVE WS-CHO-MEN TO LK-CHO-MEN.

       0100-AFF-ECR-FIN.
           EXIT.