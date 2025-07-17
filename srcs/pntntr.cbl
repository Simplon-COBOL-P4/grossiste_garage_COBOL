      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Pntntr est le point d'entrée du programme. C'est le programme  *
      * principal, celui qui appelera tous les autres.                 *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * POINT=PNT; ENTRÉE=NTR; APPEL=APL; ÉCRAN=ECR; TITRE=TTR;        *
      * CONNEXION=CNX; BASE-DE-DONNÉE=BDD; CODE=COD; RETOUR=RET        *
      * STATUT=STT; ERREUR=ERR; ADMIN=ADM; STANDARD=STD; CHOIX=CHX;    *
      * MESSAGE=MSG; STATUT=STT;                                       *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. pntntr.
       AUTHOR. Leocrabe225.
       DATE-WRITTEN. 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-STT                PIC 9(01).
           88 WS-STT-OK                   VALUE 1.
           88 WS-STT-ERR                  VALUE 2.

       01 WS-CHX                PIC 9(01).
       01 WS-MSG                PIC X(40).

       COPY utiglb.

       PROCEDURE DIVISION.
           
           PERFORM 0100-APL-ECR-TTR-DEB
              THRU 0100-APL-ECR-TTR-FIN.

           PERFORM 0200-APL-ECR-CNX-DEB
              THRU 0200-APL-ECR-CNX-FIN.
           
           STOP RUN.

       0100-APL-ECR-TTR-DEB.
           CALL "ecrcxbdd"
               USING
               WS-STT
           END-CALL.

           IF WS-STT-ERR
               STOP RUN
           END-IF.

       0100-APL-ECR-TTR-FIN.

       0200-APL-ECR-CNX-DEB.
           CALL "ecrcxuti"
               USING
               WS-STT
           END-CALL.

           IF WS-STT-ERR THEN
               STOP RUN
           END-IF.

           CALL "ecrmnprn"
           END-CALL.

       0200-APL-ECR-CNX-FIN.
       