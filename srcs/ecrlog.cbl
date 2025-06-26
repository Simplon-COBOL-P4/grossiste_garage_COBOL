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
      * ecrlog=Ecran log, lin=ligne; tab=table det=detail              *
      * ID=IDENTIFIANT; UTI=UTILISATEUR; heu=heure; jou=jour;          *
      * typ=type; acc=accept; num=nombre; mnu=menu;  cmp=complet       *
      ******************************************************************  
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrlog.
       AUTHOR. Thomas Baudrin.
       DATE-WRITTEN. 26-06-2025(fr).

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       
      *Déclaration de la table contenant tous les logs.
       01  WS-LOG-TAB.
           05  WS-LOG OCCURS 100 TIMES.
               10  WS-LOG-ID    PIC 9(10).
               10  WS-LOG-DET   PIC X(30).
               10  WS-LOG-HEU   PIC X(08).
               10  WS-LOG-JOU   PIC X(10).
               10  WS-LOG-TYP   PIC X(12).
               10  WS-UTI-ID    PIC 9(10).
               10  WS-UTI-NOM   PIC X(30).

      *Déclaration des variables indépendantes.
       77  WS-MAX-LIN           PIC 9(03).
       77  WS-LIN-NUM           PIC 9(02).
       77  WS-IDX               PIC 9(03).
       77  WS-LIN-CMP           PIC X(78).
       77  WS-ACC               PIC X.

      *Déclaration de l'écran d'affichage.
       SCREEN SECTION.
       01 E-MNU-LOG.
           05 BLANK SCREEN.
           05 LINE 01 COLUMN 01 VALUE "+------------------------------".
           05 LINE 01 COLUMN 30 VALUE "-------------------------------".
           05 LINE 01 COLUMN 61 VALUE "-------------------+".
           05 LINE 02 COLUMN 01 VALUE "|".
           05 LINE 02 COLUMN 33 VALUE "LogiParts Solutions".
           05 LINE 02 COLUMN 80 VALUE "|".
           05 LINE 03 COLUMN 01 VALUE "+------------------------------".
           05 LINE 03 COLUMN 30 VALUE "-------------------------------".
           05 LINE 03 COLUMN 61 VALUE "-------------------+".
           05 LINE 04 COLUMN 01 VALUE "| Connecte en tant que : Admin".
           05 LINE 04 COLUMN 80 VALUE "|".
           05 LINE 05 COLUMN 80 VALUE "|".
           05 LINE 06 COLUMN 80 VALUE "|".
           05 LINE 07 COLUMN 80 VALUE "|".
           05 LINE 08 COLUMN 80 VALUE "|".
           05 LINE 09 COLUMN 80 VALUE "|".
           05 LINE 10 COLUMN 80 VALUE "|".
           05 LINE 11 COLUMN 80 VALUE "|".
           05 LINE 12 COLUMN 80 VALUE "|".
           05 LINE 13 COLUMN 80 VALUE "|".
           05 LINE 14 COLUMN 80 VALUE "|".
           05 LINE 15 COLUMN 80 VALUE "|".
           05 LINE 16 COLUMN 80 VALUE "|".
           05 LINE 17 COLUMN 80 VALUE "|".
           05 LINE 18 COLUMN 80 VALUE "|".
           05 LINE 19 COLUMN 80 VALUE "|".
           05 LINE 20 COLUMN 80 VALUE "|".
           05 LINE 21 COLUMN 80 VALUE "|".
           05 LINE 22 COLUMN 80 VALUE "|".
           05 LINE 23 COLUMN 80 VALUE "|".
           05 LINE 24 COLUMN 80 VALUE "|".
          
           05 LINE 04 COLUMN 01 VALUE "|".
           05 LINE 05 COLUMN 01 VALUE "|".
           05 LINE 06 COLUMN 01 VALUE "|".
           05 LINE 07 COLUMN 01 VALUE "|".
           05 LINE 08 COLUMN 01 VALUE "|".
           05 LINE 09 COLUMN 01 VALUE "|".
           05 LINE 10 COLUMN 01 VALUE "|".
           05 LINE 11 COLUMN 01 VALUE "|".
           05 LINE 12 COLUMN 01 VALUE "|".
           05 LINE 13 COLUMN 01 VALUE "|".
           05 LINE 14 COLUMN 01 VALUE "|".
           05 LINE 15 COLUMN 01 VALUE "|".
           05 LINE 16 COLUMN 01 VALUE "|".
           05 LINE 17 COLUMN 01 VALUE "|".
           05 LINE 18 COLUMN 01 VALUE "|".
           05 LINE 19 COLUMN 01 VALUE "|".
           05 LINE 20 COLUMN 01 VALUE "|".
           05 LINE 21 COLUMN 01 VALUE "|".
           05 LINE 22 COLUMN 01 VALUE "|".
           05 LINE 23 COLUMN 01 VALUE "|".
           05 LINE 24 COLUMN 01 VALUE "|".
           05 LINE 24 COLUMN 01 VALUE "+------------------------------".
           05 LINE 24 COLUMN 30 VALUE "-------------------------------".
           05 LINE 24 COLUMN 61 VALUE "-------------------+".       

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
           DISPLAY E-MNU-LOG.
       0200-AFF-SCR-FIN. 

       0300-AFF-LOG-DEB. 
           MOVE 5 TO WS-LIN-NUM.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1
           UNTIL WS-IDX > WS-MAX-LIN

               COMPUTE WS-LIN-NUM = WS-LIN-NUM + 1

               STRING
                   "[" WS-LOG-JOU(WS-IDX) "/" WS-LOG-HEU(WS-IDX) "] "
                   "L'utilisateur "
                   WS-UTI-ID(WS-IDX)
                   " a "
                   INTO WS-LIN-CMP
               END-STRING

               DISPLAY WS-LIN-CMP AT LINE WS-LIN-NUM COLUMN 02

               COMPUTE WS-LIN-NUM = WS-LIN-NUM + 1
           
               DISPLAY WS-LOG-DET(WS-IDX) AT LINE WS-LIN-NUM COLUMN 24

           END-PERFORM.

           ACCEPT WS-ACC AT LINE WS-LIN-NUM COLUMN 100.
       0300-AFF-LOG-FIN.
       