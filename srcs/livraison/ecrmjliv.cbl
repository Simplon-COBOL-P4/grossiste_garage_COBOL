      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; MJ=MISE A JOUR; LIV=LIVRAISON;                      *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT-LIVRAISON   PIC 9(10).
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
       COPY majret REPLACING ==:PREFIX:== BY ==WS==.

       01 RETOUR-LECTURE          PIC 9(01).
           88 RETOUR-DONNEE-LUE                VALUE 0.
           88 RETOUR-FIN-LECTURE               VALUE 1.

       01 IDENTIFIANT-PIECE       PIC 9(10).
       01 QUANTITE-PIECE          PIC 9(10).
       01 TYPE-CHANGEMENT         PIC 9(01).
           88 CHANGEMENT-AJOUT              VALUE 0.
           88 CHANGEMENT-RETRAIT            VALUE 1.

      *SCREEN SECTION.
      *COPY ecrprn.

       PROCEDURE DIVISION.

           CALL "liridliv"
               USING
      * Arguments d'entrée
               IDENTIFIANT-LIVRAISON
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

           CALL "majliv"
               USING
      * Arguments d'entrée
               IDENTIFIANT-LIVRAISON
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               WS-MAJ-RET
      * Fin des arguments de sortie
           END-CALL.

           IF TYPE-ENTRANTE THEN
               PERFORM
                   CALL "fetlivpi"
                       USING
      * Arguments d'entrée
                       IDENTIFIANT-LIVRAISON
      * Fin des arguments d'entrée
      * Début des arguments de sortie
                       IDENTIFIANT-PIECE
                       QUANTITE-PIECE
                       RETOUR-LECTURE
      * Fin des arguments de sortie
                   END-CALL

                   CALL "majpie"
                       USING
                       IDENTIFIANT-PIECE
                       QUANTITE-PIECE
                       TYPE-CHANGEMENT
                   END-CALL
               END-PERFORM
           END-IF.

           EXIT PROGRAM.