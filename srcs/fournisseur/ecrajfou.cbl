      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; AJ=AJOUT; FOU=FOURNISSEUR;                          *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NOM                   PIC X(50).
       01 ADRESSE               PIC X(50).
       01 VILLE                 PIC X(50).
       01 CODE-POSTAL           PIC 9(05).
       01 INDICATIF             PIC 9(03).
       01 TELEPHONE             PIC 9(10).
       01 EMAIL                 PIC X(50).

       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.
       
           CALL "ajufou"
               USING
               NOM
               ADRESSE
               VILLE
               CODE-POSTAL
               INDICATIF
               TELEPHONE
               EMAIL
               LK-AJU-RET
           END-CALL.

           EXIT PROGRAM.
