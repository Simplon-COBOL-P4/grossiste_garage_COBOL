      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Pntntr est le point d'entrée du programme. C'est le programme  *
      * principal, celui qui appelera tous les autres.                 *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * POINT=PNT; ENTRÉE=NTR; APPEL=APL; ÉCRAN=ECR; TITRE=TTR;        *
      * CONNEXION=CNX; BASE-DE-DONNÉE=BDD;                             *
      *                                                                *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. pntntr.
       AUTHOR. Leocrabe225.
       DATE-WRITTEN. 25-06-2025 (fr).

       PROCEDURE DIVISION.
           
           PERFORM 0100-APL-ECR-TTR-DEB
              THRU 0100-APL-ECR-TTR-FIN.

           PERFORM 0200-CNX-BDD-DEB
              THRU 0200-CNX-BDD-FIN.

           STOP RUN.

       0100-APL-ECR-TTR-DEB.
           CALL "ecrttr"
           END-CALL.
       0100-APL-ECR-TTR-FIN.

       0200-CNX-BDD-DEB.
           CALL "cnxbdd"
           END-CALL.
       0200-CNX-BDD-FIN.