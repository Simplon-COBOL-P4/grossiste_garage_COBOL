      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; AJ=AJOUT; LIV=LIVRAISON;                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrajliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DATE                 PIC X(10).
       01 STATUT                  PIC 9(01).
           88 STATUT-EN-COURS               VALUE 0.
           88 STATUT-TERMINE                VALUE 1.
       01 TYPE                    PIC 9(01).
           88 TYPE-ENTRANTE                 VALUE 0.
           88 TYPE-SORTANTE                 VALUE 1.
      * Identifiant fournisseur si entrante, et client si sortante.
       01 IDENTIFIANT             PIC 9(10).

       01 IDENTIFIANT-LIVRAISON   PIC 9(10).
       01 IDENTIFIANT-PIECE       PIC 9(10).
       01 QUANTITE-PIECE          PIC 9(10).

       COPY ajuret REPLACING ==:PREFIX:== BY ==WS==.

       PROCEDURE DIVISION.
            
           CALL "ajuliv"
               USING
      * Arguments d'entrée
               WS-DATE
               STATUT
               TYPE
               IDENTIFIANT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               IDENTIFIANT-LIVRAISON
               WS-AJU-RET
      * Fin des arguments de sortie
           END-CALL.

           CALL "ajulivpi"
               USING
               IDENTIFIANT-LIVRAISON
               IDENTIFIANT-PIECE
               QUANTITE-PIECE
               WS-AJU-RET
           END-CALL.

           EXIT PROGRAM.