      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * ajupie                                                         *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * AJOUT=AJU; PIE=PIECE                                            *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajupie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 NOM                   PIC X(80).
       01 QUANTITE              PIC 9(10).
       01 SEUIL                 PIC 9(10).
       01 ID-FOURNISSEUR        PIC 9(10).

       PROCEDURE DIVISION USING NOM,
                                QUANTITE,
                                SEUIL,
                                ID-FOURNISSEUR.

           EXIT PROGRAM.