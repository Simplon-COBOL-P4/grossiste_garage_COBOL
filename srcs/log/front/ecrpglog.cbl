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
      * ecr=ecran, lin=ligne; tab=table det=detail; fnd=fond;          *
      * ID=IDENTIFIANT; UTI=UTILISATEUR; heu=heure; jou=jour;          *
      * typ=type; acc=accept; num=nombre; mnu=menu;  cmp=complet;      *
      * AFF=affichage; pag,pg=page; qtt=quantite; vid=vide;            *
      * enc=en cours; err=erreur; rle=role; und=underscore; ntt=entete;*
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
               10  WS-LOG-ID       PIC 9(10).
               10  WS-LOG-DET      PIC X(100).
               10  WS-LOG-HEU      PIC X(08).
               10  WS-LOG-JOU      PIC X(10).
               10  WS-LOG-TYP      PIC X(12).
               10  WS-UTI-ID       PIC 9(10).

       01  WS-UND-LIN              PIC X(78) VALUE ALL "_".  

       01  WS-NTT-LIN.
           05 WS-LOG-LIN-1-JOU     PIC X(10) VALUE "   Date   ".
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-HEU     PIC X(08) VALUE "   Heure  ".
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-ID-LOG  PIC Z(09)9(01) VALUE "  ID log  ".
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-ID-UTI  PIC Z(10) VALUE "  ID Uti. ".
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-TYP     PIC X(12) VALUE "  Type Log  ".
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-DET-DEB PIC X(23) VALUE 
               "        Message        ".

       01  WS-LOG-LIN-1.
           05 WS-LOG-LIN-1-JOU     PIC X(10).
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-HEU     PIC X(08).
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-ID-LOG  PIC Z(09)9(01).
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-ID-UTI  PIC Z(10).
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-TYP     PIC X(12).
           05 FILLER               PIC X(01) VALUE ALL "|".
           05 WS-LOG-LIN-1-DET-DEB PIC X(23).
       01  WS-LOG-LIN-2.
           05 WS-LOG-LIN-2-DET-FIN PIC X(77).
           

      *Déclaration des variables indépendantes.
       77  WS-MAX-LIN           PIC 9(02) VALUE 6.
       77  WS-QTT-LIN           PIC 9(02).
       77  WS-LIN-IDX           PIC 9(02).
       77  WS-IDX               PIC 9(02).
       77  WS-NUM-PAG           PIC 9(10).
       01  WS-CHX               PIC X(01) VALUE SPACE.
           88 WS-CHX-VID                  VALUE " ".

       01 WS-ETT-BCL            PIC 9(01).
           88 WS-ETT-BCL-ENC              VALUE 1.
           88 WS-ETT-BCL-FIN              VALUE 2.

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       COPY utiglb.

      * Déclaration de l'écran d'affichage.
       SCREEN SECTION.
       COPY ecrprn.
       01 S-MNU-LOG.
           05 LINE 04.
               10 COL 03 VALUE "Connecte en tant que : ".
               10 COL 26 FROM G-UTI-RLE.
           05 LINE 09 COL 02 FROM WS-UND-LIN.
           05 LINE 10 COL 02 FROM WS-NTT-LIN.
           05 LINE 11 COL 02 FROM WS-UND-LIN.
           05 LINE 23.
               10 COL 03 VALUE "Choix de la page".
               10 COL 20 VALUE "[".
               10 COL 21 USING PIC 9(10) WS-NUM-PAG.
               10 COL 31 VALUE "]".
               10 COL 62 VALUE "Retour au menu".
               10 COL 77 VALUE "[".
               10 COL 78 USING PIC X(01) WS-CHX.
               10 COL 79 VALUE "]".

       01 S-AFF-ERR.
           05 LINE 18.
               10 COL 03 VALUE
                   "Une erreur est survenue durant la requete".


       PROCEDURE DIVISION.

      * Appel d'un sous programme qui gere la boucle.
           PERFORM 0050-BCL-DEB
              THRU 0050-BCL-FIN.

           EXIT PROGRAM.

      ******************************************************************

       0050-BCL-DEB.
           DISPLAY S-FND-ECR.
           SET WS-ETT-BCL-ENC TO TRUE.
           PERFORM UNTIL WS-ETT-BCL-FIN
               ACCEPT S-MNU-LOG
               EVALUATE TRUE
                   WHEN WS-CHX-VID
                       DISPLAY S-FND-ECR
      * Appel d'un sous-programme pour récupérer les logs en bdd.
                       PERFORM 0100-APL-LEC-LOG-DEB
                          THRU 0100-APL-LEC-LOG-FIN
                       IF WS-LIR-RET-OK THEN
      * Affichages des lignes avec les logs.  
                           PERFORM 0300-AFF-LOG-DEB
                              THRU 0300-AFF-LOG-FIN
                       ELSE
                           PERFORM 0200-AFF-ERR-DEB
                              THRU 0200-AFF-ERR-FIN
                       END-IF
                   WHEN OTHER
                       SET WS-ETT-BCL-FIN TO TRUE
               END-EVALUATE
           END-PERFORM.
       0050-BCL-FIN.

       0100-APL-LEC-LOG-DEB.
           MOVE WS-MAX-LIN TO WS-QTT-LIN.

           CALL "lirpglog"
               USING
               WS-LOG-TAB
               WS-NUM-PAG
               WS-QTT-LIN
               WS-LIR-RET
           END-CALL.
       0100-APL-LEC-LOG-FIN.

       0200-AFF-ERR-DEB.
           DISPLAY S-AFF-ERR.
       0200-AFF-ERR-FIN.

       0300-AFF-LOG-DEB. 
           MOVE 10 TO WS-LIN-IDX.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-QTT-LIN

               MOVE WS-LOG-JOU(WS-IDX)        TO WS-LOG-LIN-1-JOU
               MOVE WS-LOG-HEU(WS-IDX)        TO WS-LOG-LIN-1-HEU
               MOVE WS-LOG-ID (WS-IDX)        TO WS-LOG-LIN-1-ID-LOG
               MOVE WS-UTI-ID (WS-IDX)        TO WS-LOG-LIN-1-ID-UTI
               MOVE WS-LOG-TYP(WS-IDX)        TO WS-LOG-LIN-1-TYP
               MOVE WS-LOG-DET(WS-IDX)        TO WS-LOG-LIN-1-DET-DEB
               MOVE WS-LOG-DET(WS-IDX)(24:77) TO WS-LOG-LIN-2-DET-FIN

               DISPLAY WS-LOG-LIN-1 AT LINE WS-LIN-IDX COLUMN 2
               ADD 1 TO WS-LIN-IDX
               DISPLAY WS-LOG-LIN-2 AT LINE WS-LIN-IDX COLUMN 2
               ADD 1 TO WS-LIN-IDX
           END-PERFORM.
       0300-AFF-LOG-FIN.
       