        AJOUT_CONCERT.
        
        
        
        OPEN INPUT fconcerts
        PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
                DISPLAY "Id Concert: " WITH NO ADVANCING
                ACCEPT WidConcert
                
                MOVE 0 TO Wtrouve
                
                MOVE WidConcert TO fc_id
                READ fconcerts
                  NOT INVALID KEY
                        MOVE 1 TO Wtrouve
                        DISPLAY "⚠️ Id déjà utilisé ! ⚠️"
                END-READ
        END-PERFORM
        CLOSE fconcerts
        
        IF WroleUtilisateurConnecte = 2 THEN
        
                MOVE WidSceneUtilisateurConnecte TO WidScene
        
        ELSE
        
                PERFORM AFFICHAGE_SCENES
        
                OPEN INPUT fscenes
                PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
                        DISPLAY "Choix de la scène: " WITH NO ADVANCING
                        ACCEPT WidScene
                        MOVE 0 TO Wtrouve
                        MOVE WidScene TO fs_id
                        READ fscenes
                          NOT INVALID KEY
                                MOVE 1 TO Wtrouve
                          INVALID KEY
                                MOVE 0 TO Wtrouve
                                DISPLAY "⚠️ Id de scène inexistant ! ⚠️"
                        END-READ
                END-PERFORM
        
        END-IF
        
        
        
        DISPLAY " "
        
        MOVE WidScene TO WparamIdScene
        MOVE "vendredi" TO WparamJour
        PERFORM AFFICHAGE_CRENEAUX_SCENE_JOUR
        DISPLAY " "
        MOVE "samedi" TO WparamJour
        PERFORM AFFICHAGE_CRENEAUX_SCENE_JOUR
        DISPLAY " "
        MOVE "dimanche" TO WparamJour
        PERFORM AFFICHAGE_CRENEAUX_SCENE_JOUR
        DISPLAY " "
        
        PERFORM WITH TEST AFTER UNTIL WjourConcert = "vendredi" OR
        WjourConcert = "samedi" OR WjourConcert = "dimanche"
                DISPLAY "Jour (vendredi, samedi," WITH NO ADVANCING
                DISPLAY " dimanche): " WITH NO ADVANCING
                ACCEPT WjourConcert
                
        END-PERFORM
        CLOSE fscenes
        OPEN INPUT fscenes
        MOVE WidScene TO fs_id
        READ fscenes INTO fs_id
                NOT INVALID KEY
                        MOVE fs_genre TO WparamGenre
        END-READ
        
        PERFORM AFFICHAGE_GROUPE_GENRE
        
        IF Wcompteur <> 0 THEN
                PERFORM WITH TEST AFTER UNTIL Wtrouve = 1
                      DISPLAY "Id du groupe pour ce concert: " WITH NO ADVANCING
                      ACCEPT WidGroupe
                      MOVE WidGroupe TO fg_id
                      OPEN INPUT fgroupes
                      READ fgroupes INTO fg_id
                        INVALID KEY
                                DISPLAY "⚠️ Id de groupe inexistant ! ⚠️"
                        NOT INVALID KEY
                                IF fg_genre = WparamGenre THEN
                                     MOVE 1 TO Wtrouve
                                ELSE
                                     DISPLAY "⚠️ Groupe avec mauvais genre ! ⚠️"
                                END-IF
                      END-READ
                      CLOSE fgroupes
                END-PERFORM
                
                OPEN I-O fconcerts
                
                PERFORM WITH TEST AFTER UNTIL Wtrouve = 0
                        
                        MOVE 0 TO WheureDebut
                
                        PERFORM WITH TEST AFTER UNTIL (WheureDebut = 10 OR
                        WheureDebut = 12
                        OR WheureDebut = 14
                        OR WheureDebut = 16
                        OR WheureDebut = 18
                        OR WheureDebut = 20
                        OR WheureDebut = 22)
                                
                          IF WheureDebut <> 0 THEN
                            DISPLAY "⚠️ L'heure de debut doit" WITH NO ADVANCING
                            DISPLAY " etre sur les créneaux ⚠️"
                          END-IF
                          DISPLAY "Heure de début: " WITH NO ADVANCING
                          ACCEPT WheureDebut
                        END-PERFORM
                        
                        
                        
                        MOVE WheureDebut TO fc_heure_debut
                        MOVE 0 TO Wfin
                        MOVE 0 TO Wtrouve
                        START fconcerts KEY IS = fc_heure_debut
                          NOT INVALID KEY
                           PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 1
                                        READ fconcerts NEXT
                                        AT END MOVE 1 TO Wfin
                                        NOT AT END
                                                IF WidScene = fc_id_scene THEN
                                                    IF WjourConcert = fc_jour THEN
                                                            MOVE 1 TO Wtrouve
                                                    END-IF
                                                END-IF
                                        END-READ
                                END-PERFORM
                        END-START
                        
                        IF Wtrouve = 1 THEN
                        
                                DISPLAY "⚠️ Créneau déjà pris ⚠️"
                        
                        END-IF
                
                END-PERFORM
                MOVE WidScene TO fc_id_scene
                MOVE WjourConcert TO fc_jour
                MOVE WheureDebut TO fc_heure_debut
                MOVE WidGroupe TO fc_id_groupe
                MOVE WidConcert TO fc_id
                
                WRITE tamp_fconcerts
                END-WRITE
                
                IF cr_fconcerts = 0 THEN
                        DISPLAY "✅️ Concert ajouté ✅️"
                END-IF
                        
                CLOSE fconcerts
        END-IF
        CLOSE fscenes.
        
        AFFICHAGE_SCENES.
        MOVE 0 TO Wcompteur
        OPEN INPUT fscenes
        DISPLAY " "
        DISPLAY "Id|Nom                           |Genre"
        DISPLAY "--+------------------------------+------------------------------"
        
        MOVE 0 TO Wfin
        PERFORM WITH TEST AFTER UNTIL Wfin = 1
                READ fscenes
                AT END      MOVE 1 TO Wfin
                NOT AT END  DISPLAY fs_id "|" fs_nom "|" fs_genre
                            ADD 1 TO Wcompteur
                END-READ
        END-PERFORM
        DISPLAY " "
        CLOSE fscenes.
        
        AFFICHAGE_CRENEAUX_SCENE_JOUR.
        
        OPEN INPUT fscenes
        MOVE WparamIdScene TO fs_id
        READ fscenes
          NOT INVALID KEY
          DISPLAY "+------------------------------+"
          DISPLAY "|" fs_nom "|"
          DISPLAY "|" WparamJour "|"
          DISPLAY "+------------------------------+"
        END-READ
        
        CLOSE fscenes
        
        OPEN INPUT fconcerts
        
        PERFORM VARYING Wi FROM 10 BY 2 UNTIL Wi > 22
        MOVE Wi TO fc_heure_debut
        MOVE 0 TO Wfin
        MOVE 0 TO Wtrouve
        START fconcerts KEY IS = fc_heure_debut
                NOT INVALID KEY
                PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 1
                        READ fconcerts NEXT
                        AT END MOVE 1 TO Wfin
                        NOT AT END
                                IF WparamIdScene = fc_id_scene THEN
                                        IF WparamJour = fc_jour THEN
                                          MOVE 1 TO Wtrouve
                                          MOVE fc_id_groupe TO WidGroupe
                                        END-IF
                                END-IF
                        END-READ
                END-PERFORM
        END-START
        IF Wtrouve = 1 THEN
                        DISPLAY Wi "h"
                        OPEN INPUT fgroupes
                        MOVE WidGroupe TO fg_id
                        READ fgroupes INTO fg_id
                                NOT INVALID KEY
                                        DISPLAY " |❌️ " fg_nom
                        END-READ
                        
                        CLOSE fgroupes
                ELSE 
                        DISPLAY Wi "h"
                        DISPLAY " |✅️ Libre"
                END-IF
                
        END-PERFORM       
        
        CLOSE fconcerts.
        
        
      *>parametre WparamGenre
        AFFICHAGE_GROUPE_GENRE.
        
        DISPLAY "Groupe pour le genre " WparamGenre
        
        MOVE 0 TO Wcompteur
        
        OPEN INPUT fgroupes
        MOVE WparamGenre to fg_genre
        MOVE 0 TO Wfin
        START fgroupes KEY IS = fg_genre
                NOT INVALID KEY
                PERFORM WITH TEST AFTER UNTIL Wfin = 1
                        READ fgroupes NEXT
                        AT END MOVE 1 TO Wfin
                        NOT AT END
                            IF fg_genre = WparamGenre THEN
                                DISPLAY fg_id "|" fg_nom
                                ADD 1 TO Wcompteur
                            ELSE
                                MOVE 1 TO Wfin
                            END-IF
                            
                        END-READ
                END-PERFORM
        END-START
        
        IF Wcompteur = 0 THEN
                DISPLAY "❌️ Pas de résultats ❌️"
        END-IF
        
        CLOSE fgroupes.
        
        AFFICHAGE_CONCERTS.
        DISPLAY "test".
        
