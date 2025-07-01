      ******************************************************************
      *                             ENTÊTE                             *
      *  Programme vérifiant qu'un mail est correct, sera vérifier la  *
      *  présence d'un unique "@", d'au moins un '.'                   *
      *                                                                *
      *                           TRIGRAMMES                           *
      * VER=VERIFICATION; EMA=EMAIL; ARO=arobase; POI=point; RET=retour*
      * VAL=valeur; TRO=trop                                           *
      *                                                                *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. verema.
       AUTHOR. lucas.
       DATE-WRITTEN. 01/07/2025 (fr).

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       
      * Le nombre d'"@" dans l'adresse-mail.  
       01  WS-NB-ARO PIC 9(02).

      * Le nombre de "." dans l'adresse-mail. 
       01  WS-NB-POI PIC 9(02).

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-EMA                 PIC X(160).
      * Arguments de sortie.
       01 LK-VAL-RET             PIC 9(01).
           88 LK-RET-OK                   VALUE 0.
           88 LK-RET-TRO-DE-ARO           VALUE 1.
           88 LK-RET-PAS-DE-ARO           VALUE 2.
           88 LK-RET-PAS-DE-POI           VALUE 3.


       PROCEDURE DIVISION USING LK-EMA,
                                LK-VAL-RET.

           PERFORM 0100-CAL-DEB
              THRU 0100-CAL-FIN.

           PERFORM 0200-RES-DEB
              THRU 0200-RES-FIN



           EXIT PROGRAM.

      * Paragraphe pour compter les "@" et "." dans le mail.
       0100-CAL-DEB.
           INSPECT LK-EMA TALLYING WS-NB-ARO FOR ALL "@".
           INSPECT LK-EMA TALLYING WS-NB-POI FOR ALL ".".
       0100-CAL-FIN.

      * Paragraphe qui renvoie le code d'erreur au programme appelant.
       0200-RES-DEB.
           IF WS-NB-ARO GREATER THAN 1
              SET LK-RET-TRO-DE-ARO TO TRUE
           ELSE 
              IF WS-NB-ARO EQUAL 0
                 SET LK-RET-PAS-DE-ARO TO TRUE
              ELSE 
                 IF WS-NB-POI EQUAL 0
                    SET LK-RET-PAS-DE-POI TO TRUE
                 ELSE 
                    SET LK-RET-OK         TO TRUE
                 END-IF
              END-IF                     
           END-IF.
       0200-RES-FIN.
