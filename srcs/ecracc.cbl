      ******************************************************************
      *                        ENTÊTE                                  *
      *                                                                *
      *    Le programme appelle un sous-programme                      *
      *    qui va afficher l'écran d'accueil de l'application          *
      *                                                                *
      *                                                                *
      *                       TRIGRAMMES                               *
      *                                                                *
      *    CHOIX = CHO; MENU=MEN; AFFICHER=AFF; ÉCRAN=ECR;             *
      *    ACCUEIL = ACC                                               *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecracc.
       AUTHOR. siboryg.
       DATE-WRITTEN 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *    La variable pour enregistrer le choix du menu.
       01  WS-CHO-MEN PIC 9.
       
       PROCEDURE DIVISION.
      *    Appel de la première procédure qui est un appel à un 
      *    sous-programme.
           PERFORM 0100-APL-PGM-DEB
           THRU 0100-APL-PGM-FIN
       
           STOP RUN.
       
      *    Procédures qui appellent le sous-programme 'screen'.
       0100-APL-PGM-DEB.
           CALL 'screen' USING WS-CHO-MEN.

       0100-APL-PGM-FIN.
           EXIT.
