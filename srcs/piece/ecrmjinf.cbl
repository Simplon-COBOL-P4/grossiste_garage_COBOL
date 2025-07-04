      ******************************************************************
      *                             ENTÊTE                             *
      * Ecran de mise a jour des infos d'une piece                     *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ECR=ECRAN; MJ=MISE A JOUR; INF=INFO                            *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrmjinf.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT          PIC 9(10).
       01 NOM                  PIC X(50).
       01 SEUIL                PIC 9(10).
       01 ID-FOUR              PIC 9(10).
       01 POUBELLE             PIC X(50).

       PROCEDURE DIVISION.

           CALL "liridpie"
               USING
      * Arguments d'entrée
               IDENTIFIANT
      * Fin des arguments d'entrée
      * Début des arguments de sortie
               NOM
               SEUIL
               ID-FOUR
      * Argument non utilisé, obligé de le mettre quand même.
               POUBELLE
      * Fin des arguments de sortie
           END-CALL.

           CALL "mjinfpie"
               USING
      * Arguments d'entrée
               IDENTIFIANT
               NOM
               SEUIL
               ID-FOUR
      * Fin des arguments d'entrée
           END-CALL.

           EXIT PROGRAM.