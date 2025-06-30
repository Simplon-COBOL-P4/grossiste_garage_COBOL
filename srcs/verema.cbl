      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * VER=VERIFICATION; EMA=EMAIL;                                   *
      *                                                                *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. verema.
       AUTHOR. .
       DATE-WRITTEN. .

       DATA DIVISION.
       LINKAGE SECTION.
      * Arguments d'entrée.
       01 EMAIL                 PIC X(160).
      * Arguments de sortie.
       01 VALEUR-RETOUR         PIC 9(01).
           88 RETOUR-OK                   VALUE 0.
           88 RETOUR-TROP-DE-AROBASE      VALUE 1.
           88 RETOUR-PAS-DE-AROBASE       VALUE 2.
           88 RETOUR-PAS-DE-POINT         VALUE 3.

       PROCEDURE DIVISION USING EMAIL,
                                VALEUR-RETOUR.

           EXIT PROGRAM.