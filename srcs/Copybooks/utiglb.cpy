      ******************************************************************
      *                             ENTÊTE                             *
      *                                                                *
      * Variables globales pour les infos de l'utilisateur connecte.   *
      *                                                                *
      *                           TRIGRAMMES                           *
      *                                                                *
      * UTI=UTILISATEUR; G=GLOBAL; ID=IDENTIFIANT; RLE=ROLE;           *
      ****************************************************************** 
       01 G-UTI EXTERNAL.
           05 G-UTI-NOM       PIC X(20).
           05 G-UTI-ID        PIC 9(10).
           05 G-UTI-RLE       PIC X(14).
