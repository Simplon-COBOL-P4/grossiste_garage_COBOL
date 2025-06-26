      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * lirpgcli                                                       *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * LIRE=LIR; PG=PAGE; CLIENT=CLI                                  *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirpgcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 QUANTITE              PIC 9(02). *> Min 1 - Max 25.
       01 PAGE-P                PIC 9(10). *> Min 0 - Max 1,000,000,000

      * Arguments de sortie.
       01 TABLEAU OCCURS 25 TIMES. *> Quantité Max.
           05 IDENTIFIANT       PIC 9(10).
           05 NOM               PIC X(80).
           05 EMAIL             PIC X(160).
           05 INDICATIF         PIC 9(03).
           05 TEL               PIC 9(10).
           05 CODE-POSTAL       PIC 9(05).
           05 VILLE             PIC X(80).
           05 ADRESSE           PIC X(160).

       PROCEDURE DIVISION USING QUANTITE,
                                PAGE-P,
                                TABLEAU.

           EXIT PROGRAM.