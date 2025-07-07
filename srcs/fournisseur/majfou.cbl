      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * MAJ=MISE A JOUR; FOU=FOURNISSEUR;                              *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. majfou.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT           PIC 9(10).
       01 NOM                   PIC X(50).
       01 ADRESSE               PIC X(50).
       01 VILLE                 PIC X(50).
       01 CODE-POSTAL           PIC 9(05).
       01 INDICATIF             PIC 9(03).
       01 TELEPHONE             PIC 9(10).
       01 EMAIL                 PIC X(50).

      * Arguments de sortie.

       COPY majret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING IDENTIFIANT,
                                NOM,
                                ADRESSE,
                                VILLE,
                                CODE-POSTAL,
                                INDICATIF,
                                TELEPHONE,
                                EMAIL,
                                LK-MAJ-RET.

           EXIT PROGRAM.
