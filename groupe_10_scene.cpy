        AJOUT_SCENE.
        OPEN I-O fscenes
        MOVE WidUtilisateurConnecte TO fs_id_utilisateur
        READ fscenes, key is fs_id_utilisateur
                INVALID KEY     MOVE 1 TO Wajoutpossible
                NOT INVALID KEY MOVE 0 TO Wajoutpossible
        END-READ
        
        IF Wajoutpossible = 1
           THEN
                MOVE 1 TO Wtrouve
                PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
                  DISPLAY "Id Scène :"
                  ACCEPT WidScene
                  MOVE WidScene TO fs_id 
                
                  READ fscenes
                    INVALID KEY
                          DISPLAY " "
                          MOVE 0 TO Wtrouve
                    NOT INVALID KEY
                          MOVE 1 TO Wtrouve
                          DISPLAY "⚠️ Id déjà utilisé ! ⚠️"
                  END-READ
                END-PERFORM
                
                DISPLAY "Nom"
                ACCEPT fs_nom
                DISPLAY "nb Place"
                ACCEPT fs_nb_place
                DISPLAY "Genre"
                ACCEPT fs_genre
                
                WRITE tamp_fscenes
                END-WRITE
        END-IF
        CLOSE fscenes.


        LISTE_SCENES.

        OPEN INPUT fscenes
        MOVE 0 TO Wfin
        PERFORM WITH TEST AFTER UNTIL Wfin = 1
                READ fscenes
                AT END      MOVE 1 TO Wfin
                NOT AT END  DISPLAY "ID : "fs_id
                            DISPLAY "Nom : "fs_nom
                            DISPLAY "Nombre de places : "fs_nb_place
                            DISPLAY "Genre : "fs_genre
                            DISPLAY "ID Utilisateur : "fs_id_utilisateur
                END-READ
        END-PERFORM

        CLOSE fscenes.
        
        LISTES_SCENES_PAR_GENRE.

        DISPLAY "Veuillez saisir le genre des scenes a chercher"
        ACCEPT Wgenre

        OPEN INPUT fscenes
        MOVE Wgenre TO fs_genre
        START fscenes KEY IS = fs_genre
        INVALID KEY DISPLAY "pas de scenes"
        NOT INVALID KEY
                PERFORM WITH TEST AFTER UNTIL Wfin = 0
                READ fscenes NEXT
                AT END MOVE 0 TO Wfin
                NOT AT END      IF fs_genre = Wgenre
                                    THEN DISPLAY fs_nom
                                ELSE MOVE 0 TO Wfin
                                END-IF
                END-READ
                END-PERFORM
        END-START

        CLOSE fscenes.


        RECHERCHE_SCENE.

        DISPLAY "que voulez vous utiliser pour chercher la scene"
        DISPLAY "1-Recherche par id"
        DISPLAY "2-Recherche par nom"
        DISPLAY "3-Recherche avec l'id utilisateur du responsable de la scene"
        DISPLAY "4-Recherche avec le genre de la scene"
        ACCEPT WtypeSearch
        OPEN INPUT fscenes
        IF WtypeSearch = 1
          THEN PERFORM RECHERCHE_PAR_ID
          ELSE IF WtypeSearch = 2
            THEN PERFORM RECHERCHE_PAR_NOM
            ELSE IF WtypeSearch = 3
              THEN PERFORM RECHERCHE_PAR_ID_USER
                ELSE IF WtypeSearch = 4
                  THEN PERFORM LISTES_SCENES_PAR_GENRE
            END-IF
          END-IF
        END-IF
        MOVE 0 TO WtypeSearch
        CLOSE fscenes.


        RECHERCHE_PAR_ID.
        OPEN INPUT fscenes
        DISPLAY "Veuillez saisir l'id de la scene a chercher"
        ACCEPT fs_id
        READ fscenes
          INVALID KEY     DISPLAY "inexistant"
          NOT INVALID KEY DISPLAY "ID : "fs_id
                          DISPLAY "Nom : "fs_nom
                          DISPLAY "Nombre de places : "fs_nb_place
                          DISPLAY "Genre : "fs_genre
                          DISPLAY "ID Utilisateur : "fs_id_utilisateur
        END-READ
        CLOSE fscenes.

        RECHERCHE_PAR_NOM.
        OPEN INPUT fscenes
        DISPLAY "Veuillez saisir le nom de la scene a chercher"
        ACCEPT fs_nom
        READ fscenes, key is fs_nom
          INVALID KEY     DISPLAY "inexistant"
          NOT INVALID KEY DISPLAY "ID : "fs_id
                          DISPLAY "Nom : "fs_nom
                          DISPLAY "Nombre de places : "fs_nb_place
                          DISPLAY "Genre : "fs_genre
                          DISPLAY "ID Utilisateur : "fs_id_utilisateur
        END-READ
        CLOSE fscenes.

        RECHERCHE_PAR_ID_USER.
        OPEN INPUT fscenes
        DISPLAY "Veuillez saisir l'id de "WITH NO ADVANCING
        DISPLAY "l'utilisateur correspondant a la scene a chercher"
        ACCEPT fs_id_utilisateur
        READ fscenes, key is fs_id_utilisateur
          INVALID KEY     DISPLAY "inexistant"
          NOT INVALID KEY DISPLAY "ID : "fs_id
                          DISPLAY "Nom : "fs_nom
                          DISPLAY "Nombre de places : "fs_nb_place
                          DISPLAY "Genre : "fs_genre
                          DISPLAY "ID Utilisateur : "fs_id_utilisateur
        END-READ
        CLOSE fscenes.
        
        STAT_OCCUPATION_SCENES_JOUR.
       OPEN INPUT fconcerts
       DISPLAY "Veuillez saisir l'id de la scene"
       DISPLAY " "
       PERFORM AFFICHAGE_SCENES
       ACCEPT fc_id_scene
       DISPLAY "Veuillez saisir un jour (samedi,dimanche ou lundi)"
       PERFORM WITH TEST AFTER UNTIL WjourConcert = "vendredi" OR
       WjourConcert = "samedi" OR WjourConcert = "dimanche"
                ACCEPT WjourConcert
       END-PERFORM
       MOVE 0 TO Wfin
       MOVE 0 TO WsA 
       PERFORM WITH TEST AFTER UNTIL Wfin = 1 
              READ fconcerts
              AT END MOVE 1 TO Wfin 
              NOT AT END IF fc_jour = WjourConcert  THEN
                         ADD 1 TO WsA
              END-READ
       END-PERFORM
       DISPLAY "Scene  :" 
       DISPLAY " "
       DIVIDE WsA BY 7 GIVING WsA
       MOVE 100 TO Wcent
       MULTIPLY WsA BY Wcent GIVING WsA
       DISPLAY "Taux d'occupation de la scene demandé :" WgA  "%" 
       CLOSE fconcerts.

