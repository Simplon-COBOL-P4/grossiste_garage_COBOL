      ******************************************************************
      *                             ENTÊTE                             *
      *    C'est un programme qui appelle 'ajupie' pour ajouter des    *
      *    pièces à la base de données.                                *
      *                                                                *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      *    AJOUT=AJU; PIE=PIECE; QTE=QUANTITE; MIN=MINIMUM;            *
      *    FOU=FOURNISSEUR; APL=APPEL;                                 *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. spajupie.
       AUTHOR. siboryg.
       DATE-WRITTEN. 03-07-2025 (fr).

       DATA DIVISION.
      *    Déclaration des variables. 
       WORKING-STORAGE SECTION.
       01  WS-PIE-NOM                   PIC X(80).
       01  WS-PIE-QTE                   PIC 9(10).
       01  WS-PIE-MIN                   PIC 9(10).
       01  WS-ID-FOU                    PIC 9(10).

       PROCEDURE DIVISION.
      *    Enregistrement des données pour tester l'ajout.
           DISPLAY "Saisie du nom de la pièce :".
           ACCEPT WS-PIE-NOM.

           DISPLAY "Saisie de la quantité de pièces :".
           ACCEPT WS-PIE-QTE.
           MOVE FUNCTION NUMVAL(WS-PIE-QTE) TO WS-PIE-QTE.

           DISPLAY "Saisie du seuil minimum de pièces :".
           ACCEPT WS-PIE-MIN.
           MOVE FUNCTION NUMVAL(WS-PIE-MIN) TO WS-PIE-MIN.

           DISPLAY "Saisie de l'ID du fournisseur :".
           ACCEPT WS-ID-FOU.
           MOVE FUNCTION NUMVAL(WS-ID-FOU) TO WS-ID-FOU.

      *    Paragraphe pour l'ajout des pièces.
           PERFORM 0100-APL-PIE-DEB
              THRU 0100-APL-PIE-FIN.
           
           STOP RUN.

      *    Paragraphe pour l'ajout des pièces, notamment avec la 
      *    fonction CALL.
       0100-APL-PIE-DEB.
           CALL 'ajupie' 
               USING WS-PIE-NOM
                     WS-PIE-QTE 
                     WS-PIE-MIN 
                     WS-ID-FOU
           END-CALL.

      *    Sortie de paragraphe.
       0100-APL-PIE-FIN.
           EXIT.
      