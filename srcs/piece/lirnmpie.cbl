      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; NM=NOM; PIE=PIECE;                                    *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirnmpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 NOM                  PIC X(50).

      * Arguments de sortie.
       01 IDENTIFIANT          PIC 9(10).
       01 SEUIL                PIC 9(10).
       01 ID-FOUR              PIC 9(10).
       01 NOM-FOUR             PIC X(50).

       PROCEDURE DIVISION USING NOM,
                                IDENTIFIANT,
                                SEUIL,
                                ID-FOUR,
                                NOM-FOUR.

           EXIT PROGRAM.