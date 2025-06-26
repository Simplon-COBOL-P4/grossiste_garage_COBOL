      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * ajucli                                                         *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * AJOUT=AJU; CLIENT=CLI;                                         *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajucli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 NOM                   PIC X(80).
       01 EMAIL                 PIC X(160).
       01 INDICATIF             PIC 9(03).
       01 TEL                   PIC 9(10).
       01 CODE-POSTAL           PIC 9(05).
       01 VILLE                 PIC X(80).
       01 ADRESSE               PIC X(160).

       PROCEDURE DIVISION USING NOM,
                                EMAIL,
                                INDICATIF,
                                TEL,
                                CODE-POSTAL,
                                VILLE,
                                ADRESSE.

           EXIT PROGRAM.