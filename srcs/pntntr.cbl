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
      * MESSAGE=MSG;                                                   *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. pntntr.
       AUTHOR. Leocrabe225.
       DATE-WRITTEN. 25-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-COD-RET          PIC 9(01).
           88 WS-STT-ERR                 VALUE 0.
           88 WS-STT-ADM                 VALUE 1.
           88 WS-STT-STD                 VALUE 2.

       01 WS-CHX              PIC 9(01).
       01 WS-MSG              PIC X(40).

       PROCEDURE DIVISION.
           
           PERFORM 0100-APL-ECR-TTR-DEB
              THRU 0100-APL-ECR-TTR-FIN.

           PERFORM 0200-APL-ECR-CNX-DEB
              THRU 0200-APL-ECR-CNX-FIN.
           
           STOP RUN.

       0100-APL-ECR-TTR-DEB.
           CALL "eccnxbdd"
               USING
               WS-COD-RET
           END-CALL.

           IF WS-COD-RET NOT EQUAL 0
               STOP RUN
           END-IF.

       0100-APL-ECR-TTR-FIN.

       0200-APL-ECR-CNX-DEB.
           CALL "ecrcxuti"
               USING
               WS-COD-RET
           END-CALL.

           EVALUATE TRUE
               WHEN WS-STT-ADM
                   CALL "ecradm"
                       USING
                       WS-CHX
                       WS-MSG
                   END-CALL
               WHEN WS-STT-STD
                   CALL "ecrsta"
                       USING
                       WS-CHX
                       WS-MSG
                   END-CALL
               WHEN WS-STT-ERR
                   STOP RUN
           END-EVALUATE.
       0200-APL-ECR-CNX-FIN.
       