      ******************************************************************
      *                             ENTÊTE                             *
      * Ecran de mise a jour des infos d'une piece                     *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; MJ=MISE A JOUR; INF=INFO                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjinf.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT          PIC 9(10).
       01 NOM                  PIC X(50).
       01 SEUIL                PIC 9(10).
       01 ID-FOUR              PIC 9(10).

       PROCEDURE DIVISION.
       
           CALL "mjinfpie"
               USING
               IDENTIFIANT
               NOM
               SEUIL
               ID-FOUR
           END-CALL.

           EXIT PROGRAM.