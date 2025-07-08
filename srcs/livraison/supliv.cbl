      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * SUP=SUPPRIMER; LIV=LIVRAISON;                                  *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. supliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT             PIC 9(10).
      * Arguments de sortie.
       COPY supret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING IDENTIFIANT,
                                LK-SUP-RET.

           EXIT PROGRAM.