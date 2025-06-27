      ******************************************************************
      * Ce programme recherche un client avec son identifiant          *
      * et renvoyer ses informations                                   *
      *                                                                *
      * Trigrammes :                                                   *
      * CLIENT=CLI; IDENTIFIANT=IDT; ADRESSE=ADR; VILLE=VIL;           *
      * CODEPOSTAL=CP; TELEPHONE=TEL; MAIL=ML; INDICATIF=IND;          *
      * STATUT=STA; LINKAGE=LK;                                        *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. reccli.
       AUTHOR. Yassine.
       DATE-WRITTEN. 26-06-2025 (fr).

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Ces variables servent à stocker les infos du client qu'on
      * récupère depuis la base de données (zone de travail WS)
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 WS-IDT-CLI       PIC 9(09).
       01 WS-NOM-CLI       PIC X(050).
       01 WS-ADR-CLI       PIC X(100).
       01 WS-VIL-CLI       PIC X(050).
       01 WS-CP-CLI        PIC X(010).
       01 WS-TEL-CLI       PIC X(020).
       01 WS-ML-CLI        PIC X(050).
       01 WS-IND-CLI       PIC X(010).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       LINKAGE SECTION.
      * Ces variables viennent du programme qui fait le CALL
      * Elles contiennent l'identifiant en entrée et recevront 
      * les infos en sortie
       01 LK-IDT-CLI       PIC 9(09).
       01 LK-NOM-CLI       PIC X(050).
       01 LK-ADR-CLI       PIC X(100).
       01 LK-VIL-CLI       PIC X(050).
       01 LK-CP-CLI        PIC X(010).
       01 LK-TEL-CLI       PIC X(020).
       01 LK-ML-CLI        PIC X(050).
       01 LK-IND-CLI       PIC X(010).
       01 LK-STA-CLI       PIC X(030).

       PROCEDURE DIVISION USING LK-IDT-CLI LK-NOM-CLI LK-ADR-CLI 
                                LK-VIL-CLI LK-CP-CLI  LK-TEL-CLI 
                                LK-ML-CLI  LK-IND-CLI LK-STA-CLI.

           PERFORM 0100-REC-CLI-DEB
              THRU 0100-REC-CLI-FIN.

           GOBACK.
      ******************************************************************
      *                    RECUPERATION DU CLIENT                      *
      ******************************************************************
       0100-REC-CLI-DEB.

      * On récupère l'identifiant du client depuis la LINKAGE SECTION.
           MOVE LK-IDT-CLI TO WS-IDT-CLI.

      * On exécute la requête SQL pour chercher le client dans la table
      * client
           EXEC SQL
               SELECT nom_cli,
                      adresse_cli,
                      ville_cli,
                      cp_cli,
                      tel_cli,
                      mail_cli,
                      indic_cli
               INTO   :WS-NOM-CLI,
                      :WS-ADR-CLI,
                      :WS-VIL-CLI,
                      :WS-CP-CLI,
                      :WS-TEL-CLI,
                      :WS-ML-CLI,
                      :WS-IND-CLI
               FROM   client
               WHERE  id_cli = :WS-IDT-CLI
           END-EXEC.

      * Si le client est trouvé on copie les infos vers la 
      * LINKAGE SECTION
           IF SQLCODE = 0
               MOVE WS-NOM-CLI TO LK-NOM-CLI
               MOVE WS-ADR-CLI TO LK-ADR-CLI
               MOVE WS-VIL-CLI TO LK-VIL-CLI
               MOVE WS-CP-CLI  TO LK-CP-CLI
               MOVE WS-TEL-CLI TO LK-TEL-CLI
               MOVE WS-ML-CLI  TO LK-ML-CLI
               MOVE WS-IND-CLI TO LK-IND-CLI
               MOVE "CLIENT TROUVE" TO LK-STA-CLI
           ELSE
               MOVE "CLIENT INTROUVABLE" TO LK-STA-CLI
           END-IF.

       0100-REC-CLI-FIN.
      
      ******************************************************************
      * Exemple pour appeler ce programme depuis un autre programme :  *
      *                                                                *
      *     CALL 'reccli'                                              *
      *           USING WS-ID WS-NOM WS-ADRESSE WS-VILLE WS-CP         *
      *                 WS-TEL WS-MAIL WS-INDIC WS-STATUT              *
      ******************************************************************
      