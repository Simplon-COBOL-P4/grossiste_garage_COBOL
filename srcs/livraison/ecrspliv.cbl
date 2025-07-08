      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; SP=SUPPRIMER; LIV=LIVRAISON;                        *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrspliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT             PIC 9(10).
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
       COPY lirret REPLACING ==:PREFIX:== BY ==WS==.

       PROCEDURE DIVISION.

           CALL "liridliv"
               USING
               IDENTIFIANT
               DATE
               STATUT
               TYPE
               IDENTIFIANT-SORTIE
               NOM-SORTIE
               WS-LIR-RET
           END-CALL.

      * Avant de supprimer une livraison, vérifier qu'elle est bien
      * en cours.

      * Dans le cas d'une livraison sortante, inverser les operations
      * avant de la supprimer.
           
           CALL "supliv"
               USING
               IDENTIFIANT
           END-CALL.

           EXIT PROGRAM.