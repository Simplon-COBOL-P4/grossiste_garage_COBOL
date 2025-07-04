      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; RE=RECHERCHE; PIE=PIECE;                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrrepie.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT          PIC 9(10).
       01 NOM                  PIC X(50).
       01 SEUIL                PIC 9(10).
       01 POUBELLE             PIC 9(10).
       01 NOM-FOUR             PIC X(50).

       PROCEDURE DIVISION.

           CALL "lirnmpie"
               USING
      * Arguments d'entrée
               NOM
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               IDENTIFIANT
               SEUIL
      * Argument non utilisé, obligé de le mettre quand même.
               POUBELLE
               NOM-FOUR
      * Fin des arguments de sortie
           END-CALL.

           CALL "liridpie"
               USING
      * Arguments d'entrée
               IDENTIFIANT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               NOM
               SEUIL
      * Argument non utilisé, obligé de le mettre quand même.
               POUBELLE
               NOM-FOUR
      * Fin des arguments de sortie
           END-CALL.

           EXIT PROGRAM.