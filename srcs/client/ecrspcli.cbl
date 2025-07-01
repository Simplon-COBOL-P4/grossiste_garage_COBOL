      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRESSION; CLI=CLIENT;                         *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspcli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT          PIC 9(10).

       PROCEDURE DIVISION.

           CALL "supcli"
               USING
               IDENTIFIANT
           END-CALL.

           EXIT PROGRAM.