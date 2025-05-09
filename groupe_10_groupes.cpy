       AJOUT_GROUPE.      
       OPEN INPUT fgroupes
       MOVE 0 TO Wtrouver
       PERFORM WITH TEST AFTER UNTIL Wtrouver = 0 
              DISPLAY "id"
              ACCEPT Wid
              MOVE Wid TO fg_id
              READ fgroupes
              INVALID KEY DISPLAY "inexistant"
                          MOVE 0 To Wtrouver
              NOT INVALID KEY DISPLAY fg_id
                              MOVE 1 To Wtrouver
                              DISPLAY "⚠️ Id déjà utilisé ! ⚠️"
                              
              END-READ
       END-PERFORM
       CLOSE fgroupes
       DISPLAY "rentrer nom" 
       ACCEPT Wnom
       DISPLAY "rentrer genre" 
       ACCEPT Wgenre
       DISPLAY "rentrer nationalité" 
       ACCEPT Wnat
       DISPLAY "rentrer rang" 
       ACCEPT Wrang    
       MOVE Wnom TO fg_nom
       MOVE Wgenre TO fg_genre
       MOVE Wnat TO fg_nationalite
       MOVE Wrang TO fg_rang
       MOVE WidUtilisateurConnecte TO fg_id_utilisateur
       OPEN I-O fgroupes
       WRITE tamp_fgroupes
       END-WRITE
       DISPLAY cr_fgroupes
       CLOSE fgroupes.
       
       MODIF_GROUPES.     
       OPEN INPUT fgroupes
       MOVE 0 TO Wtrouver
       PERFORM WITH TEST AFTER UNTIL Wtrouver = 0 
              DISPLAY "id"
              ACCEPT Wid
              READ fgroupes
              INVALID KEY DISPLAY "inexistant"
                          MOVE 0 To Wtrouver
              NOT INVALID KEY 
                     DISPLAY fg_id
                     DISPLAY "rentrer nouveau nom" 
                     ACCEPT Wnom
                     DISPLAY "rentrer nouveau genre" 
                     ACCEPT Wgenre
                     DISPLAY "rentrer nouveau nationalité" 
                     ACCEPT Wnat
                     DISPLAY "rentrer nouveau rang" 
                     ACCEPT Wrang    
                     MOVE Wnom TO fg_nom
                     MOVE Wgenre TO fg_genre
                     MOVE Wnat TO fg_nationalite
                     MOVE Wrang TO fg_rang
                     OPEN I-O fgroupes
                     WRITE tamp_fgroupes
                     END-WRITE
                     DISPLAY cr_fgroupes
                     MOVE 1 To Wtrouver
              END-READ
       END-PERFORM
       CLOSE fgroupes.
       
       
       AFFICHAGE_GROUPES.
       OPEN INPUT fgroupes
       MOVE 0 TO Wfin  
       PERFORM WITH TEST AFTER UNTIL Wfin = 1 
              READ fgroupes
              AT END MOVE 1 TO Wfin 
              NOT AT END
                DISPLAY fg_id "|" fg_nom "|" fg_genre "|" fg_nationalite
              END-READ
       END-PERFORM
       CLOSE fgroupes.
       
       AFFICHAGE_CONCERTS_GROUPES.
       OPEN INPUT fconcerts
       OPEN INPUT fgroupes
       MOVE 0 TO Wfin
       MOVE WidUtilisateurConnecte TO fg_id_utilisateur
       READ fgroupes
       INVALID KEY DISPLAY "inexistant"
       NOT INVALID KEY 
              MOVE fg_id TO fc_id_groupe
              START fconcerts KEY IS = fc_id_groupe
              INVALID KEY DISPLAY "inexistant"
              NOT INVALID KEY
                     PERFORM WITH TEST AFTER UNTIL Wfin = 1
                            READ fconcerts NEXT
                            AT END MOVE 1 TO Wfin
                            DISPLAY "-----Concert-----"
                            DISPLAY fc_jour
                            DISPLAY fc_heure_debut
                            DISPLAY fc_id_scene
                            END-READ
                     END-PERFORM
              END-START
       END-READ
       CLOSE fconcerts
       CLOSE fgroupes.
       
       STAT_RANG_GROUPES.
       OPEN INPUT fgroupes
       MOVE 0 TO Wfin
       MOVE 0 TO WgTotal
       MOVE 0 TO WgA 
       MOVE 0 TO WgB
       MOVE 0 TO WgC
       PERFORM WITH TEST AFTER UNTIL Wfin = 1 
              READ fgroupes
              AT END MOVE 1 TO Wfin 
              NOT AT END ADD 1 TO WgTotal
                         IF fg_rang = "A" THEN
                            ADD 1 TO WgA
                         END-IF
                         IF fg_rang = "B" THEN
                            ADD 1 TO WgB
                         END-IF
                         IF fg_rang = "C" THEN
                            ADD 1 TO WgC
                         END-IF
              END-READ
       END-PERFORM
       DISPLAY "Groupe A :" WgA " Groupe B :" WgB " Groupe C :"WgC
       DISPLAY "Pourcentage :"
       DIVIDE WgA BY WgTotal GIVING WgA
       DIVIDE WgB BY WgTotal GIVING WgB
       DIVIDE WgC BY WgTotal GIVING WgC
       MOVE 100 TO Wcent
       MULTIPLY WgA BY Wcent GIVING WgA
       MULTIPLY WgB BY Wcent GIVING WgB
       MULTIPLY WgC BY Wcent GIVING WgC
       DISPLAY "Groupe A :" WgA  "% Groupe B :" WgB "% Groupe C :"WgC"%"
       CLOSE fgroupes.
       




