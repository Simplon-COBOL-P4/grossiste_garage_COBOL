      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * ECR=ECRAN; RE=RECHERCHE; CLI=CLIENT;                           *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ecrrecli.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 IDENTIFIANT       PIC 9(10).
       01 NOM               PIC X(80).
       01 EMAIL             PIC X(160).
       01 INDICATIF         PIC 9(03).
       01 TEL               PIC 9(10).
       01 CODE-POSTAL       PIC 9(05).
       01 VILLE             PIC X(80).
       01 ADRESSE           PIC X(160).
       
       PROCEDURE DIVISION.
           
           CALL "liridcli"
               USING
      * Arguments d'entrée
               IDENTIFIANT
      * Arguments de sortie
               NOM
               EMAIL
               INDICATIF
               TEL
               CODE-POSTAL
               VILLE
               ADRESSE
           END-CALL.

           CALL "lirnmcli"
               USING
      * Arguments d'entrée
               NOM
      * Arguments de sortie
               IDENTIFIANT
               EMAIL
               INDICATIF
               TEL
               CODE-POSTAL
               VILLE
               ADRESSE
           END-CALL.

           EXIT PROGRAM.