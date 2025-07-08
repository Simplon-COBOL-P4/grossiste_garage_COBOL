      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * MAJ=MISE A JOUR; LIV=LIVRAISON;                                *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. majliv.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 IDENTIFIANT             PIC 9(10).
      * Arguments de sortie.
       COPY majret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING IDENTIFIANT,
                                LK-MAJ-RET.

           EXIT PROGRAM.