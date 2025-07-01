      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; PG=PAGE; CLI=CLIENT;                                *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrpgcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 QUANTITE              PIC 9(02). *> Min 1 - Max 25.

       01 PAGE-P                PIC 9(10). *> Min 0 - Max 1,000,000,000

       01 TABLEAU.
           05 CLIENT OCCURS 25 TIMES. *> Quantité Max.
               10 IDENTIFIANT       PIC 9(10).
               10 NOM               PIC X(80).
               10 EMAIL             PIC X(160).
               10 INDICATIF         PIC 9(03).
               10 TEL               PIC 9(10).
               10 CODE-POSTAL       PIC 9(05).
               10 VILLE             PIC X(80).
               10 ADRESSE           PIC X(160).

       PROCEDURE DIVISION.

           CALL "lirpgcli"
               USING
               QUANTITE
               PAGE-P
               TABLEAU
           END-CALL.

           EXIT PROGRAM.