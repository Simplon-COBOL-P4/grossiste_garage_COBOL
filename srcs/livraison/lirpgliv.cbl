      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *----------------------------------------------------------------*
      *                           TRIGRAMMES                           *
      * LIR=LIRE; PG,PGE=PAGE; LIV=LIVRAISON; NBR=NOMBRE; ELM=ELEMENT; *
      * IDF=IDENTIFIANT; FOU=FOURNISSEUR; CLI=CLIENT; PIE=PIECE;       *
      * FIL=FILTRE; VID=VIDE; TAB=TABLEAU; LIV=LIVRAISON; DAT=DATE;    *
      * STA=STATUT; CRS=COURS; TRM=TERMINE; TYP=TYPE; ENT=ENTRANT;     *
      * SOR=SORTANT; QTE=QUANTITE; OFS=OFFSET; LIN=LIGNE;              *
      * EVA=EVALUATION;
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpgliv.
       AUTHOR. ThomasD.
       DATE-WRITTEN. 11-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 PG-NBR-ELM                     PIC 9(02). *> Min 1 - Max 25
       01 PG-OFS                         PIC 9(03).  


       01 PG-IDF-LIV           PIC 9(10).
       01 PG-IDF-FOU-CLI       PIC 9(10).
       01 PG-NOM-FOU-CLI       PIC X(50).
       01 PG-QTE-PIE           PIC 9(10).
       01 PG-DAT-LIV           PIC X(10).

       01 PG-STA-LIV           PIC 9(01).
           88 PG-STA-EN-CRS                   VALUE 0.
           88 PG-STA-TRM                      VALUE 1.

      * Le nombre de lignes ajouter dans le tableau.
       01 WS-NBR-LIN-TAB        PIC 9(02) VALUE 0.
               
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       
       LINKAGE SECTION.
      * Arguments d'entrée.
       77 LK-PGE                         PIC 9(10).
       77 LK-NBR-ELM                     PIC 9(02).
       77 LK-IDF-FOU-CLI-PIE             PIC 9(10).
       
       01 LK-FIL                         PIC 9(01).
           88 LK-FIL-VID                              VALUE 0.
           88 LK-FIL-FOU                              VALUE 1.
           88 LK-FIL-CLI                              VALUE 2.
           88 LK-FIL-PIE                              VALUE 3.
      * Arguments de sortie.
       01 LK-TAB.
           05 LK-LIV OCCURS 25 TIMES.
               10 LK-IDF-LIV           PIC 9(10).
               10 LK-DAT-LIV           PIC X(10).

               10 LK-STA-LIV           PIC 9(01).
                   88 LK-STA-EN-CRS                   VALUE 0.
                   88 LK-STA-TRM                      VALUE 1.

               10 LK-TYP-LIV           PIC 9(01).
                   88 LK-TYP-ENT                      VALUE 0.
                   88 LK-TYP-SOR                      VALUE 1.
                   
               10 LK-IDF-FOU-CLI       PIC 9(10).
               10 LK-NOM-FOU-CLI       PIC X(50).
      * Attention à l'ambivalence de cet argument, il peut etre le
      * nombre de variete de pieces dans une livraison, comme le nombre
      * de piece de l'ID demandé dans la livraison. 
               10 LK-QTE-PIE           PIC 9(10).
       


       PROCEDURE DIVISION USING LK-PGE,
                                LK-NBR-ELM,
                                LK-IDF-FOU-CLI-PIE,
                                LK-FIL,
                                LK-TAB,
                                WS-LIR-RET.
           

           PERFORM 0100-OFS-DEB
              THRU 0100-OFS-FIN.

           PERFORM 0200-EVA-FIL-DEB
              THRU 0200-EVA-FIL-FIN.

           EXIT PROGRAM.


      ******************************************************************
      *                         PARAGRAPHES                            * 
      ****************************************************************** 