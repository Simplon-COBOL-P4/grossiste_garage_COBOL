      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; MJ=MISE A JOUR; FOU=FOURNISSEUR;                    *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT           PIC 9(10).
       01 NOM                   PIC X(50).
       01 ADRESSE               PIC X(50).
       01 VILLE                 PIC X(50).
       01 CODE-POSTAL           PIC 9(05).
       01 INDICATIF             PIC 9(03).
       01 TELEPHONE             PIC 9(10).
       01 EMAIL                 PIC X(50).

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.
       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

       PROCEDURE DIVISION.
           
           CALL "liridfou"
               USING
      * Arguments d'entree.
               IDENTIFIANT
      * Arguments de sortie.
               NOM
               ADRESSE
               VILLE
               CODE-POSTAL
               INDICATIF
               TELEPHONE
               EMAIL
               WS-LIR-RET
           END-CALL.

           CALL "majfou"
               USING
               IDENTIFIANT
               NOM
               ADRESSE
               VILLE
               CODE-POSTAL
               INDICATIF
               TELEPHONE
               EMAIL
               WS-MAJ-RET
           END-CALL.

           EXIT PROGRAM.