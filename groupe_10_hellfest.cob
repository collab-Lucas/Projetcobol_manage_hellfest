        IDENTIFICATION DIVISION.
        PROGRAM-ID. hellfest.
        
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
                select fscenes assign to "scenes.dat"
                organization indexed
                access mode is dynamic
                record key is fs_id
                alternate record key is fs_nom
                alternate record key is fs_id_utilisateur
                alternate record key is fs_genre WITH DUPLICATES
                file status is cr_fscenes.
                
                select fgroupes assign to "groupes.dat"
                organization indexed
                access mode is dynamic
                record key is fg_id
                alternate record key is fg_nom
                alternate record key is fg_id_utilisateur
                alternate record key is fg_genre WITH DUPLICATES
                file status is cr_fgroupes.
                
                select fconcerts assign to "concerts.dat"
                organization indexed
                access mode is dynamic
                record key is fc_id
                alternate record key is fc_id_scene WITH DUPLICATES
                alternate record key is fc_id_groupe WITH DUPLICATES
                alternate record key is fc_jour WITH DUPLICATES
                alternate record key is fc_heure_debut WITH DUPLICATES
                file status is cr_fconcerts.
                
                select futilisateurs assign to "utilisateurs.dat"
                organization indexed
                access mode is dynamic
                record key is fu_id
                file status is cr_futilisateurs.
                
        DATA DIVISION.
        
        FILE SECTION.
        FD fscenes.
        01 tamp_fscenes.
                02 fs_id PIC 9(2).
                02 fs_nom PIC A(30).
                02 fs_nb_place PIC 9(6).
                02 fs_genre PIC A(30).
                02 fs_id_utilisateur PIC 9(5).
        
        FD fgroupes.
        01 tamp_fgroupes.
                02 fg_id PIC 9(5).
                02 fg_nom PIC A(30).
                02 fg_genre PIC A(30).
                02 fg_nationalite PIC A(30).
                02 fg_rang PIC A(1).
                02 fg_id_utilisateur PIC 9(5).
        
        FD fconcerts.
        01 tamp_fconcerts.
                02 fc_id PIC 9(5).
                02 fc_jour PIC A(30).
                02 fc_heure_debut PIC 9(2).
                02 fc_id_groupe PIC 9(5).
                02 fc_id_scene PIC 9(2).
        
        FD futilisateurs.
        01 tamp_futilisateurs.
                02 fu_id PIC 9(5).
                02 fu_nom PIC A(30).
                02 fu_prenom PIC A(30).
                02 fu_role PIC 9(2).
                02 fu_mot_de_passe PIC X(30).
        
        WORKING-STORAGE SECTION.
        77 cr_fscenes PIC 9(2).
        77 cr_fgroupes PIC 9(2).
        77 cr_fconcerts PIC 9(2).
        77 cr_futilisateurs PIC 9(2).
        77 Wfin PIC 9.
        77 Wtrouve PIC 9.
        77 Wchoix PIC 9.
        77 WidUtilisateur PIC 9(5).
        77 Wmot_de_passe PIC X(30).
        77 WidUtilisateurConnecte PIC 9(5).
        77 WroleUtilisateurConnecte PIC 9(2).
        77 WidGroupeUtilisateurConnecte PIC 9(5).
        77 WidSceneUtilisateurConnecte PIC 9(2).
        77 WroleUtilisateur PIC 9(2).
        77 WnomUtilisateur PIC A(30).
        77 WprenomUtilisateur PIC A(30).
        77 Wmot_de_passeUtilisateur PIC X(30).
        77 WidScene PIC 9(2).
        77 Wgenre PIC A(30).
        
        77 Wid PIC 9(2).
        77 Wnom PIC A(30).
        77 Wnat PIC A(30).
        77 Wrang PIC A(1).
        77 Wtrouver PIC 9.
        77 WgA PIC 9(3)V99.
        77 WgB PIC 9(3)V99.
        77 WgC PIC 9(3)V99.
        77 WgTotal PIC 9(3).
        77 Wcent PIC 9(3).
        
        77 WidConcert PIC 9(5).
        77 WjourConcert PIC A(30).
        77 Wi PIC 9(2).
        77 WparamIdScene PIC 9(2).
        77 WparamJour PIC A(30).
        77 WheureDebut PIC 9(2).
        77 WparamGenre PIC A(30).
        
        77 WtypeSearch PIC 9.
        
        77 WidGroupe PIC 9(2).
        
        77 Wcompteur PIC 9(4).
        
        77 Wajoutpossible PIC 9(1).
        
        77 WsA PIC 9(2).
        
        PROCEDURE DIVISION.
        
        OPEN I-O fgroupes
        IF cr_fgroupes = 35 THEN
                OPEN OUTPUT fgroupes
        END-IF
        CLOSE fgroupes
        
        OPEN I-O fscenes
        IF cr_fscenes = 35 THEN
                OPEN OUTPUT fscenes
        END-IF
        CLOSE fscenes
        
        OPEN I-O fconcerts
        IF cr_fconcerts = 35 THEN
                OPEN OUTPUT fconcerts
        END-IF
        CLOSE fconcerts
        
        OPEN I-O futilisateurs
        IF cr_futilisateurs = 35 THEN
                OPEN OUTPUT futilisateurs
                
                MOVE 00001 TO fu_id
                MOVE "Barbaud" TO fu_nom
                MOVE "Benjamin" TO fu_prenom
                MOVE 03 TO fu_role
                MOVE "h3llf3st" TO fu_mot_de_passe
                
                WRITE tamp_futilisateurs
                END-WRITE
                
        END-IF
        CLOSE futilisateurs
        
        PERFORM MENUCHOIX
        
        STOP RUN.
        COPY "groupe_10_menu.cpy".
        COPY "groupe_10_utilisateur.cpy".
        COPY "groupe_10_connexion.cpy".
        COPY "groupe_10_scene.cpy".
        COPY "groupe_10_groupes.cpy".
        COPY "groupe_10_concert.cpy".
