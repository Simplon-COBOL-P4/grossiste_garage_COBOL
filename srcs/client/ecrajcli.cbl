      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; AJ=AJOUT; CLI=CLIENT                                 *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NOM                   PIC X(80).
       01 EMAIL                 PIC X(160).
       01 INDICATIF             PIC 9(03).
       01 TEL                   PIC 9(10).
       01 CODE-POSTAL           PIC 9(05).
       01 VILLE                 PIC X(80).
       01 ADRESSE               PIC X(160).

       01 VALEUR-RETOUR         PIC 9(01).
           88 RETOUR-OK                   VALUE 0.
           88 RETOUR-TROP-DE-AROBASE      VALUE 1.
           88 RETOUR-PAS-DE-AROBASE       VALUE 2.
           88 RETOUR-PAS-DE-POINT         VALUE 3.

       PROCEDURE DIVISION.

           CALL "verema"
               EMAIL
               VALEUR-RETOUR
           END-CALL.

           CALL "ajucli"
               USING
               NOM
               EMAIL
               INDICATIF
               TEL
               CODE-POSTAL
               VILLE
               ADRESSE
           END-CALL.
           
           EXIT PROGRAM.