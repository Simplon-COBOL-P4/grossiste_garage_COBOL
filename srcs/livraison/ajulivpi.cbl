      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AJU=AJOUT; LIV=LIVRAISON; PI=PIECE;                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajulivpi.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT-LIVRAISON PIC 9(10).
       01 IDENTIFIANT-PIECE     PIC 9(10).
       01 QUANTITE-PIECE        PIC 9(10).
      * Arguments de sortie.

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       PROCEDURE DIVISION USING IDENTIFIANT-LIVRAISON,
                                IDENTIFIANT-PIECE,
                                QUANTITE-PIECE,
                                WS-AJU-RET.

           EXIT PROGRAM.
           