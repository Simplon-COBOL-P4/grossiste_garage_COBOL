      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Morceau d'ecran qui affiche le type d'utilisateur connecte.    *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * UTI=UTILISATEUR; G=GLOBAL; RLE=ROLE;                           *
      ****************************************************************** 
       05 LINE 04.
           10 COL 03 VALUE "Connecte en tant que : ".
           10 COL 26 FROM G-UTI-RLE.