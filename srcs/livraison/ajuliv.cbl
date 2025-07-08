      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * AJU=AJOUT; LIV=LIVRAISON;                                      *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajuliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 DATE                    PIC X(10).
       01 STATUT                  PIC 9(01).
           88 STATUT-EN-COURS               VALUE 0.
           88 STATUT-TERMINE                VALUE 1.
       01 TYPE                    PIC 9(01).
           88 TYPE-ENTRANTE                 VALUE 0.
           88 TYPE-SORTANTE                 VALUE 1.
      * Identifiant fournisseur si entrante, et client si sortante.
       01 IDENTIFIANT             PIC 9(10).
      * Arguments de sortie.
       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING DATE,
                                STATUT,
                                TYPE,
                                IDENTIFIANT,
                                LK-AJU-RET.

           EXIT PROGRAM.