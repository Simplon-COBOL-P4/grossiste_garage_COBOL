      ******************************************************************
      * Ce programme rechercher un client par son nom                  *
      * et retourner ses informations au programme appelant.           *
      *                                                                *
      * Trigrammes :                                                   *
      * CLIENT=CLI; ADRESSE=ADR; VILLE=VIL;                            *
      * CODEPOSTAL=CP; TELEPHONE=TEL; MAIL=ML; INDICATIF=IND;          *
      * STATUT=STA.                                                    *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. reclinom.
       AUTHOR. Yassine.
       DATE-WRITTEN. 27-06-2025.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Ces variables servent à stocker les infos du client qu'on
      * récupère depuis la base de données (zone de travail WS).
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 PG-NOM-CLI       PIC X(050).
       01 PG-IDT-CLI       PIC 9(009).
       01 PG-ADR-CLI       PIC X(100).
       01 PG-VIL-CLI       PIC X(050).
       01 PG-CP-CLI        PIC X(010).
       01 PG-TEL-CLI       PIC X(020).
       01 PG-ML-CLI        PIC X(050).
       01 PG-IND-CLI       PIC X(010).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Ces variables viennent du programme qui fait le CALL.
      * Elles contiennent l'identifiant en entrée et recevront 
      * les infos en sortie.
       01 LK-NOM-CLI       PIC X(050).
       01 LK-IDT-CLI       PIC 9(009).
       01 LK-ADR-CLI       PIC X(100).
       01 LK-VIL-CLI       PIC X(050).
       01 LK-CP-CLI        PIC X(010).
       01 LK-TEL-CLI       PIC X(020).
       01 LK-ML-CLI        PIC X(050).
       01 LK-IND-CLI       PIC X(010).
       01 LK-STA-CLI       PIC X(030).

       PROCEDURE DIVISION USING LK-NOM-CLI LK-IDT-CLI LK-ADR-CLI
                                LK-VIL-CLI LK-CP-CLI LK-TEL-CLI
                                LK-ML-CLI LK-IND-CLI LK-STA-CLI.

           PERFORM 0100-REC-CLI-NOM-DEB
              THRU 0100-REC-CLI-NOM-FIN.

           EXIT PROGRAM.

      ******************************************************************
      *              RECUPERATION DU CLIENT PAR NOM                    *
      ******************************************************************
       0100-REC-CLI-NOM-DEB.

      * On récupère le nom entré par le programme appelant.
           MOVE LK-NOM-CLI TO PG-NOM-CLI.

      * On exécute la requête pour récupérer les infos du client dans 
      * la base de donnée.
           EXEC SQL
               SELECT id_cli,
                      adresse_cli,
                      ville_cli,
                      cp_cli,
                      tel_cli,
                      mail_cli,
                      indic_cli
               INTO   :PG-IDT-CLI,
                      :PG-ADR-CLI,
                      :PG-VIL-CLI,
                      :PG-CP-CLI,
                      :PG-TEL-CLI,
                      :PG-ML-CLI,
                      :PG-IND-CLI
               FROM   client
               WHERE  nom_cli = :PG-NOM-CLI
           END-EXEC.
      * Si le client est trouvé on copie les infos vers la 
      * LINKAGE SECTION pour les récuperer dans le programme appelant.
           IF SQLCODE = 0
               MOVE PG-IDT-CLI           TO LK-IDT-CLI
               MOVE PG-ADR-CLI           TO LK-ADR-CLI
               MOVE PG-VIL-CLI           TO LK-VIL-CLI
               MOVE PG-CP-CLI            TO LK-CP-CLI
               MOVE PG-TEL-CLI           TO LK-TEL-CLI
               MOVE PG-ML-CLI            TO LK-ML-CLI
               MOVE PG-IND-CLI           TO LK-IND-CLI
               MOVE "CLIENT TROUVE"      TO LK-STA-CLI
           ELSE
               MOVE 0                    TO LK-IDT-CLI
               MOVE "CLIENT INTROUVABLE" TO LK-STA-CLI
           END-IF.

       0100-REC-CLI-NOM-FIN.
      ******************************************************************
      * Exemple pour appeler ce programme depuis un autre programme :  *
      *                                                                * 
      *     CALL 'recclinom'                                           *
      *            USING WS-NOM, WS-ID, WS-ADRESSE, WS-VILLE, WS-CP,   *
      *                  WS-TEL, WS-MAIL, WS-INDIC, WS-STATUT          *
      ******************************************************************
