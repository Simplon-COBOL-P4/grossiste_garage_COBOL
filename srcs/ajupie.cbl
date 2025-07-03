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
       DATE-WRITTEN. 03-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *    Déclaration des variables pour le EXEC SQL.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  PG-PIE-NOM                   PIC X(80).
       01  PG-PIE-QTE                   PIC 9(10).
       01  PG-PIE-MIN                   PIC 9(10).
       01  PG-ID-FOU                    PIC 9(10).      
    
    
      *    Déclaration des variables pour la connexion à la BDD.
       01  PG-UTI                       PIC X(30) VALUE "postgres".
       01  PG-MDP                       PIC X(30) VALUE "mdp".
       01  PG-BDD                       PIC X(10) VALUE "logiparts".
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01  LK-PIE-NOM                   PIC X(80).
       01  LK-PIE-QTE                   PIC 9(10).
       01  LK-PIE-MIN                   PIC 9(10).
       01  LK-ID-FOU                    PIC 9(10).

       PROCEDURE DIVISION USING LK-PIE-NOM,
                                LK-PIE-QTE,
                                LK-PIE-MIN,
                                LK-ID-FOU.


      *    Paragraphe pour la connexion à la BDD. 
           PERFORM 0100-CNX-BDD-DEB
              THRU 0100-CNX-BDD-FIN.
           
      *    Paragraphe pour l'ajout de pièces à la BDD.
           PERFORM 0200-AJU-PIE-DEB
              THRU 0200-AJU-PIE-FIN.

      *    Paragraphe pour le commit.
           PERFORM 0300-COM-DEB
              THRU 0300-COM-FIN.
       
           EXIT PROGRAM.

      *    Paragraphe pour la connexion, génère un SQLCODE pour les
      *    erreurs.
       0100-CNX-BDD-DEB.
           EXEC SQL
                CONNECT :PG-UTI IDENTIFIED BY :PG-MDP 
                USING :PG-BDD
           END-EXEC.
              IF SQLCODE NOT EQUAL 0
                   EXIT PROGRAM
                   END-IF.

      *    Sortie de paragraphe.
       0100-CNX-BDD-FIN.
           EXIT.

      *    Paragraphe pour l'ajout de pièces.
       0200-AJU-PIE-DEB.         

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
       0200-AJU-PIE-FIN.
           EXIT.
      
      *    Parapgraphe COMMIT pour la requête SQL.
       0300-COM-DEB.
           EXEC SQL COMMIT END-EXEC.
           IF SQLCODE NOT EQUAL 0
                   EXIT PROGRAM
                   END-IF.

      *    Sortie de paragraphe.
       0300-COM-FIN.
           EXIT.
