      ******************************************************************
      * Programme qui lis un fournisseur depuis la BDD via son nom.    *
      * Le programme prend en paramètre le nom d’un fournisseur.       *
      * Il retourne toutes les données relatives à un fournisseur.     *
      *                                                                *
      * TRIGRAMMES :                                                   *
      * LIR=LIRE; FOU=FOURNISSEUR; IDT=IDENTIFIANT ; ADR=ADRESSE;      *
      * VIL=VILLE; CP=CODE-POSTAL; IND=INDICATIF; TEL=TELEPHONE;       *
      * EML=EMAIL; RET=RETOUR;                                         *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirnmfou.
       AUTHOR. Yassine.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
     
       EXEC SQL INCLUDE SQLCA END-EXEC.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NOM-FOU          PIC X(50).
       01 PG-IDT-FOU          PIC 9(10).
       01 PG-ADR-FOU          PIC X(50).
       01 PG-VIL-FOU          PIC X(50).
       01 PG-CP-FOU           PIC 9(05).
       01 PG-IND-FOU          PIC 9(03).
       01 PG-TEL-FOU          PIC 9(10).
       01 PG-EML-FOU          PIC X(50).
       EXEC SQL END DECLARE SECTION END-EXEC.

       LINKAGE SECTION.
      * Argument d'entrée
       01 LK-NOM-FOU          PIC X(50).

      * Arguments de sortie
       01 LK-IDT-FOU          PIC 9(10).
       01 LK-ADR-FOU          PIC X(50).
       01 LK-VIL-FOU          PIC X(50).
       01 LK-CP-FOU           PIC 9(05).
       01 LK-IND-FOU          PIC 9(03).
       01 LK-TEL-FOU          PIC 9(10).
       01 LK-EML-FOU          PIC X(50).

  
       COPY lirret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-NOM-FOU,
                                LK-IDT-FOU,
                                LK-ADR-FOU,
                                LK-VIL-FOU,
                                LK-CP-FOU,
                                LK-IND-FOU,
                                LK-TEL-FOU,
                                LK-EML-FOU,
                                LK-LIR-RET.

      ******************************************************************
      ********************   Programme principal   *********************
      ******************************************************************
           PERFORM 0100-LIR-FOU-NOM-DEB
              THRU 0100-LIR-FOU-NOM-FIN.

           EXIT PROGRAM.

      ******************************************************************
      ***********************   Lire fournisseur    ********************
      ******************************************************************
       0100-LIR-FOU-NOM-DEB.

      * Copier le nom entrée dans PG-NOM-FOU pour le chercher dans 
      * la base de donnée.
           MOVE LK-NOM-FOU TO PG-NOM-FOU.

           EXEC SQL
               SELECT id_fou,
                      adresse_fou,
                      ville_fou,
                      cp_fou,
                      indic_four,
                      tel_fou,
                      mail_fou
                 INTO :PG-IDT-FOU,
                      :PG-ADR-FOU,
                      :PG-VIL-FOU,
                      :PG-CP-FOU,
                      :PG-IND-FOU,
                      :PG-TEL-FOU,
                      :PG-EML-FOU
                 FROM fournisseur
                WHERE nom_fou = :PG-NOM-FOU
           END-EXEC.

   
           IF SQLCODE = 0
      * Si le fournisseur est trouvé, on renvoie ses infos vers
      * LINKAGE .
               MOVE PG-IDT-FOU    TO LK-IDT-FOU
               MOVE PG-ADR-FOU    TO LK-ADR-FOU
               MOVE PG-VIL-FOU    TO LK-VIL-FOU
               MOVE PG-CP-FOU     TO LK-CP-FOU
               MOVE PG-IND-FOU    TO LK-IND-FOU
               MOVE PG-TEL-FOU    TO LK-TEL-FOU
               MOVE PG-EML-FOU    TO LK-EML-FOU

               SET LK-LIR-RET-OK  TO TRUE
            ELSE
               SET LK-LIR-RET-ERR TO TRUE
           END-IF.

       0100-LIR-FOU-NOM-FIN.
           EXIT.
