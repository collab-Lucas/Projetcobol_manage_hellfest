        MENUCHOIX.
        MOVE 0 TO Wchoix
        
        DISPLAY "*****************************************"
        DISPLAY "|  |  | |~~ |   |   |~~ |~~ /~~\ ~~|~~  |"
        DISPLAY "|  |--| |-- |   |   |-- |-- `--.   |    |"
        DISPLAY "|  |  | |__ |__ |__ |   |__ \__/   |    |"
        DISPLAY "*****************************************"
                
        MOVE 0 TO WidUtilisateurConnecte
        
        PERFORM WITH TEST AFTER UNTIL Wchoix = 0
            IF WidUtilisateurConnecte = 0 THEN
                DISPLAY "🤘️~~Connexion ou inscription~~🤘️"
                DISPLAY "1. Connexion"
                DISPLAY "2. Inscription"
                DISPLAY "3. Quitter le programme"
                
                PERFORM WITH TEST AFTER UNTIL Wchoix < 4 AND Wchoix > 0
                        DISPLAY "Choix: " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM
                
                        IF Wchoix = 1 THEN
                                PERFORM CONNEXION
                        ELSE IF Wchoix = 2 THEN
                                PERFORM AJOUT_UTILISATEUR
                                DISPLAY "INSCRIPTION"
                        ELSE IF Wchoix = 3 THEN
                                MOVE 0 TO Wchoix
                        END-IF
            ELSE
            
              DISPLAY " "
              DISPLAY "🤘️~~Application de gestion du HELLFEST~~🤘️"
              
              IF WroleUtilisateurConnecte = 1 THEN
                DISPLAY "1. Créer groupe"
                DISPLAY "2. Afficher vos concerts"
                PERFORM WITH TEST AFTER UNTIL Wchoix < 4 AND Wchoix > 0
                        DISPLAY "Choix: " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM
                IF Wchoix = 1 THEN
                         PERFORM AJOUT_GROUPE
                ELSE IF Wchoix = 2 THEN
                        PERFORM AFFICHE_CONCERT_GROUPE
                ELSE IF Wchoix = 3 THEN
                        MOVE 0 TO WidUtilisateurConnecte
                        DISPLAY "✅️ Deconnexion réussi ✅️"
                END-IF
              ELSE IF WroleUtilisateurConnecte = 2 THEN
              
                DISPLAY "1. Concerts pour ma scène"
                DISPLAY "2. Ajouter un concert pour sa scène"
                DISPLAY "3. Stats"
                DISPLAY "4. Ajouter un concert"
                DISPLAY "5. Deconnexion"
                
                PERFORM WITH TEST AFTER UNTIL Wchoix < 6 AND Wchoix > 0
                        DISPLAY "Choix: " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM
                
                MOVE 0 TO WidSceneUtilisateurConnecte
                
                OPEN INPUT fscenes
                
                MOVE WidUtilisateurConnecte TO fs_id_utilisateur
                READ fscenes INTO fs_id_utilisateur
                        NOT INVALID KEY
                               MOVE fs_id TO WidSceneUtilisateurConnecte
                               DISPLAY "test"
                END-READ
                CLOSE fscenes
                
                IF Wchoix = 1 THEN
                    IF WidSceneUtilisateurConnecte = 0 THEN
                         DISPLAY "❌️ Doit avoir créé une scène avant ❌️"
                    ELSE
                         DISPLAY " "
                       MOVE WidSceneUtilisateurConnecte TO WparamIdScene
                         MOVE "vendredi" TO WparamJour
                         PERFORM AFFICHAGE_CRENEAUX_SCENE_JOUR
                         DISPLAY " "
                         MOVE "samedi" TO WparamJour
                         PERFORM AFFICHAGE_CRENEAUX_SCENE_JOUR
                         DISPLAY " "
                         MOVE "dimanche" TO WparamJour
                         PERFORM AFFICHAGE_CRENEAUX_SCENE_JOUR
                         DISPLAY " "
                    END-IF
                ELSE IF Wchoix = 2 THEN
                        PERFORM AJOUT_CONCERT
                ELSE IF Wchoix = 3 THEN
                        PERFORM STAT_OCCUPATION_SCENES_JOUR
                ELSE IF Wchoix = 4 THEN
                        PERFORM AJOUT_SCENE
                ELSE IF Wchoix = 5 THEN
                        MOVE 0 TO WidUtilisateurConnecte
                        MOVE 0 TO WidSceneUtilisateurConnecte
                        DISPLAY "✅️ Deconnexion réussi ✅️"
                END-IF
            *>----MENU ADMINISTRATEUR----
              ELSE IF WroleUtilisateurConnecte = 3 THEN
                DISPLAY "1. Ajouter un concert"
                DISPLAY "2. Affichage des utilisateurs"
                DISPLAY "3. Affichage des groupes"
                DISPLAY "4. Statistiques sur la popularité des groupes"
                DISPLAY "5. Afficher scènes"
                DISPLAY "6. Recherche scene"
                DISPLAY "7. Deconnexion"
                PERFORM WITH TEST AFTER UNTIL Wchoix < 8 AND Wchoix > 0
                        DISPLAY "Choix: " WITH NO ADVANCING
                        ACCEPT Wchoix
                END-PERFORM
                
                IF Wchoix = 1 THEN
                        PERFORM AJOUT_CONCERT
                ELSE IF Wchoix = 2 THEN
                        PERFORM AFFICHAGE_UTILISATEUR
                ELSE IF Wchoix = 3 THEN
                        PERFORM AFFICHAGE_GROUPES
                ELSE IF Wchoix = 4 THEN
                        PERFORM STAT_RANG_GROUPES
                ELSE IF Wchoix = 5 THEN
                        PERFORM LISTE_SCENES
                ELSE IF Wchoix = 6 THEN
                        PERFORM RECHERCHE_SCENE
                ELSE IF Wchoix = 7 THEN
                        MOVE 0 TO WidUtilisateurConnecte
                        DISPLAY "✅️ Deconnexion réussi ✅️"
                END-IF
              END-IF
            END-IF
        END-PERFORM
        DISPLAY "👋️~~Au revoir~~👋️".
