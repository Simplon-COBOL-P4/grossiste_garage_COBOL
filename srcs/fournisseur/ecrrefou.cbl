      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; RE=RECHERCHE; FOU=FOURNISSEUR;                      *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrrefou.
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
       
      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.
           
           CALL "liridfou"
               USING
      * Arguments d'entrée
               IDENTIFIANT
      * Arguments de sortie
               NOM
               ADRESSE
               VILLE
               CODE-POSTAL
               INDICATIF
               TELEPHONE
               EMAIL
               WS-LIR-RET
           END-CALL.

           CALL "lirnmfou"
               USING
      * Arguments d'entrée
               NOM
      * Arguments de sortie
               IDENTIFIANT
               ADRESSE
               VILLE
               CODE-POSTAL
               INDICATIF
               TELEPHONE
               EMAIL
               WS-LIR-RET
           END-CALL.

           EXIT PROGRAM.