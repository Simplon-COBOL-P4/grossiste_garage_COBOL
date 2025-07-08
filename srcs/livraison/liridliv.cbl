      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * LIR=LIRE; ID=IDENTIFIANT; LIV=LIVRAISON;                       *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. liridliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT             PIC 9(10).

      * Arguments de sortie.
       01 DATE                    PIC X(10).
       01 STATUT                  PIC 9(01).
           88 STATUT-EN-COURS               VALUE 0.
           88 STATUT-TERMINE                VALUE 1.
       01 TYPE                    PIC 9(01).
           88 TYPE-ENTRANTE                 VALUE 0.
           88 TYPE-SORTANTE                 VALUE 1.
      * Identifiant et nom fournisseur si entrante,
      * et client si sortante.
       01 IDENTIFIANT-SORTIE      PIC 9(10).
       01 NOM-SORTIE              PIC X(50).
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING IDENTIFIANT,
                                DATE,
                                STATUT,
                                TYPE,
                                IDENTIFIANT-SORTIE,
                                NOM-SORTIE,
                                LK-LIR-RET.

           EXIT PROGRAM.