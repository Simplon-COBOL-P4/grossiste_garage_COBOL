      ****************************************************************** 
      *                                                                *
      *                 DESCRIPTION DU SOUS-PROGRAMME                  *
      *                                                                *
      * Sous-programme permettant récupérer les logs en BDD            *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      *                                                                *
      * lec=Lecture, lin=ligne; tab=table det=detail                   *
      * idl=identifiant log; UTI=UTILISATEUR; heu=heure; jou=jour;     *
      * typ=type; acc=accept; num=nombre; mnu=menu;  cmp=complet       *
      * idu=identifiant utilisateur; idx=index ; err=erreur; ofs=offset*
      * pag=page;                                                      *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpglog.
       Author. Thomas Baudrin.
       DATE-WRITTEN. 26-06-2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.

      *Déclaration des variables correspondants aux attributs de la 
      *table logs et utilisateur
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-IDL     PIC 9(10).
       01  PG-DET     PIC X(100).
       01  PG-HEU     PIC X(08).
       01  PG-JOU     PIC X(10).
       01  PG-TYP     PIC X(12). 
       01  PG-IDU     PIC 9(10).
       01  PG-OFS     PIC 9(10).
       01  PG-MAX-LIN PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.

      * Déclaration d'un index
       77  WS-IDX             PIC 9(02).

      * Inclusion des codes d'erreur SQLCA.
       EXEC SQL INCLUDE SQLCA END-EXEC.

      * Déclaration des variables du sous-programme.
       LINKAGE SECTION.
       
       01  LK-LOG-TAB.
           05  LK-LOG OCCURS 25 TIMES.
               10  LK-LOG-ID    PIC 9(10).
               10  LK-LOG-DET   PIC X(100).
               10  LK-LOG-HEU   PIC X(08).
               10  LK-LOG-JOU   PIC X(10).
               10  LK-LOG-TYP   PIC X(12).
               10  LK-UTI-ID    PIC 9(10).

       77  LK-NUM-PAG           PIC 9(10).
       77  LK-MAX-LIN           PIC 9(02).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.
       
       PROCEDURE DIVISION USING LK-LOG-TAB,
                                LK-NUM-PAG,
                                LK-MAX-LIN,
                                LK-LIR-RET.

      * Initialisation des variables.
           PERFORM 0100-INI-VAR-DEB
           THRU    0100-INI-VAR-FIN.

      *    DISPLAY "1" LINE 2 COL 2.
      *    ACCEPT WS-IDX.

      * Déclaration du curseur.
           PERFORM 0200-DEC-CUR-DEB
           THRU    0200-DEC-CUR-FIN.

      *    DISPLAY "2" LINE 2 COL 2.
      *    ACCEPT WS-IDX.
      * Ouverture du curseur.
           PERFORM 0300-OPN-CUR-DEB
           THRU    0300-OPN-CUR-FIN.

      *    DISPLAY "3" LINE 2 COL 2.
      *    ACCEPT WS-IDX.
      * Affectation des données en bdd avec celle du sous programme 
      * précédent.
           PERFORM 0400-FET-LOG-DEB
           THRU    0400-FET-LOG-FIN.

      *    DISPLAY "4" LINE 2 COL 2.
      *    ACCEPT WS-IDX.
      * Fermeture du curseur.     
           PERFORM 0500-CLS-CUR-DEB
           THRU    0500-CLS-CUR-FIN.
               
      *    DISPLAY "5" LINE 2 COL 2.
      *    ACCEPT WS-IDX.
           EXIT PROGRAM.

      ******************************************************************     
      
       0100-INI-VAR-DEB.
           MOVE 0 TO WS-IDX.
           COMPUTE PG-OFS EQUAL LK-MAX-LIN * LK-NUM-PAG.
           MOVE LK-MAX-LIN TO PG-MAX-LIN.
       0100-INI-VAR-FIN.   

       0200-DEC-CUR-DEB.
           EXEC SQL
               DECLARE CUR_LOGS CURSOR FOR
               SELECT id_logs, detail_log, heure_log, date_log, 
                   type_log, id_uti
               FROM logs
               LIMIT :PG-MAX-LIN
               OFFSET :PG-OFS
           END-EXEC.
       0200-DEC-CUR-FIN.    

       0300-OPN-CUR-DEB.
           EXEC SQL 
               OPEN CUR_LOGS
           END-EXEC.
           IF SQLCODE NOT = 0
               SET LK-LIR-RET-ERR TO TRUE
               EXIT PROGRAM
           END-IF.
       0300-OPN-CUR-FIN.    

       0400-FET-LOG-DEB.
           PERFORM UNTIL SQLCODE EQUAL 100

               EXEC SQL
                   FETCH CUR_LOGS INTO :PG-IDL, :PG-DET, :PG-HEU, 
                       :PG-JOU, :PG-TYP, :PG-IDU
               END-EXEC

      *        DISPLAY SQLSTATE LINE 2 COL 2
      *        ACCEPT LK-MAX-LIN

               
               IF SQLCODE = 0
                   ADD 1 TO WS-IDX
                   MOVE PG-IDL TO LK-LOG-ID(WS-IDX)
                   MOVE PG-DET TO LK-LOG-DET(WS-IDX)
                   MOVE PG-HEU TO LK-LOG-HEU(WS-IDX)
                   MOVE PG-JOU TO LK-LOG-JOU(WS-IDX)
                   MOVE PG-TYP TO LK-LOG-TYP(WS-IDX)
                   MOVE PG-IDU TO LK-UTI-ID(WS-IDX)
               ELSE
                   IF SQLCODE NOT EQUAL 100
                       SET LK-LIR-RET-ERR TO TRUE
                       EXIT PROGRAM
                   END-IF
               END-IF
      *        DISPLAY WS-IDX LINE 2 COL 2
      *        ACCEPT LK-MAX-LIN
               
           END-PERFORM.
           MOVE WS-IDX TO LK-MAX-LIN.
       0400-FET-LOG-FIN.    

       0500-CLS-CUR-DEB.
           EXEC SQL
               CLOSE CUR_LOGS
           END-EXEC.
               
           IF SQLCODE NOT = 0
               EXEC SQL ROLLBACK END-EXEC
               SET LK-LIR-RET-ERR TO TRUE
               EXIT PROGRAM
           END-IF.

           EXEC SQL COMMIT END-EXEC.
           SET LK-LIR-RET-OK TO TRUE.
       0500-CLS-CUR-FIN.    
       
