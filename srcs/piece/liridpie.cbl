      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; ID=IDENTIFIANT; PIE=PIECE                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridpie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT          PIC 9(10).

      * Arguments de sortie.
       01 NOM                  PIC X(50).
       01 SEUIL                PIC 9(10).
       01 ID-FOUR              PIC 9(10).
       01 NOM-FOUR             PIC X(50).

       PROCEDURE DIVISION USING IDENTIFIANT,
                                NOM,
                                SEUIL,
                                ID-FOUR,
                                NOM-FOUR.

           EXIT PROGRAM.