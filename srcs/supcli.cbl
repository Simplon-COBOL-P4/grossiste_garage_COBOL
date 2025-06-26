      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * supcli                                                         *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * SUPPRIMER=SUP; CLIENT=CLI;                                     *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. supcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT           PIC 9(10).

       PROCEDURE DIVISION USING IDENTIFIANT.

           EXIT PROGRAM.