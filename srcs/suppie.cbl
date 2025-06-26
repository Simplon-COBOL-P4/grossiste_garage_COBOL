      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * suppie                                                         *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * SUPPRIMER=SUP; PIECE=PIE                                       *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. suppie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT           PIC 9(10).

       PROCEDURE DIVISION USING IDENTIFIANT.

           EXIT PROGRAM.