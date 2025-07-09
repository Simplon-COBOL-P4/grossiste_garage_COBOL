      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * LE PROGRAMME QUI AJOUTE UN FOURNISSEUR À LA BDD                *
      *                                                                *
      *                           TRIGRAMMES                           *
      * ADR=ADRESSE; AJU=AJOUT; CDP=CODE-POSTAL; DEP=DEPLACER;         *
      * EML=EMAIL; ERR=ERREUR; FOU=FOURNISSEUR; IND=INDICATIF;         *
      * TEL=TELEPHONE; VAR=VARIABLE; VIL=VILLE; RET=RETOUR;            *
      ******************************************************************
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ajufou.
       AUTHOR. Anaisktl.
       DATE-WRITTEN. 08-07-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NOM                   PIC X(50).
       01 PG-ADR                   PIC X(50).
       01 PG-VIL                   PIC X(50).
       01 PG-CDP                   PIC 9(05).
       01 PG-IND                   PIC 9(03).
       01 PG-TEL                   PIC 9(10).
       01 PG-EML                   PIC X(50).
       EXEC SQL END DECLARE SECTION END-EXEC.
       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Arguments d'entrée.
       01 LK-NOM                   PIC X(50).
       01 LK-ADR                   PIC X(50).
       01 LK-VIL                   PIC X(50).
       01 LK-CDP                   PIC 9(05).
       01 LK-IND                   PIC 9(03).
       01 LK-TEL                   PIC 9(10).
       01 LK-EML                   PIC X(50).
      * Arguments de sortie.
       COPY ajuret REPLACING ==:PREFIX:== BY ==LK==.

       PROCEDURE DIVISION USING LK-NOM,
                                LK-ADR,
                                LK-VIL,
                                LK-CDP,
                                LK-IND,
                                LK-TEL,
                                LK-EML,
                                LK-AJU-RET.


           PERFORM 0100-AJT-FOU-DEB
              THRU 0100-AJT-FOU-FIN.


           EXIT PROGRAM.


      ******************************************************************
      ****************************PARAGRAPHES***************************
      
       0100-AJT-FOU-DEB.
           PERFORM 0105-DEP-LES-VAR-DEB
              THRU 0105-DEP-LES-VAR-FIN.

       EXEC SQL
           INSERT INTO public.fournisseur (nom_fou, adresse_fou, 
                       ville_fou, cp_fou, tel_fou, mail_fou, indic_four)
           VALUES (:PG-NOM, :PG-ADR, :PG-VIL, :PG-CDP, :PG-TEL, :PG-EML,
                   :PG-IND)
       END-EXEC.

           IF SQLCODE = 0 THEN
               SET LK-AJU-RET-OK TO TRUE

               EXEC SQL COMMIT END-EXEC

           ELSE 
               SET LK-AJU-RET-ERR TO TRUE

           END-IF.
       0100-AJT-FOU-FIN.

       0105-DEP-LES-VAR-DEB.
           MOVE LK-NOM    TO PG-NOM.
           MOVE LK-ADR    TO PG-ADR.
           MOVE LK-VIL    TO PG-VIL.
           MOVE LK-CDP    TO PG-CDP.
           MOVE LK-TEL    TO PG-TEL.
           MOVE LK-EML    TO PG-EML.
           MOVE LK-IND    TO PG-IND.
       0105-DEP-LES-VAR-FIN.
