      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      *    Le programme principal qui va appeler le sous-programme     *
      *    'spajupie' pour l'ajout de pièces dans la BDD               *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      *    AJU=AJOUT; PIE=PIECE; QTE=QUANTITE; MIN=MINIMUM;            *
      *    FOU=FOURNISSEUR; APL=APPEL; CNX=CONNEXION;                  *
      *    SP=SOUS PROGRAMME; UTI=UTILISATEUR; COM=COMMIT              *
      *                                                                *
      ****************************************************************** 
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajupie.
       AUTHOR. siboryg.
       DATE-WRITTEN. 04-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *    Déclaration des variables pour le EXEC SQL.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-PIE-NOM                   PIC X(80).
       01  PG-PIE-QTE                   PIC 9(10).
       01  PG-PIE-MIN                   PIC 9(10).
       01  PG-ID-FOU                    PIC 9(10).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.
      

       LINKAGE SECTION.
      * Arguments d'entrée.
       01  LK-PIE-NOM                   PIC X(80).
       01  LK-PIE-QTE                   PIC 9(10).
       01  LK-PIE-MIN                   PIC 9(10).
       01  LK-ID-FOU                    PIC 9(10).

       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-PIE-NOM,
                                LK-PIE-QTE,
                                LK-PIE-MIN,
                                LK-ID-FOU,
                                LK-AJU-RET.

      *    Paragraphe pour l'ajout de pièces à la BDD.
           PERFORM 0100-AJU-PIE-DEB
              THRU 0100-AJU-PIE-FIN.

      *    Paragraphe pour le commit.
           PERFORM 0200-COM-DEB
              THRU 0200-COM-FIN.
       
           EXIT PROGRAM.

      *    Paragraphe pour l'ajout de pièces.
       0100-AJU-PIE-DEB.         

           MOVE LK-PIE-NOM TO PG-PIE-NOM.
           MOVE LK-PIE-QTE TO PG-PIE-QTE.
           MOVE LK-PIE-MIN TO PG-PIE-MIN.
           MOVE LK-ID-FOU  TO PG-ID-FOU.
      *    La requête SQL pour l'ajout de pièces.
           EXEC SQL 
           INSERT INTO piece (nom_pie, qt_pie, seuil_pie, id_fou)
           VALUES (
               :PG-PIE-NOM, 
               :PG-PIE-QTE, 
               :PG-PIE-MIN,
               :PG-ID-FOU
               )
           END-EXEC.

      *    Sortie de parapgraphe.
       0100-AJU-PIE-FIN.
      
      *    Parapgraphe COMMIT pour la requête SQL.
       0200-COM-DEB.
           EVALUATE SQLCODE
               WHEN 0
                   EXEC SQL COMMIT END-EXEC
                   SET LK-AJU-RET-OK TO TRUE

               WHEN -400
                   EXEC SQL ROLLBACK END-EXEC
                   SET LK-AJU-RET-FK-ERR TO TRUE

               WHEN OTHER
                   EXEC SQL ROLLBACK END-EXEC
                   SET LK-AJU-RET-ERR TO TRUE

           END-EVALUATE.
       0200-COM-FIN.
