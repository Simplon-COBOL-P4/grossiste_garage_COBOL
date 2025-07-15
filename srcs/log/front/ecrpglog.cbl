      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme permettant d'appeler un sous programme pour     *
      * récupérer les logs en BDD de les afficher                      *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * ecr=ecran, lin=ligne; tab=table det=detail; fnd=fond           *
      * ID=IDENTIFIANT; UTI=UTILISATEUR; heu=heure; jou=jour;          *
      * typ=type; acc=accept; num=nombre; mnu=menu;  cmp=complet       *
      * AFF=affichage;
      ******************************************************************  
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpglog.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 26-06-2025 (fr).

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       
      *Déclaration de la table contenant tous les logs.
       01  WS-LOG-TAB.
           05  WS-LOG OCCURS 25 TIMES.
               10  WS-LOG-ID    PIC 9(10).
               10  WS-LOG-DET   PIC X(30).
               10  WS-LOG-HEU   PIC X(08).
               10  WS-LOG-JOU   PIC X(10).
               10  WS-LOG-TYP   PIC X(12).
               10  WS-UTI-ID    PIC 9(10).
               10  WS-UTI-NOM   PIC X(30).

      *Déclaration des variables indépendantes.
       77  WS-MAX-LIN           PIC 9(02).
       77  WS-LIN-NUM           PIC 9(02).
       77  WS-IDX               PIC 9(02).
       77  WS-LIN-CMP           PIC X(78).
       77  WS-ACC               PIC X.

       77  WS-AFF-ID            PIC Z(09)9(01).

      *Déclaration de l'écran d'affichage.
       SCREEN SECTION.
       COPY ecrprn.
       01 E-MNU-LOG.
           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : Admin".    

       PROCEDURE DIVISION.

      * Appel d'un sous-programme pour récupérer les logs en bdd.
           PERFORM 0100-APL-LEC-LOG-DEB
           THRU    0100-APL-LEC-LOG-FIN.

      * Affichage de l'écran.
           PERFORM 0200-AFF-SCR-DEB
           THRU    0200-AFF-SCR-FIN.

      * Affichages des lignes avec les logs.  
           PERFORM 0300-AFF-LOG-DEB
           THRU    0300-AFF-LOG-FIN.

           EXIT PROGRAM.

      ******************************************************************

       0100-APL-LEC-LOG-DEB.
           CALL "leclog" USING WS-LOG-TAB WS-MAX-LIN
           END-CALL.
       0100-APL-LEC-LOG-FIN.

       0200-AFF-SCR-DEB.
           DISPLAY S-FND-ECR.
           DISPLAY E-MNU-LOG.
       0200-AFF-SCR-FIN. 

       0300-AFF-LOG-DEB. 
           MOVE 5 TO WS-LIN-NUM.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1
           UNTIL WS-IDX > WS-MAX-LIN

               COMPUTE WS-LIN-NUM = WS-LIN-NUM + 1
               MOVE WS-UTI-ID(WS-IDX) TO WS-AFF-ID
               MOVE SPACE TO WS-LIN-CMP
               IF WS-UTI-ID(WS-IDX) NOT EQUAL 0 THEN
                   STRING
                       "[" WS-LOG-JOU(WS-IDX) "/" WS-LOG-HEU(WS-IDX)
                       "] " "Utilisateur "
                       FUNCTION TRIM (WS-AFF-ID)
                       INTO WS-LIN-CMP
                   END-STRING
               ELSE
                   STRING
                       "[" WS-LOG-JOU(WS-IDX) "/" WS-LOG-HEU(WS-IDX) 
                       "] " "Pas d'utilisateur"
                       INTO WS-LIN-CMP
                   END-STRING
               END-IF

               DISPLAY WS-LIN-CMP AT LINE WS-LIN-NUM COLUMN 02

               COMPUTE WS-LIN-NUM = WS-LIN-NUM + 1
           
               DISPLAY WS-LOG-DET(WS-IDX) AT LINE WS-LIN-NUM COLUMN 24
               DISPLAY WS-LOG-TYP(WS-IDX) AT LINE WS-LIN-NUM COLUMN 2

           END-PERFORM.

           ACCEPT WS-ACC AT LINE WS-LIN-NUM COLUMN 100.
       0300-AFF-LOG-FIN.
       