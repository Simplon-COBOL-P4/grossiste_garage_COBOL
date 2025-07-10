      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; PG=PAGE; FOU=FOURNISSEUR;                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpgfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       77 LK-PAGE                         PIC 9(02).
       77 NOMBRE                          PIC 9(02).
      * Arguments de sortie.
       01 TABLEAU.
           05 FOURNISSEUR OCCURS 25 TIMES.
               10 IDENTIFIANT             PIC 9(10).
               10 NOM                     PIC X(50).
               10 ADRESSE                 PIC X(50).
               10 VILLE                   PIC X(50).
               10 CODE-POSTAL             PIC 9(05).
               10 INDICATIF               PIC 9(03).
               10 TELEPHONE               PIC 9(10).
               10 EMAIL                   PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING NOMBRE,
                                LK-PAGE,
                                TABLEAU,
                                LK-LIR-RET.

           EXIT PROGRAM.