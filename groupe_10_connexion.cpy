        CONNEXION.

        DISPLAY "🔌️~~Connexion~~🔌️"
        DISPLAY "Identifiant (id): " WITH NO ADVANCING
        ACCEPT WidUtilisateur
        DISPLAY "Mot de passe: " WITH NO ADVANCING
        ACCEPT Wmot_de_passe
        
        OPEN INPUT futilisateurs
        
        MOVE WidUtilisateur TO fu_id
        READ futilisateurs KEY IS fu_id
          INVALID KEY
           DISPLAY "⚠️ L'utilisateur n'existe pas ! ⚠️"
          NOT INVALID KEY
           IF fu_mot_de_passe = Wmot_de_passe THEN
                MOVE WidUtilisateur TO WidUtilisateurConnecte
                MOVE fu_role TO WroleUtilisateurConnecte
                DISPLAY "✅️ Connexion réussi ! ✅️"
                DISPLAY "➡️ Connecté en tant que" WITH NO ADVANCING
                IF fu_role = 1 THEN
                        DISPLAY " Groupe "
                ELSE IF fu_role = 2 THEN
                        DISPLAY " Responsable Scène "
                ELSE IF fu_role = 3 THEN
                        DISPLAY " Administrateur "
                END-IF
           ELSE
                DISPLAY "⚠️ Mot de passe incorrect ! ⚠️"
           END-IF
        END-READ
        
        CLOSE futilisateurs.
