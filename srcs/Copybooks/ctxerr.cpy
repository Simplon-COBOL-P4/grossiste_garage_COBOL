      ******************************************************************
      *                              ENTETE                            *
      * Donne le contexte de la precedente entree utilisateur sur un   *
      * ecran.                                                         *
      *                                                                *
      *                            TRIGRAMMES :                        *
      * CTX=CONTEXTE; AFF=AFFICHER; ERR=ERREUR; MSG=MESSAGE;           *
      ******************************************************************
       01 WS-CTX                PIC 9(01).
           88 WS-CTX-OK                   VALUE 1.
           88 WS-CTX-AFF-ERR              VALUE 2.
       01 WS-MSG-ERR            PIC X(76).