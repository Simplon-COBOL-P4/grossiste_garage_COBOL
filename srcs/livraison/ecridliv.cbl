      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; ID=IDENTIFIANT; LIV=LIVRAISON;                      *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecridliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT             PIC 9(10).
       01 WS-DATE                 PIC X(10).
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

       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       01 NOMBRE-LIVRAISON-PIECE  PIC 9(10).

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.

           CALL "liridliv"
               USING
      * Arguments d'entrée
               IDENTIFIANT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-DATE
               STATUT
               TYPE
               IDENTIFIANT-SORTIE
               NOM-SORTIE
               WS-LIR-RET
      * Fin des arguments de sortie
           END-CALL.

           EXIT PROGRAM.