        AJOUT_UTILISATEUR.
        
        PERFORM WITH TEST AFTER UNTIL WroleUtilisateur = 1
        OR WroleUtilisateur = 2
         DISPLAY "Créer un compte pour Groupe(1) ou " WITH NO ADVANCING
         DISPLAY " pour Responsable d'une scène(2) ? " WITH NO ADVANCING
         ACCEPT WroleUtilisateur
        END-PERFORM
        
        OPEN INPUT futilisateurs
        MOVE 0 TO Wtrouve
        PERFORM WITH TEST AFTER UNTIL Wtrouve = 0 AND WidUtilisateur<>0
                DISPLAY "Id Utilisateur: " WITH NO ADVANCING
                ACCEPT WidUtilisateur
                
                MOVE 0 TO Wtrouve
                
                MOVE WidUtilisateur TO fu_id
                READ futilisateurs
                  NOT INVALID KEY
                        MOVE 1 TO Wtrouve
                        DISPLAY "⚠️ Id déjà utilisé ! ⚠️"
                END-READ
                IF WidUtilisateur = 0 THEN
                        DISPLAY "⚠️ Id doit être different de 0 ! ⚠️"
                END-IF
        END-PERFORM
        
        CLOSE futilisateurs
        
        DISPLAY "Nom: " WITH NO ADVANCING
        ACCEPT WnomUtilisateur
        
        DISPLAY "Prenom: " WITH NO ADVANCING
        ACCEPT WprenomUtilisateur
        
        DISPLAY "Mot de passe: " WITH NO ADVANCING
        ACCEPT Wmot_de_passeUtilisateur
        
        MOVE WroleUtilisateur TO fu_role
        MOVE WidUtilisateur TO fu_id
        MOVE WnomUtilisateur TO fu_nom
        MOVE WprenomUtilisateur TO fu_prenom
        MOVE Wmot_de_passeUtilisateur TO fu_mot_de_passe
        
        OPEN I-O futilisateurs
        
        WRITE tamp_futilisateurs
        END-WRITE
        
        IF cr_futilisateurs = 00 THEN
                DISPLAY "✅️ Utilisateur bien enregistré ✅️"
        END-IF
        
        CLOSE futilisateurs.
        
        
        
        AFFICHAGE_UTILISATEUR.
        DISPLAY "🧐️~~Affichage des utilisateurs~~🧐️"
        
        OPEN I-O futilisateurs
        
        MOVE 0 TO Wfin
        PERFORM WITH TEST AFTER UNTIL Wfin = 1
            READ futilisateurs NEXT
            AT END  MOVE 1 TO Wfin
            NOT AT END
                DISPLAY fu_id "|" fu_nom "|" fu_prenom "|" fu_role
            END-READ
        END-PERFORM
        
        CLOSE futilisateurs.
