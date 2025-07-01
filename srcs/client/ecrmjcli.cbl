      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; MJ=MISE A JOUR; CLI=CLIENT;                         *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT           PIC 9(10).
       01 NOM                   PIC X(50).
       01 EMAIL                 PIC X(50).
       01 INDICATIF             PIC 9(03).
       01 TEL                   PIC 9(10).
       01 CODE-POSTAL           PIC 9(05).
       01 VILLE                 PIC X(50).
       01 ADRESSE               PIC X(50).

       PROCEDURE DIVISION.
           
           CALL "liridcli"
               USING
      * Arguments d'entrée.
               IDENTIFIANT
      * Fin entrée.
      * Arguments de sortie.
               NOM
               EMAIL
               INDICATIF
               TEL
               CODE-POSTAL
               VILLE
               ADRESSE
      * Fin sortie.
           END-CALL.

           CALL "majcli"
               USING
      * Arguments d'entrée.
               IDENTIFIANT
               NOM
               EMAIL
               INDICATIF
               TEL
               CODE-POSTAL
               VILLE
               ADRESSE
      * Fin entrée.
           END-CALL.

           EXIT PROGRAM.