      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme permettant récupérer les logs en BDD            *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * leclog=Lecture log, lin=ligne; tab=table det=detail            *
      * idl=identifiant log; UTI=UTILISATEUR; heu=heure; jou=jour;     *
      * typ=type; acc=accept; num=nombre; mnu=menu;  cmp=complet       *
      * idu=identifiant utilisateur; idx=index                         *
      ******************************************************************   
       IDENTIFICATION DIVISION.
       PROGRAM-ID. leclog.
       Author. Thomas Baudrin.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

      *Déclaration des variables correspondants aux attributs de la 
      *table logs et utilisateur
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  WS-IDL   PIC 9(10).
       01  WS-DET   PIC X(100).
       01  WS-HEU   PIC X(08).
       01  WS-JOU   PIC X(10).
       01  WS-TYP   PIC X(12). 
       01  WS-IDU   PIC 9(10).
       01  WS-NOM   PIC X(80).
       EXEC SQL END DECLARE SECTION END-EXEC.

      * Déclaration d'un index
       77  WS-IDX             PIC 9(03).

      * Inclusion des codes d'erreur SQLCA.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Déclaration des variables du sous-programme.
       LINKAGE SECTION.
       
       01  LK-LOG-TAB.
           05  LK-LOG OCCURS 100 TIMES.
               10  LK-LOG-ID    PIC 9(10).
               10  LK-LOG-DET   PIC X(30).
               10  LK-LOG-HEU   PIC X(08).
               10  LK-LOG-JOU   PIC X(10).
               10  LK-LOG-TYP   PIC X(12).
               10  LK-UTI-ID    PIC 9(10).
               10  LK-UTI-NOM   PIC X(30).

       77  LK-MAX-LIN           PIC 9(03).        
       
       PROCEDURE DIVISION USING LK-LOG-TAB LK-MAX-LIN.

      * Initialisation des variables
           PERFORM 0100-INI-VAR-DEB
           THRU    0100-INI-VAR-FIN.

      * Déclaration du curseur
           PERFORM 0200-DEC-CUR-DEB
           THRU    0200-DEC-CUR-FIN.

      * Ouverture du curseur
           PERFORM 0300-OPN-CUR-DEB
           THRU    0300-OPN-CUR-FIN.

      * Affectation des données en bdd avec celle du sous programme 
      * précédent
           PERFORM 0400-FET-LOG-DEB
           THRU    0400-FET-LOG-FIN.

      * Fermeture du curseur     
           PERFORM 0500-CLS-CUR-DEB
           THRU    0500-CLS-CUR-FIN.
               
           EXIT PROGRAM.

      ******************************************************************     
      
       0100-INI-VAR-DEB.
           MOVE 0 TO WS-IDX.
           MOVE 100 TO LK-MAX-LIN.
       0100-INI-VAR-FIN.   

       0200-DEC-CUR-DEB.
           EXEC SQL 
               DECLARE CUR_LOGS CURSOR FOR
               SELECT id_logs, detail_log, heure_log, date_log, 
                   type_log, logs.id_uti, nom_uti 
               FROM logs
               INNER JOIN utilisateur
               ON logs.id_uti = utilisateur.id_uti
           END-EXEC.
       0200-DEC-CUR-FIN.    

       0300-OPN-CUR-DEB.
           EXEC SQL 
               OPEN CUR_LOGS
           END-EXEC.
           IF SQLCODE NOT = 0
               DISPLAY "Erreur ouverture curseur, SQLCODE = " SQLCODE
               STOP RUN
           END-IF.
       0300-OPN-CUR-FIN.    

       0400-FET-LOG-DEB.
           PERFORM UNTIL SQLCODE NOT = 0 OR WS-IDX > LK-MAX-LIN

               EXEC SQL
                       FETCH CUR_LOGS INTO :WS-IDL, :WS-DET, :WS-HEU, 
                           :WS-JOU, :WS-TYP, :WS-IDU, :WS-NOM
               END-EXEC
               
               IF SQLCODE = 0
                       ADD 1 TO WS-IDX
                       MOVE WS-IDL TO LK-LOG-ID(WS-IDX)
                       MOVE WS-DET TO LK-LOG-DET(WS-IDX)
                       MOVE WS-HEU TO LK-LOG-HEU(WS-IDX)
                       MOVE WS-JOU TO LK-LOG-JOU(WS-IDX)
                       MOVE WS-TYP TO LK-LOG-TYP(WS-IDX)
                       MOVE WS-IDU TO LK-UTI-ID(WS-IDX)
                       MOVE WS-NOM TO LK-UTI-NOM(WS-IDX)
               ELSE IF SQLCODE = 100
                       DISPLAY "Fin des données."
               ELSE
                       DISPLAY "Erreur pendant le FETCH, SQLCODE = " 
                           SQLCODE 
                       STOP RUN
               END-IF
               
           END-PERFORM.
           MOVE WS-IDX TO LK-MAX-LIN.
       0400-FET-LOG-FIN.    

       0500-CLS-CUR-DEB.
           EXEC SQL
               CLOSE CUR_LOGS
           END-EXEC.
               
           IF SQLCODE NOT = 0
               DISPLAY "Erreur à la fermeture du curseur, SQLCODE = " 
                   SQLCODE
           END-IF.
       0500-CLS-CUR-FIN.    
       
