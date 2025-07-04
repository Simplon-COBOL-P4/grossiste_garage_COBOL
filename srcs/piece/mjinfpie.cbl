      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * MJ=MISE A JOUR; INF=INFO; PIE=PIECE;                           *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. mjinfpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT          PIC 9(10).
       01 NOM                  PIC X(50).
       01 SEUIL                PIC 9(10).
       01 ID-FOUR              PIC 9(10).

       PROCEDURE DIVISION USING IDENTIFIANT,
                                NOM,
                                SEUIL,
                                ID-FOUR.

           EXIT PROGRAM.