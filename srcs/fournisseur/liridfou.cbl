      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; ID=IDENTIFIANT; FOU=FOURNISSEUR;                     *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT           PIC 9(10).

      * Arguments de sortie.
       01 NOM                   PIC X(50).
       01 ADRESSE               PIC X(50).
       01 VILLE                 PIC X(50).
       01 CODE-POSTAL           PIC 9(05).
       01 INDICATIF             PIC 9(03).
       01 TELEPHONE             PIC 9(10).
       01 EMAIL                 PIC X(50).
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING IDENTIFIANT,
                                NOM,
                                ADRESSE,
                                VILLE,
                                CODE-POSTAL,
                                INDICATIF,
                                TELEPHONE,
                                EMAIL,
                                LK-LIR-RET.

           EXIT PROGRAM.
