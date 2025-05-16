 
 
 

.model small
.stack
.data
     


    ; COMMENTED LINES ===> CHANGES FOR MAHARLIKA 2.0
        ; arrow keys (up, down, left, right)
        ; controls (pause and resume)


 
    line1_game db "MAHARLIKA", "$"
    line2_game db "ASCENDANCE", "$"
    line5_game db "Score:" ,"$"
    line6_game db "[R]   Restart" ,"$"
    line7_game db "[ESC] Pause" ,"$"
    line8_game db "[Q]   Quit", "$"
    blank_game db "   " ,"$"
     
    line1_over db "GAME OVER!", "$"
    line2_over db "HIGH SCORE      ", "$"
    line3_over db "[M] Menu", "$"
    line4_over db "YOUR SCORE      ", "$"
    line5_over db "[P] Play again", "$"
    .highscore dw 0
     
    line1_menu db "MAHARLIKA ASCENDANCE", "$"    
    line3_menu db "[s] Start playing", "$"
    line4_menu db "[t] Tutorial", "$"
    tempscore db 0, 0, 0
     
    line1_pg1 db "Use 'WASD' or the", 0       
    line2_pg1 db "arrow keys to move!", 0         
    line1_pg2 db "Obtain powerups!", "$"               
    line2_pg2 db "Slow time or Double pts!", "$"          
    line1_pg3 db "Watch out for obstacles", "$"  
    line2_pg3 db "and falling icicles!", "$"     
    line1_pg4 db "Obstacles increase", "$"       
    line2_pg4 db "as you score!", "$"            
    line1_pg5 db "1 points", "$"  
    line2_pg5 db "2 points", "$"  
    line3_pg5 db "5 points", "$"  
    line4_pg5 db "Keep an eye for coins", "$"  
    line5_pg5 db "to gain more points!", "$"  
    line3_tutorial db "[e] menu", "$" 
    line1_pause db "Press SPACE to resume...", "$"         ; pause screen message         

     
    current_tick db 00h
    y_toplimit dw 18h
    y_bottomlimit dw 0098h
    y_velocity dw 8           
    game_state dw 0          
    randomNum db 01h
    rngseed dw 00h
    score_ones db 0
    score_tens db 0
    score_hund db 0
    score_rate db 1
    score_overallhex dw 0
    rendercoordX dw 0
    rendercoordY dw 0
    _rendersizeX dw 0
    _rendersizeY dw 0
    prevtime db 0
    allowscore db 0              
    delaytime db 0
    tempmsecond db 0
    _stringx db 0
    _stringy db 0
    _stringcolor db 0
    _stringlength dw 0
    tutorial_page db 1
    current_seconds db 0
    menu_page db 1 


     
    char_size dw 0fh
    char_x dw 0087h
    char_y dw 0098h
    char_velocity dw 0008h
    char_xfixedpos dw 1        

     
    enemy_x dw 202
    enemy_y dw 9
    enemy_state db 0            
    enemy_interval db 10
    icicle_state db 0           
    iciclex dw ?
    icicley dw 8
    icicle_velocity dw 4

     
    coinx dw 0
    coiny dw 0
    coinsize dw 8
    tempcoinx dw 0
    coin_state dw 0                  
    coin_value dw 1
    coin_interval db 0
    

    speed_state db 0           ; 0 = inactive, 1 = ready, 2 = descending, 3 = collected
    speedx dw 0
    speedy dw 0
    speed_interval db 20        ; Appears every 15 seconds (can be adjusted)
    has_speed db 0 
    speed_timer db 0


    double_score_state db 0           ; 0 = inactive, 1 = ready, 2 = descending, 3 = collected
    double_scorex dw 0
    double_scorey dw 0
    double_score_interval db 30        ; Appears every 15 seconds (can be adjusted)
    has_double_score db 0 
    double_score_timer db 0

    powerup_logo_active db 0 
    doublescore_logo_active db 0 

     
    menutowerx dw 215
    menutowery_seg1 dw 103, 135, 167
    menutowery_seg2 dw 119, 151, 183
    menutowerchesty dw 79
    towery dw 17, 33, 49, 65, 81, 97, 113, 129, 145, 162, 178
    towerx dw 151

     
    obs_xpos dw 183, 183, 183, 183, 183                  
    obs_ypos dw 23, 55, 87, 119, 151                     
    obsfixedxpos_state dw 0                              
    obs_isactive dw 1, 0, 0, 0, 0                        
    .obs_activetemp dw 0, 0, 0, 0, 0

    ti  dw 415          ; B coin sound
    la  dw 711          ; A coin sound
    sol dw 1043         ; G 
    fa  dw 1416         ; F
    mi  dw 1619         ; E
    re  dw 2061         ; D
    do  dw 4560         ; C
    start_time          db  0
    note_duration       db  0

    speed   db 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 0fh, 00h, 00h, 00h
            db 00h, 00h, 0fh, 00h, 0Eh, 00h, 00h, 0fh, 0bh, 0fh, 00h, 00h, 0Eh, 00h, 0fh, 00h, 00h
            db 00h, 00h, 0fh, 00h, 00h, 0Eh, 00h, 0fh, 0bh, 0fh, 00h, 0Eh, 00h, 00h, 0fh, 00h, 00h
            db 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 0bh, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 0bh, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 0Eh, 0Eh, 00h, 00h, 0fh, 0bh, 0fh, 00h, 00h, 0Eh, 0Eh, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0bh, 0fh, 00h, 00h, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0bh, 0fh, 00h, 00h, 00h, 0fh, 00h
            db 00h, 00h, 0fh, 00h, 00h, 0Eh, 00h, 00h, 00h, 00h, 0fh, 0bh, 0fh, 00h, 0fh, 00h, 00h
            db 00h, 00h, 0fh, 00h, 0Eh, 00h, 00h, 00h, 0Eh, 00h, 00h, 0fh, 0fh, 00h, 0fh, 00h, 00h
            db 00h, 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 0Eh, 00h, 00h, 00h, 00h, 0fh, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h

    twice   db 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 00h, 00h, 00h
            db 00h, 00h, 0fh, 00h, 00h, 0bh, 0bh, 0bh, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 00h, 00h
            db 00h, 00h, 0fh, 00h, 0bh, 0bh, 00h, 00h, 0bh, 00h, 00h, 00h, 00h, 00h, 0fh, 00h, 00h
            db 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 0bh, 03h, 00h, 0bh, 00h, 0bh, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 00h, 00h, 0bh, 03h, 00h, 00h, 0bh, 00h, 03h, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 00h, 0bh, 03h, 00h, 00h, 00h, 00h, 03h, 00h, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 0bh, 03h, 00h, 00h, 0bh, 00h, 0bh, 00h, 03h, 00h, 00h, 0fh, 00h
            db 00h, 0fh, 00h, 00h, 03h, 03h, 03h, 03h, 03h, 00h, 03h, 00h, 03h, 00h, 00h, 0fh, 00h
            db 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 00h, 00h
            db 00h, 00h, 0fh, 00h, 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 00h, 0fh, 00h, 00h
            db 00h, 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h

    coin db 00h, 00h, 0Eh, 0Eh, 0Eh, 0Eh, 00h, 00h, 00h      
         db 00h, 0Eh, 0Eh, 2Ah, 2Ah, 0Eh, 0Eh, 00h, 00h
         db 0Eh, 0Eh, 2Ah, 0Eh, 0Eh, 2Ah, 0Eh, 0Eh, 00h
         db 0Eh, 2Ah, 0Eh, 0Eh, 0Eh, 0Eh, 2Ah, 0Eh, 00h
         db 0Eh, 2Ah, 0Eh, 0Eh, 0Eh, 0Eh, 2Ah, 0Eh, 00h
         db 0Eh, 0Eh, 2Ah, 0Eh, 0Eh, 2Ah, 0Eh, 0Eh, 00h
         db 00h, 0Eh, 0Eh, 2Ah, 2Ah, 0Eh, 0Eh, 00h, 00h
         db 00h, 00h, 0Eh, 0Eh, 0Eh, 0Eh, 00h, 00h, 00h
         db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

    coinsilver  db 00h, 00h, 1Ah, 1Ah, 1Ah, 1Ah, 00h, 00h, 00h   
                db 00h, 1Ah, 1Ah, 17h, 17h, 1Ah, 1Ah, 00h, 00h
                db 1Ah, 1Ah, 17h, 1Ah, 1Ah, 17h, 1Ah, 1Ah, 00h
                db 1Ah, 17h, 1Ah, 1Ah, 1Ah, 1Ah, 17h, 1Ah, 00h
                db 1Ah, 17h, 1Ah, 1Ah, 1Ah, 1Ah, 17h, 1Ah, 00h
                db 1Ah, 1Ah, 17h, 1Ah, 1Ah, 17h, 1Ah, 1Ah, 00h 
                db 00h, 1Ah, 1Ah, 17h, 17h, 1Ah, 1Ah, 00h, 00h
                db 00h, 00h, 1Ah, 1Ah, 1Ah, 1Ah, 00h, 00h, 00h
                db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

    coinruby db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
             db 00h, 00h, 04h, 04h, 04h, 04h, 04h, 00h, 00h
             db 00h, 04h, 0ch, 04h, 0ch, 04h, 0ch, 04h, 00h
             db 04h, 0ch, 04h, 0ch, 04h, 0ch, 04h, 0ch, 04h
             db 00h, 04h, 04h, 04h, 04h, 04h, 04h, 04h, 00h
             db 00h, 00h, 04h, 0ch, 0ch, 0ch, 04h, 00h, 00h
             db 00h, 00h, 00h, 04h, 0ch, 04h, 00h, 00h, 00h
             db 00h, 00h, 00h, 00h, 04h, 00h, 00h, 00h, 00h
             db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

    icicle  db 00h, 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 29h, 00h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 29h, 00h, 00h, 29h, 00h, 00h   
            db 00h, 00h, 00h, 00h, 2Bh, 29h, 00h, 29h, 00h, 00h
            db 00h, 29h, 00h, 00h, 2Ah, 29h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 2Bh, 29h, 00h, 00h, 00h, 00h
            db 00h, 29h, 00h, 00h, 29h, 00h, 29h, 00h, 00h, 00h
            db 00h, 00h, 00h, 29h, 2Ah, 2Bh, 2Ah, 00h, 00h, 00h
            db 00h, 00h, 29h, 29h, 2Ah, 2Bh, 2Bh, 29h, 00h, 00h
            db 00h, 00h, 29h, 2Ah, 2Bh, 0Fh, 2Ah, 29h, 00h, 00h
            db 00h, 00h, 29h, 2Ah, 2Bh, 0Fh, 2Ah, 29h, 00h, 00h
            db 00h, 00h, 29h, 2Ah, 2Bh, 0Fh, 2Ah, 29h, 00h, 00h
            db 00h, 00h, 00h, 29h, 2Ah, 2Ah, 29h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 29h, 29h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
            db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    
    Player_up  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h     
               db 00h, 00h, 00h, 0Fh, 00h, 2Fh, 00h, 2Fh, 2Fh, 0Fh, 0Fh, 00h, 00h, 00h, 0Fh, 00h
               db 00h, 00h, 02h, 0Fh, 00h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 0Fh, 00h, 00h, 2Fh, 00h
               db 00h, 00h, 02h, 0Fh, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 2Fh, 0Fh, 00h, 00h
               db 00h, 00h, 02h, 0Fh, 00h, 42h, 42h, 42h, 2Fh, 2Fh, 02h, 00h, 2Fh, 02h, 00h, 00h
               db 00h, 00h, 02h, 2Fh, 00h, 09h, 0Fh, 2Fh, 2Fh, 2Fh, 02h, 02h, 00h, 00h, 00h, 00h
               db 00h, 00h, 02h, 2Fh, 00h, 42h, 42h, 2Fh, 2Fh, 02h, 02h, 02h, 00h, 2Fh, 0Fh, 00h
               db 00h, 00h, 02h, 2Fh, 00h, 02h, 02h, 02h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h
               db 00h, 00h, 02h, 2Fh, 00h, 00h, 00h, 00h, 00h, 00h, 2Fh, 2Fh, 0Fh, 0Fh, 02h, 00h
               db 00h, 00h, 02h, 2Fh, 00h, 00h, 2Fh, 0Fh, 02h, 00h, 2Fh, 2Fh, 2Fh, 0Fh, 02h, 00h
               db 00h, 2Fh, 00h, 00h, 02h, 00h, 2Fh, 02h, 02h, 00h, 2Fh, 2Fh, 00h, 00h, 02h, 00h
               db 00h, 00h, 2Fh, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 2Fh, 2Fh, 2Fh, 02h, 02h, 00h
               db 00h, 00h, 00h, 00h, 02h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 02h, 02h, 02h, 00h, 00h
               db 00h, 00h, 02h, 02h, 00h, 00h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 00h, 00h, 00h, 00h
               db 00h, 00h, 00h, 00h, 00h, 2Fh, 2Fh, 0Fh, 00h, 00h, 00h, 2Fh, 0Fh, 02h, 00h, 00h
               db 00h, 00h, 00h, 00h, 02h, 02h, 02h, 02h, 00h, 00h, 00h, 02h, 02h, 02h, 02h, 00h
    
    Player_left     db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h    
                    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2Fh, 00h, 00h, 00h, 00h
                    db 00h, 00h, 00h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 00h, 2Fh, 00h, 02h, 00h, 00h
                    db 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 02h, 00h, 02h, 00h, 00h
                    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 00h, 02h, 00h, 00h, 02h
                    db 00h, 00h, 2Fh, 00h, 2Fh, 42h, 09h, 42h, 02h, 00h, 00h, 00h, 00h, 00h, 2Fh, 2Fh, 02h
                    db 00h, 00h, 00h, 2Fh, 2Fh, 42h, 0Fh, 42h, 02h, 00h, 2Fh, 2Fh, 00h, 2Fh, 00h, 2Fh, 02h
                    db 00h, 00h, 2Fh, 2Fh, 2Fh, 42h, 2Fh, 2Fh, 02h, 00h, 0Fh, 02h, 00h, 2Fh, 02h, 0Fh, 02h
                    db 00h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 02h, 00h, 02h, 02h, 00h, 0Fh, 02h, 00h, 00h
                    db 00h, 00h, 0Fh, 2Fh, 2Fh, 2Fh, 2Fh, 02h, 02h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h
                    db 00h, 00h, 0Fh, 2Fh, 2Fh, 02h, 02h, 02h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 02h, 00h, 00h
                    db 00h, 00h, 00h, 0Fh, 00h, 00h, 02h, 02h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 02h, 00h, 2Fh, 02h
                    db 00h, 00h, 00h, 00h, 2Fh, 2Fh, 00h, 00h, 00h, 0Fh, 2Fh, 00h, 2Fh, 02h, 00h, 0Fh, 02h
                    db 00h, 00h, 00h, 00h, 0Fh, 02h, 00h, 2Fh, 00h, 0Fh, 0Fh, 00h, 02h, 02h, 00h, 02h, 02h
                    db 00h, 00h, 0Fh, 02h, 00h, 00h, 00h, 0Fh, 00h, 02h, 02h, 02h, 02h, 00h, 00h, 00h, 02h
                    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h



    Player_right    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h    
                    db 00h, 00h, 00h, 00h, 00h, 2Fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                    db 00h, 00h, 02h, 00h, 2Fh, 00h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 00h, 00h, 00h
                    db 00h, 00h, 02h, 00h, 02h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 00h
                    db 02h, 00h, 00h, 02h, 00h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                    db 02h, 2Fh, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 42h, 09h, 42h, 2Fh, 00h, 2Fh, 00h, 00h
                    db 02h, 2Fh, 00h, 2Fh, 00h, 2Fh, 2Fh, 00h, 02h, 42h, 0Fh, 42h, 2Fh, 2Fh, 00h, 00h, 00h
                    db 02h, 0Fh, 02h, 2Fh, 00h, 02h, 0Fh, 00h, 02h, 2Fh, 2Fh, 42h, 2Fh, 2Fh, 2Fh, 00h, 00h
                    db 00h, 00h, 02h, 0Fh, 00h, 02h, 02h, 00h, 02h, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 00h
                    db 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 02h, 02h, 2Fh, 2Fh, 2Fh, 2Fh, 0Fh, 00h, 00h
                    db 00h, 00h, 02h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 02h, 02h, 02h, 2Fh, 2Fh, 0Fh, 00h, 00h
                    db 02h, 2Fh, 00h, 02h, 2Fh, 2Fh, 2Fh, 2Fh, 00h, 02h, 02h, 00h, 00h, 0Fh, 00h, 00h, 00h
                    db 02h, 0Fh, 00h, 02h, 2Fh, 00h, 2Fh, 0Fh, 00h, 00h, 00h, 2Fh, 2Fh, 00h, 00h, 00h, 00h
                    db 02h, 02h, 00h, 02h, 02h, 00h, 0Fh, 0Fh, 00h, 2Fh, 00h, 02h, 0Fh, 00h, 00h, 00h, 00h
                    db 02h, 00h, 00h, 00h, 02h, 02h, 02h, 02h, 00h, 0Fh, 00h, 00h, 00h, 02h, 0Fh, 00h, 00h
                    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

;arbiter version
;    menutower_topchest  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h       
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 48h, 48h, 48h, 48h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 48h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 44h, 0fh, 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 44h, 44h, 43h, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;                        db 00h, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 0fh, 1ch, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
;                        db 00h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 02h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
;                        db 0fh, 02h, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h
;                        db 0fh, 02h, 02h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 19h, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 1ch, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 1Dh, 00h
;                        db 0fh, 0fh, 02h, 0fh, 0fh, 19h, 19h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 19h, 19h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 1ch, 00h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 19h, 0fh, 0fh, 0fh, 0fh, 19h, 1Dh, 00h
;                        db 0fh, 0fh, 02h, 0fh, 0fh, 19h, 19h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 19h, 00h, 44h, 0fh, 0fh, 0fh, 1ch, 43h, 00h, 19h, 19h, 0fh, 02h, 02h, 0fh, 02h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 0fh, 02h, 02h, 0fh, 19h, 00h
;                        db 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 00h, 43h, 1ch, 1ch, 43h, 00h, 00h, 0fh, 0fh, 19h, 02h, 0fh, 0fh, 02h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 19h, 00h
;                        db 0fh, 0fh, 0fh, 02h, 02h, 0fh, 19h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 19h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 19h, 02h, 02h, 02h, 0fh, 0fh, 1Dh, 00h
;                        db 0fh, 0fh, 19h, 02h, 02h, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h
;                        db 0fh, 19h, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 02h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 02h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h
;                        db 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 02h, 02h, 02h, 19h, 19h, 0fh, 02h, 02h, 0fh, 0fh, 19h, 0fh, 19h, 02h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 19h, 0fh, 1Dh, 00h
;                        db 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 02h, 02h, 02h, 02h, 19h, 02h, 02h, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 19h, 19h, 0fh, 02h, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 1Dh, 00h
;                        db 19h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 02h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 02h, 02h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 19h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 19h, 19h, 00h
;                        db 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 19h, 0fh, 0fh, 02h, 02h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 0fh, 02h, 02h, 0fh, 19h, 19h, 0fh, 19h, 00h
;                        db 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 0fh, 1Dh, 1Dh, 00h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 19h, 0fh, 0fh, 1Dh, 19h, 00h
;                        db 00h, 1Dh, 02h, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 19h, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h
;                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h


    menutower_topchest  db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h       
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2ah, 2ah, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 2ah, 2ah, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 48h, 48h, 48h, 48h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2ah, 2ah, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 2ah, 2ah, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 48h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2ah, 2ah, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 2ah, 2ah, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 44h, 0fh, 00h, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2ah, 2ah, 06h, 06h, 0bah, 0bah, 0bah, 0bah, 06h, 06h, 2ah, 2ah, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 44h, 44h, 43h, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 2ah, 2ah, 0bah, 0bah, 2ah, 2ah, 2ah, 2ah, 0bah, 0bah, 2ah, 2ah, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 0fh, 1ch, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 72h, 72h, 72h, 2ah, 0bah, 0bah, 2ah, 72h, 72h, 72h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
                        db 00h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 02h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 2ah, 06h, 06h, 2ah, 0bah, 0bah, 2ah, 06h, 06h, 2ah, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
                        db 0fh, 02h, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 19h, 0fh, 1Dh, 06h, 06h, 2ah, 2ah, 2ah, 2ah, 06h, 06h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 02h, 02h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 1ch, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 19h, 1Dh, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 1Dh, 00h
                        db 0fh, 0fh, 02h, 0fh, 0fh, 19h, 19h, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 1ch, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 19h, 19h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 19h, 0fh, 0fh, 0fh, 0fh, 19h, 1Dh, 00h
                        db 0fh, 0fh, 02h, 0fh, 0fh, 19h, 19h, 1Dh, 00h, 44h, 0fh, 0fh, 0fh, 1ch, 43h, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 19h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 19h, 19h, 0fh, 02h, 02h, 0fh, 02h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 0fh, 02h, 02h, 0fh, 19h, 00h
                        db 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 00h, 00h, 43h, 1ch, 1ch, 43h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 06h, 0fh, 0fh, 19h, 02h, 0fh, 0fh, 02h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 19h, 00h
                        db 0fh, 0fh, 0fh, 02h, 02h, 0fh, 19h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 19h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 19h, 02h, 02h, 02h, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 0fh, 19h, 02h, 02h, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 19h, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 02h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 02h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 02h, 02h, 02h, 19h, 19h, 0fh, 02h, 02h, 0fh, 0fh, 19h, 0fh, 19h, 02h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 19h, 0fh, 1Dh, 00h
                        db 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 02h, 02h, 02h, 02h, 19h, 02h, 02h, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 19h, 19h, 0fh, 02h, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 1Dh, 00h
                        db 19h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 02h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 02h, 02h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 19h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 19h, 19h, 00h
                        db 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 19h, 0fh, 0fh, 02h, 02h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 0fh, 02h, 02h, 0fh, 19h, 19h, 0fh, 19h, 00h
                        db 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 0fh, 1Dh, 1Dh, 00h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 19h, 0fh, 0fh, 1Dh, 19h, 00h
                        db 00h, 1Dh, 02h, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 19h, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

                         
    menutower_seg1      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h      
                        db 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 00h, 00h
                        db 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 02h, 02h, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 19h, 19h, 00h      
                        db 0fh, 0fh, 19h, 19h, 19h, 02h, 02h, 02h, 02h, 0fh, 0fh, 02h, 0fh, 19h, 0fh, 02h, 02h, 02h, 00h, 0fh, 0fh, 0fh, 02h, 0fh, 02h, 02h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 02h, 02h, 02h, 19h, 19h, 0fh, 0fh, 0fh, 19h, 0fh, 19h, 00h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 1Dh, 00h      
                        db 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 0fh, 0fh, 02h, 0fh, 19h, 0fh, 0fh, 02h, 0fh, 1Dh, 00h, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 02h, 0fh, 19h, 0fh, 02h, 02h, 02h, 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 0fh, 19h, 19h, 1Dh, 00h, 0fh, 0fh, 0fh, 19h, 02h, 02h, 0fh, 0fh, 0fh, 19h, 0fh, 1Dh, 00h      
                        db 02h, 02h, 02h, 02h, 02h, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 19h, 19h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 02h, 19h, 0fh, 02h, 02h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 19h, 0fh, 02h, 0fh, 19h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h      
                        db 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 19h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 1Dh, 1Dh, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 19h, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 1Dh, 00h, 19h, 19h, 0fh, 0fh, 02h, 02h, 0fh, 19h, 19h, 0fh, 1Dh, 1Dh, 00h      
                        db 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 02h, 02h, 1Dh, 1Dh, 1Dh, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h      
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 00h, 00h, 00h, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 19h, 19h, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 00h, 00h
                        db 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 00h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 0fh, 19h, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 19h, 19h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h      
                        db 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 00h, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 19h, 19h, 0fh, 0fh, 19h, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 02h, 02h, 0fh, 19h, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 19h, 0fh, 0fh, 0fh, 1Dh, 00h      
                        db 0fh, 02h, 02h, 0fh, 19h, 02h, 02h, 0fh, 0fh, 1Dh, 1Dh, 00h, 00h, 0fh, 19h, 19h, 0fh, 0fh, 02h, 02h, 19h, 0fh, 19h, 0fh, 0fh, 1Dh, 1Dh, 00h, 00h, 19h, 19h, 0fh, 02h, 02h, 19h, 0fh, 1Dh, 00h, 0fh, 19h, 0fh, 1Dh, 1Dh, 02h, 00h, 0fh, 19h, 0fh, 0fh, 02h, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h      
                        db 02h, 02h, 0fh, 19h, 0fh, 02h, 02h, 0fh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 0fh, 19h, 19h, 02h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 0fh, 19h, 02h, 0fh, 0fh, 0fh, 1Dh, 00h, 0fh, 19h, 1Dh, 1Dh, 02h, 02h, 00h, 00h, 0fh, 19h, 0fh, 02h, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h      
                        db 0fh, 19h, 19h, 19h, 0fh, 02h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 0fh, 0fh, 1Dh, 1Dh, 00h, 0fh, 0fh, 19h, 00h, 02h, 00h, 00h, 00h, 00h, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 1Dh, 1Dh, 00h      
                        db 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 1Dh, 19h, 00h, 00h, 00h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                         
    menutower_seg2      db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h      
                        db 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
                        db 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h
                        db 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 02h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 19h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 19h, 0fh, 19h, 02h, 02h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 0fh, 02h, 0fh, 02h, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 19h, 0fh, 02h, 02h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 19h, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 0fh, 0fh, 02h, 02h, 02h, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 19h, 0fh, 0fh, 0fh, 02h, 0fh, 1Dh, 00h
                        db 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 1Dh, 1Dh, 00h
                        db 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 1Dh, 1Dh, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 19h, 19h, 02h, 02h, 02h, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 00h, 00h
                        db 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 02h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 19h, 02h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 0fh, 1Dh, 00h
                        db 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 02h, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 0fh, 0fh, 02h, 0fh, 19h, 02h, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 1Dh, 00h
                        db 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 02h, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 19h, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 0fh, 19h, 0fh, 19h, 0fh, 19h, 0fh, 1Dh, 00h, 0fh, 02h, 02h, 02h, 0fh, 02h, 19h, 19h, 19h, 0fh, 0fh, 02h, 02h, 0fh, 1Dh, 00h
                        db 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 00h, 0fh, 19h, 19h, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 02h, 0fh, 0fh, 19h, 19h, 0fh, 0fh, 1Dh, 00h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 02h, 02h, 0fh, 0fh, 1Dh, 00h
                        db 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 02h, 02h, 02h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 1Dh, 1Dh, 00h, 0fh, 0fh, 0fh, 19h, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 19h, 0fh, 1Dh, 1Dh, 00h, 02h, 0fh, 0fh, 0fh, 0fh, 19h, 19h, 0fh, 02h, 02h, 02h, 0fh, 0fh, 1Dh, 1Dh, 00h
                        db 00h, 1Dh, 19h, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 0fh, 1Dh, 1Dh, 19h, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 19h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 19h, 1Dh, 1Dh, 1Dh, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

    enemy   db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 53h, 53h, 53h, 3Bh, 3Bh, 3Bh, 00h, 00h, 00h, 00h   
            db 00h, 3Bh, 00h, 00h, 00h, 53h, 53h, 3Bh, 3Bh, 3Bh, 3Bh, 23h, 3Bh, 23h, 23h, 00h, 00h 
            db 3Bh, 3Bh, 3Bh, 00h, 53h, 3Bh, 3Bh, 3Bh, 23h, 23h, 23h, 00h, 00h, 00h, 00h, 00h, 00h 
            db 2bh, 0fh, 3Bh, 00h, 53h, 00h, 00h, 00h, 3Bh, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h, 00h 
            db 2bh, 2Bh, 00h, 3Bh, 00h, 00h, 00h, 00h, 00h, 3Bh, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 53h, 0Ch, 00h, 0Ch, 00h, 00h, 00h, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 53h, 0Ch, 00h, 0Ch, 00h, 00h, 00h, 3Bh, 3Bh, 23h, 00h, 00h, 00h, 00h 
            db 00h, 00h, 00h, 53h, 00h, 00h, 00h, 00h, 00h, 00h, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h 
            db 00h, 00h, 00h, 3Bh, 3Bh, 00h, 00h, 00h, 00h, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 00h, 23h, 53h, 3Bh, 3Bh, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 53h, 00h, 23h, 0eh, 0eh, 23h, 00h, 3Bh, 23h, 23h, 00h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 53h, 00h, 00h, 0eh, 42h, 00h, 23h, 00h, 3Bh, 23h, 00h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 53h, 00h, 53h, 3Bh, 3Bh, 3Bh, 23h, 00h, 3Bh, 3Bh, 23h, 00h, 00h, 00h 
            db 00h, 3Bh, 00h, 3Bh, 00h, 00h, 3Bh, 00h, 23h, 00h, 00h, 00h, 3Bh, 3Bh, 23h, 00h, 00h 
            db 00h, 3Bh, 00h, 3Bh, 00h, 00h, 3Bh, 23h, 3Bh, 3Bh, 23h, 23h, 00h, 3Bh, 23h, 23h, 00h 
            db 00h, 00h, 3Bh, 00h, 3Bh, 3Bh, 23h, 23h, 23h, 23h, 23h, 23h, 23h, 00h, 23h, 23h, 00h
            db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    
    ingame_towerseg1    dB 00h, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 1Dh, 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 00h, 00h   
                        DB 19h, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 02h, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 02h, 02h, 02h, 1Dh, 00h
                        DB 0Fh, 19h, 19h, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 19h, 02h, 02h, 02h, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 02h, 02h, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 19h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 19h, 02h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 19h, 0Fh, 02h, 02h, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 19h, 19h, 1Dh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 19h, 02h, 02h, 0Fh, 0Fh, 1Dh, 00h
                        DB 00h, 1Dh, 1Dh, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 1Dh, 02h, 19h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 19h, 02h, 1Dh, 1Dh, 1Dh, 00h, 00h
                        DB 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 00h, 00h, 00h, 00h, 00h
                        DB 00h, 0Fh, 0Fh, 02h, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 00h, 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 00h, 00h
                        DB 0Fh, 0Fh, 19h, 02h, 19h, 19h, 02h, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 02h, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 19h, 19h, 02h, 02h, 02h, 02h, 0Fh, 02h, 02h, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 1Dh, 00h
                        DB 19h, 19h, 0Fh, 0Fh, 02h, 02h, 0Fh, 02h, 02h, 02h, 02h, 02h, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 19h, 19h, 19h, 0Fh, 19h, 19h, 02h, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 1Dh, 02h, 02h, 02h, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 1Dh, 00h
                        DB 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 02h, 02h, 02h, 00h, 00h
                        DB 00h, 02h, 02h, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 19h, 0Fh, 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 02h, 0Fh, 0Fh, 0Fh, 00h, 00h
                        DB 0Fh, 0Fh, 19h, 02h, 0Fh, 19h, 0Fh, 19h, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 19h, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 02h, 02h, 02h, 19h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 19h, 02h, 02h, 0Fh, 0Fh, 0Fh, 02h, 19h, 19h, 19h, 19h, 02h, 02h, 02h, 19h, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 1Dh, 00h
                        DB 19h, 19h, 0Fh, 19h, 02h, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 19h, 19h, 02h, 02h, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 02h, 19h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 1Dh, 00h
                        DB 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 19h, 02h, 02h, 0Fh, 1Dh, 1Dh, 00h, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 1Dh, 00h
                        DB 00h, 1Dh, 1Dh, 1Dh, 02h, 1Dh, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 00h, 00h, 00h, 19h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    
    ingame_towerseg2    DB 00h, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 00h, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 00h
                        DB 0Fh, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 02h, 02h, 0Fh, 0Fh, 19h, 0Fh, 19h, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 02h, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 19h, 02h, 1Dh, 00h, 00h, 0Fh, 0Fh, 19h, 0Fh, 19h, 0Fh, 1Dh, 02h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 00h, 0Fh, 1Dh, 00h, 00h, 0Fh, 0Fh, 0Fh, 19h, 19h, 02h, 00h
                        DB 0Fh, 19h, 19h, 02h, 02h, 1Dh, 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 1Dh, 00h, 02h, 0Fh, 02h, 0Fh, 0Fh, 00h, 0Fh, 1Dh, 00h, 00h, 02h, 0Fh, 0Fh, 0Fh, 02h, 02h, 00h
                        DB 19h, 19h, 0Fh, 02h, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 00h, 02h, 00h, 02h, 02h, 0Fh, 00h, 1Dh, 00h, 00h, 00h, 02h, 02h, 0Fh, 02h, 02h, 1Dh, 00h
                        DB 00h, 1Dh, 1Dh, 1Dh, 02h, 02h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 02h, 02h, 00h, 1Dh, 02h, 02h, 1Dh, 1Dh, 00h, 00h, 00h, 02h, 1Dh, 1Dh, 02h, 1Dh, 1Dh, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 00h, 00h, 00h, 00h, 02h, 00h, 00h, 00h, 00h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        DB 00h, 19h, 0Fh, 0Fh, 1Dh, 00h, 00h, 00h, 00h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 02h, 02h, 0Fh, 1Dh, 00h, 00h, 02h, 00h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 19h, 02h, 0Fh, 1Dh, 00h, 00h, 00h, 00h, 19h, 19h, 02h, 0Fh, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 02h, 0Fh, 0Fh, 1Dh, 00h, 00h, 02h, 00h, 0Fh, 19h, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 02h, 02h, 19h, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 0Fh, 02h, 02h, 1Dh, 00h, 00h, 00h, 00h, 02h, 0Fh, 0Fh, 19h, 1Dh, 00h, 00h, 00h, 02h, 0Fh, 19h, 19h, 0Fh, 1Dh, 00h
                        DB 0Fh, 02h, 19h, 19h, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 0Fh, 0Fh, 02h, 1Dh, 00h, 00h, 00h, 00h, 02h, 0Fh, 0Fh, 0Fh, 19h, 00h, 00h, 00h, 00h, 0Fh, 19h, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 19h, 0Fh, 19h, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 19h, 0Fh, 02h, 02h, 00h, 00h, 00h, 00h, 0Fh, 19h, 0Fh, 19h, 1Dh, 00h, 00h, 00h, 00h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 19h, 0Fh, 0Fh, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 0Fh, 19h, 19h, 02h, 00h, 00h, 00h, 00h, 0Fh, 19h, 19h, 0Fh, 1Dh, 00h, 00h, 00h, 00h, 0Fh, 0Fh, 0Fh, 1Dh, 1Dh, 00h
                        DB 00h, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 19h, 1Dh, 00h, 00h, 00h, 00h, 1Dh, 1Dh, 19h, 1Dh, 1Dh, 00h, 00h, 00h, 00h, 1Dh, 02h, 02h, 1Dh, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

    ingame_towerseg3    DB 00h, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 00h, 00h
                        DB 0Fh, 0Fh, 0Fh, 02h, 19h, 19h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 02h, 02h, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 0Fh, 02h, 19h, 0Fh, 0Fh, 19h, 19h, 1Dh, 00h, 0Fh, 0Fh, 02h, 0Fh, 19h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 19h, 02h, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 02h, 02h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 02h, 02h, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 1Dh, 00h, 0Fh, 0Fh, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 1Dh, 00h
                        DB 00h, 02h, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h, 1Dh, 1Dh, 1Dh, 02h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 02h, 1Dh, 1Dh, 1Dh, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h, 02h, 02h, 02h, 00h, 00h, 00h
                        DB 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 19h, 19h, 0Fh, 00h, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 00h, 00h
                        DB 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 0Fh, 02h, 0Fh, 0Fh, 0Fh, 02h, 02h, 19h, 19h, 19h, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 02h, 02h, 1Dh, 00h
                        DB 19h, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 0Fh, 19h, 19h, 19h, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 19h, 19h, 19h, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 02h, 1Dh, 00h
                        DB 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 02h, 02h, 19h, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 19h, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 19h, 19h, 19h, 19h, 0Fh, 0Fh, 19h, 02h, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 19h, 19h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 00h
                        DB 0Fh, 0Fh, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 19h, 0Fh, 0Fh, 0Fh, 02h, 02h, 02h, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 1Dh, 00h, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 1Dh, 1Dh, 00h
                        DB 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 02h, 02h, 02h, 02h, 1Dh, 1Dh, 1Dh, 00h, 00h, 00h, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 1Dh, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    
    obstacle_left   DB 00h, 00h, 00h, 00h, 00h, 00h, 29h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h      
                    DB 00h, 00h, 00h, 00h, 00h, 00h, 48h, 29h, 29h, 29h, 00h, 00h, 29h, 00h, 00h, 29h, 29h, 29h
                    DB 00h, 00h, 00h, 00h, 00h, 29h, 02h, 48h, 48h, 02h, 29h, 29h, 79h, 29h, 29h, 79h, 79h, 79h
                    DB 00h, 00h, 00h, 00h, 29h, 48h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 79h, 79h, 79h, 02h, 02h
                    DB 00h, 00h, 00h, 48h, 02h, 02h, 79h, 79h, 79h, 79h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 79h
                    DB 00h, 00h, 00h, 29h, 02h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 02h, 02h, 02h, 02h, 79h, 79h
                    DB 00h, 00h, 29h, 48h, 02h, 79h, 79h, 29h, 29h, 79h, 48h, 79h, 79h, 79h, 79h, 79h, 79h, 79h
                    DB 00h, 00h, 29h, 48h, 02h, 79h, 29h, 00h, 00h, 00h, 29h, 48h, 79h, 79h, 79h, 79h, 79h, 79h
                    DB 00h, 29h, 29h, 00h, 79h, 29h, 00h, 00h, 00h, 00h, 00h, 29h, 29h, 29h, 79h, 02h, 79h, 79h
                    DB 29h, 48h, 48h, 00h, 00h, 48h, 29h, 00h, 00h, 48h, 48h, 48h, 48h, 48h, 02h, 02h, 02h, 79h
                    DB 48h, 02h, 29h, 29h, 29h, 02h, 48h, 48h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 79h, 29h 
                    DB 48h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 79h, 79h, 02h, 02h, 02h, 02h, 79h, 79h, 29h 
                    DB 29h, 79h, 02h, 79h, 79h, 79h, 79h, 02h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 29h, 00h
                    DB 00h, 29h, 79h, 79h, 79h, 29h, 79h, 48h, 02h, 79h, 29h, 29h, 79h, 79h, 79h, 79h, 79h, 00h
                    DB 29h, 00h, 29h, 79h, 29h, 00h, 29h, 48h, 02h, 02h, 29h, 00h, 29h, 79h, 29h, 29h, 79h, 00h
                    DB 00h, 29h, 00h, 29h, 00h, 00h, 48h, 29h, 02h, 02h, 02h, 02h, 00h, 00h, 00h, 00h, 29h, 00h
                    DB 00h, 00h, 00h, 00h, 00h, 00h, 29h, 00h, 29h, 29h, 29h, 29h, 00h, 00h, 00h, 00h, 00h, 00h

    obstacle_right  DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 29h, 00h, 00h, 00h, 00h, 00h, 00h
                    DB 29h, 29h, 29h, 00h, 00h, 29h, 00h, 00h, 29h, 29h, 29h, 48h, 00h, 00h, 00h, 00h, 00h, 00h
                    DB 79h, 79h, 79h, 29h, 29h, 79h, 29h, 29h, 02h, 48h, 48h, 02h, 29h, 00h, 00h, 00h, 00h, 00h
                    DB 02h, 02h, 79h, 79h, 79h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 48h, 29h, 00h, 00h, 00h
                    DB 79h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 79h, 79h, 79h, 02h, 02h, 48h, 00h, 00h, 00h
                    DB 79h, 79h, 02h, 02h, 02h, 02h, 79h, 79h, 79h, 79h, 79h, 79h, 02h, 79h, 02h, 00h, 00h, 00h
                    DB 79h, 79h, 79h, 79h, 79h, 79h, 79h, 48h, 79h, 29h, 29h, 79h, 79h, 02h, 48h, 29h, 00h, 00h
                    DB 79h, 79h, 79h, 79h, 79h, 79h, 48h, 29h, 00h, 00h, 00h, 29h, 79h, 02h, 48h, 29h, 00h, 00h
                    DB 79h, 79h, 02h, 79h, 29h, 29h, 29h, 00h, 00h, 00h, 00h, 00h, 29h, 79h, 00h, 29h, 29h, 00h
                    DB 79h, 02h, 02h, 02h, 02h, 02h, 02h, 48h, 48h, 48h, 48h, 48h, 00h, 00h, 29h, 48h, 48h, 29h
                    DB 29h, 79h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 48h, 48h, 02h, 29h, 02h, 29h, 02h, 48h
                    DB 29h, 79h, 79h, 02h, 02h, 02h, 02h, 79h, 79h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h, 48h
                    DB 00h, 29h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 79h, 02h, 79h, 02h, 79h
                    DB 00h, 79h, 79h, 79h, 79h, 79h, 79h, 29h, 29h, 79h, 02h, 48h, 79h, 29h, 79h, 79h, 29h, 00h
                    DB 00h, 79h, 29h, 29h, 79h, 29h, 00h, 29h, 02h, 02h, 48h, 29h, 00h, 29h, 79h, 29h, 00h, 29h
                    DB 00h, 29h, 00h, 00h, 00h, 00h, 02h, 02h, 02h, 02h, 29h, 48h, 00h, 00h, 29h, 00h, 29h, 00h
                    DB 00h, 00h, 00h, 00h, 00h, 00h, 29h, 29h, 29h, 29h, 00h, 29h, 00h, 00h, 00h, 00h, 00h, 00h


    Player_leftdark     db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h    
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 14h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 14h, 00h, 14h, 00h, 00h, 00h
                        db 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 14h, 00h, 14h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 14h, 00h, 14h, 00h, 00h, 14h, 00h
                        db 00h, 14h, 00h, 14h, 00h, 00h, 00h, 14h, 00h, 00h, 00h, 00h, 00h, 00h, 14h, 14h, 00h
                        db 00h, 00h, 14h, 14h, 00h, 00h, 00h, 14h, 00h, 14h, 14h, 00h, 14h, 00h, 14h, 14h, 00h
                        db 00h, 14h, 14h, 14h, 00h, 14h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 00h
                        db 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 00h, 00h
                        db 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 00h, 00h, 00h, 14h, 14h, 00h, 00h, 00h
                        db 00h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 14h, 14h, 14h, 14h, 00h, 14h, 00h, 00h, 00h
                        db 00h, 00h, 14h, 00h, 00h, 14h, 14h, 00h, 14h, 14h, 14h, 14h, 14h, 00h, 14h, 14h, 00h
                        db 00h, 00h, 00h, 14h, 14h, 00h, 00h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h
                        db 00h, 00h, 00h, 14h, 14h, 00h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h
                        db 00h, 14h, 14h, 00h, 00h, 00h, 14h, 00h, 14h, 14h, 14h, 14h, 00h, 00h, 00h, 14h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

    Player_rightdark    db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h    
                        db 00h, 00h, 00h, 00h, 00h, 14h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 14h, 00h, 14h, 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 00h, 00h
                        db 00h, 00h, 14h, 00h, 14h, 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 00h
                        db 14h, 00h, 00h, 14h, 00h, 14h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 14h, 14h, 00h, 00h, 00h, 00h, 00h, 00h, 14h, 00h, 00h, 00h, 14h, 00h, 14h, 00h, 00h
                        db 14h, 14h, 00h, 14h, 00h, 14h, 14h, 00h, 14h, 00h, 00h, 00h, 14h, 14h, 00h, 00h, 00h
                        db 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 14h, 00h, 14h, 14h, 14h, 00h, 00h
                        db 00h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 00h
                        db 00h, 00h, 14h, 14h, 00h, 00h, 00h, 00h, 14h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 00h
                        db 00h, 00h, 14h, 00h, 14h, 14h, 14h, 14h, 00h, 14h, 14h, 14h, 14h, 14h, 14h, 00h, 00h
                        db 14h, 14h, 00h, 14h, 14h, 14h, 14h, 14h, 00h, 14h, 14h, 00h, 00h, 14h, 00h, 00h, 00h
                        db 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 00h, 00h, 14h, 14h, 00h, 00h, 00h, 00h
                        db 14h, 14h, 00h, 14h, 14h, 00h, 14h, 14h, 00h, 14h, 00h, 14h, 14h, 00h, 00h, 00h, 00h
                        db 14h, 00h, 00h, 00h, 14h, 14h, 14h, 14h, 00h, 14h, 00h, 00h, 00h, 14h, 14h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
                        db 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    
    RightsideBox        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh
                        db 0fh, 0fh, 00h, 00h,0fh,0fh,0fh

    LeftsideBox         db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh
                        db 0fh,0fh,00h,00h,0fh,0fh,0fh

.code

org 0100h
    main proc far
        mov ax, @data
        mov ds, ax

        call generateseed            
        call default_gamevalue
        call clear_screen

        mov ah, 2ch                      
        int 21h      
        mov prevtime, dh                 

        check_state:
            call check_stop_note

            cmp game_state, 0
            jne check_game1
            jmp menu_screen

        check_game1:
            cmp game_state, 1
            jne check_game2
            jmp playing_game

        check_game2:
            cmp game_state, 2
            jne check_game3
            jmp game_over

        check_game3:
            cmp game_state, 3
            jne check_game4
            jmp tutorial_screen

        check_game4:
            cmp game_state, 4
            jne check_state_end
            jmp pause_screen

        check_state_end:
            ret


        menu_screen:
            call clear_screen
            call check_stop_note
            call menuscreen_printtext
            call render_menutower
            call render_sideboxmenu
            call menu_input
            
            call check_state
        playing_game:
            call check_tick
            call check_stop_note
            call update_difficulty
            call clear_screen
            call playinggame_input          
            call move_tower
            call move_obstacle
            call move_enemy
            call move_icicle
            call move_coin
            call update_coinvalue
            call update_coinactive
            call coin_collission
            call move_speed
            call update_speedactive
            call speed_collision
            call move_double_score
            call update_double_scoreactive
            call double_score_collision
            call playinggame_printtext
            call render_gametower
            call render_char
            call render_obstacle
            call render_icicle
            call render_enemy
            call render_coin
            call render_speed
            call render_double_score
            call render_poweruplogo
            call render_double_score_logo
            call check_collission
            call update_enemydifficulty
            
            call check_state
        game_over:
            call check_stop_note
            call render_chardeathanimation
            call check_stop_note
            call clear_screen
            call check_stop_note
            call gameover_rendersprite
            call render_sideboxover
            call printhigh
            call gameover_printtext
            call generateseed
            call gameover_input          

            call check_state
        tutorial_screen:
            call clear_screen
            call tutorial_printscreen          
            call tutorial_input   

            call check_state
        pause_screen:                       ; pause screen game_state added
            call clear_screen
            call show_pause_screen
            call playinggame_input

            call check_state

    main endp

    coin_collission proc
         
         
         
        cmp coin_state, 0                        
        je exit_coincollission2
        jmp check_coincollission

        exit_coincollission2: ret

        check_coincollission:
        
        mov ax, char_x
        add ax, char_size
        cmp ax, coinx
        jng exit_coincollission2

        mov ax, coinx
        add ax, char_size
        cmp char_x, ax
        jnl exit_coin_collission

        mov ax, char_y
        add ax, char_size
        cmp ax, coiny
        jng exit_coin_collission

        mov ax, coiny
        add ax, char_size
        cmp char_y, ax
        jnl exit_coin_collission

         
        cmp coin_state, 2
        jne exit_coin_collission

        call increment_score
        call sound_coin

        cmp coin_value, 1
        je add_1points

        cmp coin_value, 2
        je add_2points

        cmp coin_value, 5
        je add_5points

        add_1points:
            mov al, 1
            call apply_double_score
            add score_ones, al
            mov coin_state, 3
            jmp exit_coin_collission
        add_2points:
            mov al, 2
            call apply_double_score
            add score_ones, al
            mov coin_state, 3
            jmp exit_coin_collission
        add_5points:
            mov al, 5
            call apply_double_score
            add score_ones, al
            mov coin_state, 3
            jmp exit_coin_collission

        exit_coin_collission:   
            call calculate_overallscore
            ret
    coin_collission endp

    update_coinvalue proc near
        call calculate_overallscore
        cmp score_overallhex, 100
        jl set_coinsilver

        cmp score_overallhex, 200
        jl set_coingold

        cmp score_overallhex, 999
        jl set_coinruby

        set_coinsilver:
            mov coin_value, 1
            mov coin_interval, 1
            ret

        set_coingold:
            mov coin_value, 2
            mov coin_interval, 2
            ret 

        set_coinruby:
            mov coin_value, 5
            mov coin_interval, 4
            ret

        exit_update_coinvalue:  ret
    update_coinvalue endp

    update_coinactive proc near
        cmp coin_state, 0
        jne exit_update_coinactive
        
        mov ah, 2ch                  
        int 21h
        xor ax, ax
        mov al, dh                   
        mov bl, coin_interval        
        div bl                       
        cmp ah, 0                    
        jne exit_update_coinactive
        mov coin_state, 1

        exit_update_coinactive: ret
    update_coinactive endp
    

    render_coin proc near
        cmp coin_state, 2
        jne exit_rendercoin
        
        cmp coin_value, 1
        je render_silvercoin

        cmp coin_value, 2
        je render_goldcoin

        cmp coin_value, 5
        je render_rubycoin

        jmp exit_rendercoin

        exit_rendercoin:    ret
        render_silvercoin:
            mov si, offset coinsilver            
            mov ax, coinx
            add ax, 4
            mov rendercoordX, ax              
            mov ax, coiny
            add ax, 4
            mov rendercoordY, ax             
            mov _rendersizeX, 9           
            mov _rendersizeY, 9            
            call _rendersprite
            ret
            
        render_goldcoin:
            mov si, offset coin            
            mov ax, coinx
            add ax, 4
            mov rendercoordX, ax              
            mov ax, coiny
            add ax, 4
            mov rendercoordY, ax             
            mov _rendersizeX, 9             
            mov _rendersizeY, 9             
            call _rendersprite
            ret

        render_rubycoin:
            mov si, offset coinruby            
            mov ax, coinx
            add ax, 4
            mov rendercoordX, ax              
            mov ax, coiny
            add ax, 4
            mov rendercoordY, ax             
            mov _rendersizeX, 9             
            mov _rendersizeY, 9             
            call _rendersprite
            ret
    render_coin endp

    move_coin proc near
        cmp coin_state, 1                    
        jne move_coincondition2
        jmp coin_activating

        move_coincondition2:
        cmp coin_state, 2                    
        jne move_coincondition3
        jmp coin_descending

        move_coincondition3:
        cmp coin_state, 3                    
        jne exit_movecoin                    
        jmp coin_descending

        exit_movecoin:  ret

        coin_activating:
            mov si, 0
            mov ax, obs_ypos[si+0]
            cmp ax, 23
            jl check_nextcoinassign
            ret

            check_nextcoinassign:
                mov ax, obs_ypos[si]         
                mov coiny, ax
                mov ax, obs_xpos[si]         
                mov coinx, ax

            assign_coinx:
                call nurng                   
                cmp randomNum, 1
                je coin_position1
                cmp randomNum, 2
                je coin_position2
                cmp randomNum, 3
                je coin_position3
                cmp randomNum, 4
                je coin_position4
                jmp assign_coinx             

                coin_position1:
                    mov coinx, 135
                    mov ax, obs_xpos[si]
                    cmp coinx, ax
                    je coin_position2
                    jmp check_tempcoinx
                coin_position2:
                    mov coinx, 182
                    mov ax, obs_xpos[si]
                    cmp coinx, ax
                    je coin_position3
                    jmp check_tempcoinx
                coin_position3:
                    mov coinx, 223
                    mov ax, obs_xpos[si]
                    cmp coinx, ax
                    je coin_position4
                    jmp check_tempcoinx
                coin_position4:
                    mov coinx, 270
                    mov ax, obs_xpos[si]
                    cmp coinx, ax
                    je coin_position1
                    jmp check_tempcoinx

                check_tempcoinx:                         
                    mov coin_state, 2

        coin_descending:
            mov si, 0
            mov ax, obs_ypos[si]
            mov coiny, ax
            mov ax, y_bottomlimit
            cmp coiny, ax
            jng exit_coindescending
            mov coin_state, 0
            mov coiny, 0
            mov coinx, 0

            exit_coindescending:
            mov si, 0
            ret
    move_coin endp

    update_speedactive proc near
        cmp speed_state, 0
        jne exit_update_speedactive
        
        mov ah, 2Ch     
        int 21h
        xor ax, ax
        mov al, dh       
        mov bl, speed_interval
        div bl
        cmp ah, 0
        jne exit_update_speedactive

        mov speed_state, 1

        exit_update_speedactive:
            ret
    update_speedactive endp

    move_speed proc near
        cmp speed_state, 1
        jne speed_movecondition2
        jmp speed_activating

        speed_movecondition2:
            cmp speed_state, 2
            jne speed_movecondition3
            jmp speed_descending

        speed_movecondition3:
            cmp speed_state, 3
            jne exit_move_speed
            jmp speed_descending

        exit_move_speed:
            ret

        speed_activating:
            mov si, 0
            mov ax, obs_ypos[si]
            cmp ax, 23
            jl speed_assign
            ret

        speed_assign:
            mov ax, obs_ypos[si]
            mov speedy, ax
            mov ax, obs_xpos[si]
            mov speedx, ax

            call nurng
            cmp randomNum, 1
            je speed_pos1
            cmp randomNum, 2
            je speed_pos2
            cmp randomNum, 3
            je speed_pos3
            cmp randomNum, 4
            je speed_pos4
            jmp speed_assign

        speed_pos1:
            mov speedx, 135
            jmp activate_speed
        speed_pos2:
            mov speedx, 182
            jmp activate_speed
        speed_pos3:
            mov speedx, 223
            jmp activate_speed
        speed_pos4:
            mov speedx, 270
            jmp activate_speed

        activate_speed:
            mov speed_state, 2
            ret

        speed_descending:
            mov si, 0
            mov ax, obs_ypos[si]
            mov speedy, ax
            mov ax, y_bottomlimit
            cmp speedy, ax
            jng exit_speeddescend
            mov speed_state, 0
            mov speedy, 0
            mov speedx, 0

        exit_speeddescend:
            ret
    move_speed endp

    render_speed proc near
        cmp speed_state, 2
        jne exit_renderspeed

        mov si, offset speed    
        mov ax, speedx
        add ax, 0
        mov rendercoordX, ax
        mov ax, speedy
        add ax, 4
        mov rendercoordY, ax
        mov _rendersizeX, 17
        mov _rendersizeY, 15
        call _rendersprite

        exit_renderspeed:
            ret
    render_speed endp

    speed_collision proc
        cmp speed_state, 0
        je exit_speedcollision

        mov ax, char_x
        add ax, char_size
        cmp ax, speedx
        jng exit_speedcollision

        mov ax, speedx
        add ax, char_size
        cmp char_x, ax
        jnl exit_speedcollision

        mov ax, char_y
        add ax, char_size
        cmp ax, speedy
        jng exit_speedcollision

        mov ax, speedy
        add ax, char_size
        cmp char_y, ax
        jnl exit_speedcollision

        mov speed_state, 3
        call sound_power
        call activate_speedpower

        exit_speedcollision:
            ret
    speed_collision endp

    activate_speedpower proc
        mov has_speed, 1
        mov speed_timer, 10 
        mov y_velocity, 4 
        mov powerup_logo_active, 1

        ret
    activate_speedpower endp

    render_poweruplogo proc
        cmp powerup_logo_active, 1
        jne exit_renderpoweruplogo

        mov si, offset speed
        mov rendercoordX, 295
        mov rendercoordY, 8
        mov _rendersizeX, 17 
        mov _rendersizeY, 15
        call _rendersprite

    exit_renderpoweruplogo:
        ret
    render_poweruplogo endp


    update_double_scoreactive proc near
        cmp double_score_state, 0
        jne exit_update_double_scoreactive
        
        mov ah, 2Ch     
        int 21h
        xor ax, ax
        mov al, dh       
        mov bl, double_score_interval
        div bl
        cmp ah, 0
        jne exit_update_double_scoreactive

        mov double_score_state, 1

        exit_update_double_scoreactive:
            ret
    update_double_scoreactive endp

    move_double_score proc near
        cmp double_score_state, 1
        jne double_score_movecondition2
        jmp double_score_activating

        double_score_movecondition2:
            cmp double_score_state, 2
            jne double_score_movecondition3
            jmp double_score_descending

        double_score_movecondition3:
            cmp double_score_state, 3
            jne exit_move_double_score
            jmp double_score_descending

        exit_move_double_score:
            ret

        double_score_activating:
            mov si, 0
            mov ax, obs_ypos[si]
            cmp ax, 23
            jl double_score_assign
            ret

        double_score_assign:
            mov ax, obs_ypos[si]
            mov double_scorey, ax
            mov ax, obs_xpos[si]
            mov double_scorex, ax

            call nurng
            cmp randomNum, 1
            je double_score_pos1
            cmp randomNum, 2
            je double_score_pos2
            cmp randomNum, 3
            je double_score_pos3
            cmp randomNum, 4
            je double_score_pos4
            jmp double_score_assign

        double_score_pos1:
            mov double_scorex, 135
            jmp activate_double_score
        double_score_pos2:
            mov double_scorex, 182
            jmp activate_double_score
        double_score_pos3:
            mov double_scorex, 223
            jmp activate_double_score
        double_score_pos4:
            mov double_scorex, 270
            jmp activate_double_score

        activate_double_score:
            mov double_score_state, 2
            ret

        double_score_descending:
            mov si, 0
            mov ax, obs_ypos[si]
            mov double_scorey, ax
            mov ax, y_bottomlimit
            cmp double_scorey, ax
            jng exit_double_scoredescend
            mov double_score_state, 0
            mov double_scorey, 0
            mov double_scorex, 0

        exit_double_scoredescend:
            ret
    move_double_score endp

    render_double_score proc near
        cmp double_score_state, 2
        jne exit_renderdouble_score

        mov si, offset twice      
        mov ax, double_scorex
        add ax, 0
        mov rendercoordX, ax
        mov ax, double_scorey
        add ax, 4
        mov rendercoordY, ax
        mov _rendersizeX, 17
        mov _rendersizeY, 15
        call _rendersprite

        exit_renderdouble_score:
            ret
    render_double_score endp

    double_score_collision proc
        cmp double_score_state, 0
        je exit_double_scorecollision

        mov ax, char_x
        add ax, char_size
        cmp ax, double_scorex
        jng exit_double_scorecollision

        mov ax, double_scorex
        add ax, char_size
        cmp char_x, ax
        jnl exit_double_scorecollision

        mov ax, char_y
        add ax, char_size
        cmp ax, double_scorey
        jng exit_double_scorecollision

        mov ax, double_scorey
        add ax, char_size
        cmp char_y, ax
        jnl exit_double_scorecollision

        mov double_score_state, 3
        call sound_power
        call activate_double_scorepower

        exit_double_scorecollision:
            ret
    double_score_collision endp

    activate_double_scorepower proc
        mov has_double_score, 1
        mov double_score_timer, 10
        mov doublescore_logo_active, 1

        ret
    activate_double_scorepower endp

    apply_double_score proc near
        cmp has_double_score, 1
        jne skip_double
        add al, al      

        skip_double:
            ret
    apply_double_score endp

    render_double_score_logo proc
        cmp doublescore_logo_active, 1
        jne exit_render_double_score_logo

        mov si, offset twice 
        mov rendercoordX, 295 
        mov rendercoordY, 25
        mov _rendersizeX, 17
        mov _rendersizeY, 15
        call _rendersprite

    exit_render_double_score_logo:
        ret
    render_double_score_logo endp

    render_chardeathanimation proc near
        call sound_death
        mov ah, 2ch              
        int 21h

        mov tempmsecond, dh
        add tempmsecond, 4       
        cmp tempmsecond, 59 
        jng loop_renderdeath
        sub tempmsecond, 60

        loop_renderdeath:
            call check_stop_note
            cmp char_xfixedpos, 1
            je render_leftchardeath

            cmp char_xfixedpos, 3
            je render_leftchardeath

            cmp char_xfixedpos, 2
            je render_rightchardeath

            cmp char_xfixedpos, 4
            je render_rightchardeath

        render_leftchardeath:
            mov ah, 2ch              
            int 21h
            xor ax, ax
            mov al, dh       
            mov bl, 2        
            div bl           
            cmp ah, 0        
            je _renderleftdark
            jmp _renderleft

            _renderleft:
                mov si, offset Player_left       
                mov ax, char_x
                mov rendercoordX, ax                 
                mov ax, char_y
                mov rendercoordY, ax                 
                mov _rendersizeX, 17                 
                mov _rendersizeY, 17                 
                call _rendersprite     
                jmp check_renderdeathtime

            _renderleftdark:
                mov si, offset Player_leftdark       
                mov ax, char_x
                mov rendercoordX, ax                 
                mov ax, char_y
                mov rendercoordY, ax                 
                mov _rendersizeX, 17                 
                mov _rendersizeY, 17                 
                call _rendersprite
                jmp check_renderdeathtime

        render_rightchardeath:
            mov ah, 2ch              
            int 21h
            xor ax, ax
            mov al, dh       
            mov bl, 2        
            div bl           
            cmp ah, 0        
            je _renderrightdark
            jmp _renderright

            _renderright:
                mov si, offset Player_right       
                mov ax, char_x
                mov rendercoordX, ax                 
                mov ax, char_y
                mov rendercoordY, ax                 
                mov _rendersizeX, 17                 
                mov _rendersizeY, 17                 
                call _rendersprite     
                jmp check_renderdeathtime

            _renderrightdark:
                mov si, offset Player_rightdark       
                mov ax, char_x
                mov rendercoordX, ax                 
                mov ax, char_y
                mov rendercoordY, ax                 
                mov _rendersizeX, 17                 
                mov _rendersizeY, 17                 
                call _rendersprite
                jmp check_renderdeathtime

        check_renderdeathtime:
            mov ah, 2ch              
            int 21h
            cmp tempmsecond, dh              
            je exit_renderdeath
            jmp loop_renderdeath

        exit_renderdeath:   ret
    render_chardeathanimation endp

    tutorial_printscreen proc near               
        cmp tutorial_page, 1
        jne checkpage2
        jmp page1

        checkpage2:
        cmp tutorial_page, 2
        jne checkpage3
        jmp page2

        checkpage3:
        cmp tutorial_page, 3
        jne checkpage4
        jmp page3

        checkpage4:
        cmp tutorial_page, 4
        jne checkpage5
        jmp page4

        checkpage5:
        cmp tutorial_page, 5
        jne exit_tutprintscreen
        jmp page5

        exit_tutprintscreen:    ret
        page1:
            mov si, offset Player_left
            mov rendercoordX, 128
            mov rendercoordY, 79
            mov _rendersizeX, 17
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 48
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 64
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg2
            mov rendercoordX, 144
            mov rendercoordY, 80
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite
        
            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 96
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 112
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov bp, offset line1_menu        
            mov _stringx, 10
            mov _stringy, 2
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line1_pg1        
            mov _stringx, 12
            mov _stringy, 18
            mov _stringcolor, 0fh
            mov _stringlength, 17
            call _printtext

            mov bp, offset line2_pg1         
            mov _stringx, 11
            mov _stringy, 19
            mov _stringcolor, 0fh
            mov _stringlength, 19
            call _printtext

            mov bp, offset line3_tutorial         
            mov _stringx, 16
            mov _stringy, 23
            mov _stringcolor, 0eh
            mov _stringlength, 8
            call _printtext

             
            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21   
            mov dl, 17     
            int 10h
            mov ah, 09h              
            mov al, 07h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 5
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 17     
            int 10h
            mov ah, 09h              
            mov al, 09h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 23     
            int 10h
            mov ah, 09h              
            mov al, 1ah               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h
            ret
            
        page2:
            mov si, offset Player_right
            mov rendercoordX, 176
            mov rendercoordY, 95
            mov _rendersizeX, 17
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 48
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 64
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg2
            mov rendercoordX, 144
            mov rendercoordY, 80
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite
        
            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 96
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 112
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset twice
            mov rendercoordX, 128
            mov rendercoordY, 87
            mov _rendersizeX, 17
            mov _rendersizeY, 15
            call _rendersprite

            mov si, offset speed
            mov rendercoordX, 176
            mov rendercoordY, 60
            mov _rendersizeX, 17
            mov _rendersizeY, 15
            call _rendersprite

            mov bp, offset line1_menu        
            mov _stringx, 10
            mov _stringy, 2
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line1_pg2        
            mov _stringx, 13
            mov _stringy, 18
            mov _stringcolor, 0fh
            mov _stringlength, 16
            call _printtext


            mov bp, offset line2_pg2        
            mov _stringx, 9
            mov _stringy, 19
            mov _stringcolor, 0fh
            mov _stringlength, 24
            call _printtext

            mov bp, offset line3_tutorial         
            mov _stringx, 16
            mov _stringy, 23
            mov _stringcolor, 0eh
            mov _stringlength, 8
            call _printtext

             
            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 15     
            int 10h
            mov ah, 09h              
            mov al, 1bh               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21   
            mov dl, 17     
            int 10h
            mov ah, 09h              
            mov al, 07h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 5
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 18     
            int 10h
            mov ah, 09h              
            mov al, 09h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 23     
            int 10h
            mov ah, 09h              
            mov al, 1ah               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h
            ret

        page3:
            mov si, offset Player_left
            mov rendercoordX, 128
            mov rendercoordY, 95
            mov _rendersizeX, 17
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset enemy
            mov rendercoordX, 195
            mov rendercoordY, 52
            mov _rendersizeX, 17
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 48
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 64
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg2
            mov rendercoordX, 144
            mov rendercoordY, 80
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite
        
            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 96
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 112
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset obstacle_right
            mov rendercoordX, 175
            mov rendercoordY, 71
            mov _rendersizeX, 18
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset icicle
            mov rendercoordX, 132
            mov rendercoordY, 40
            mov _rendersizeX, 10
            mov _rendersizeY, 15
            call _rendersprite

            mov bp, offset line1_menu        
            mov _stringx, 10
            mov _stringy, 2
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

             
            mov ah, 02h     
            mov bh, 0     
            mov dh, 5              
            mov dl, 25          
            int 10h 

            mov ah, 0Eh            
            mov al, '!'
            mov bh, 0
            mov bl, 23h            
            int 10h

            mov bp, offset line1_menu        
            mov _stringx, 10
            mov _stringy, 2
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line1_pg3         
            mov _stringx, 9
            mov _stringy, 18
            mov _stringcolor, 0fh
            mov _stringlength, 23
            call _printtext

            mov bp, offset line2_pg3         
            mov _stringx, 11
            mov _stringy, 19
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line3_tutorial         
            mov _stringx, 16
            mov _stringy, 23
            mov _stringcolor, 0eh
            mov _stringlength, 8
            call _printtext

             
            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 15     
            int 10h
            mov ah, 09h              
            mov al, 1bh               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 17     
            int 10h
            mov ah, 09h              
            mov al, 07h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 5
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 19     
            int 10h
            mov ah, 09h              
            mov al, 09h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 23     
            int 10h
            mov ah, 09h              
            mov al, 1ah               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h
            ret

        page4:
            mov si, offset Player_right
            mov rendercoordX, 176
            mov rendercoordY, 79
            mov _rendersizeX, 17
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 48
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 64
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg2
            mov rendercoordX, 144
            mov rendercoordY, 80
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite
        
            mov si, offset ingame_towerseg3
            mov rendercoordX, 144
            mov rendercoordY, 96
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset ingame_towerseg1
            mov rendercoordX, 144
            mov rendercoordY, 112
            mov _rendersizeX, 33
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset obstacle_right
            mov rendercoordX, 175
            mov rendercoordY, 55
            mov _rendersizeX, 18
            mov _rendersizeY, 17
            call _rendersprite

            mov si, offset obstacle_right
            mov rendercoordX, 175
            mov rendercoordY, 103
            mov _rendersizeX, 18
            mov _rendersizeY, 17
            call _rendersprite
        
            mov si, offset obstacle_left
            mov rendercoordX, 128
            mov rendercoordY, 79
            mov _rendersizeX, 18
            mov _rendersizeY, 17
            call _rendersprite

            mov bp, offset line1_menu        
            mov _stringx, 10
            mov _stringy, 2
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line1_pg4         
            mov _stringx, 11
            mov _stringy, 18
            mov _stringcolor, 0fh
            mov _stringlength, 18
            call _printtext

            mov bp, offset line2_pg4         
            mov _stringx, 14
            mov _stringy, 19
            mov _stringcolor, 0fh
            mov _stringlength, 13
            call _printtext

            mov bp, offset line3_tutorial         
            mov _stringx, 16
            mov _stringy, 23
            mov _stringcolor, 0eh
            mov _stringlength, 8
            call _printtext

             
            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 15     
            int 10h
            mov ah, 09h              
            mov al, 1bh               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 17     
            int 10h
            mov ah, 09h              
            mov al, 07h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 5
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 20     
            int 10h
            mov ah, 09h              
            mov al, 09h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 23     
            int 10h
            mov ah, 09h              
            mov al, 1ah               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h
            ret

        page5:
            mov si, offset coinsilver        
            mov rendercoordX, 119
            mov rendercoordY, 63
            mov _rendersizeX, 9
            mov _rendersizeY, 9
            call _rendersprite

            mov si, offset coin        
            mov rendercoordX, 119
            mov rendercoordY, 79
            mov _rendersizeX, 9
            mov _rendersizeY, 9
            call _rendersprite

            mov si, offset coinruby        
            mov rendercoordX, 119
            mov rendercoordY, 95
            mov _rendersizeX, 9
            mov _rendersizeY, 9
            call _rendersprite

            mov bp, offset line1_menu        
            mov _stringx, 10
            mov _stringy, 2
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line1_pg5        
            mov _stringx, 17
            mov _stringy, 8
            mov _stringcolor, 0fh
            mov _stringlength, 7
            call _printtext

            mov bp, offset line2_pg5        
            mov _stringx, 17
            mov _stringy, 10
            mov _stringcolor, 0fh
            mov _stringlength, 8
            call _printtext

            mov bp, offset line3_pg5        
            mov _stringx, 17
            mov _stringy, 12
            mov _stringcolor, 0fh
            mov _stringlength, 8
            call _printtext

            mov bp, offset line4_pg5         
            mov _stringx, 10
            mov _stringy, 18
            mov _stringcolor, 0fh
            mov _stringlength, 21
            call _printtext

            mov bp, offset line5_pg5         
            mov _stringx, 10
            mov _stringy, 19
            mov _stringcolor, 0fh
            mov _stringlength, 20
            call _printtext

            mov bp, offset line3_tutorial         
            mov _stringx, 16
            mov _stringy, 23
            mov _stringcolor, 0eh
            mov _stringlength, 8
            call _printtext

             
            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 15     
            int 10h
            mov ah, 09h              
            mov al, 1bh               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21  
            mov dl, 17     
            int 10h
            mov ah, 09h              
            mov al, 07h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 5
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 21    
            mov dl, 21     
            int 10h
            mov ah, 09h              
            mov al, 09h               
            mov bh, 0          
            mov bl, 0ah              
            mov cx, 1
            int 10h
            ret
    tutorial_printscreen endp

    tutorial_input proc near                     
        mov ah, 00h              
        int 16h   

	cmp ah, 4Bh
	je a_keyinput 

	cmp ah, 4Dh
	je d_keyinput

        cmp al, 'a'		            
        je a_keyinput            
        cmp al, 'A'              
        je a_keyinput            

        cmp al, 'd'	
        je d_keyinput
        cmp al, 'D'
        je d_keyinput

        cmp al, 'e'
        je e_keyinput
        cmp al, 'E'
        je e_keyinput

        jmp tutorial_input           

        a_keyinput:
            cmp tutorial_page, 1
            je tutorial_input
            dec tutorial_page
            ret
        d_keyinput:
            cmp tutorial_page, 5
            je tutorial_input
            inc tutorial_page
            ret
        e_keyinput:
            mov game_state, 0
            mov tutorial_page, 1
            ret
    tutorial_input endp

    menu_input proc near
        mov ah, 00h              
        int 16h                  
        cmp al, 's'              
        je menu_skeyinput     
        cmp al, 'S'              
        je menu_skeyinput     

        cmp al, 't'
        je menu_tkeyinput
        cmp al, 'T'
        je menu_tkeyinput

        cmp al, 'h'
        je menu_hkeyinput
        cmp al, 'H'
        je menu_hkeyinput
        


        jmp menu_input           

        menu_skeyinput:
            mov game_state, 1        
            ret

        menu_tkeyinput:
            mov game_state, 3        
        
        menu_hkeyinput:
            mov menu_page, 1
            ret
    menu_input endp
  
    menuscreen_printtext proc near
         

	     
        mov bp, offset line1_menu         
        mov _stringx, 10
        mov _stringy, 04
        mov _stringcolor, 0fh
        mov _stringlength, 20
        call _printtext

        mov bp, offset line3_menu         
        mov _stringx, 04
        mov _stringy, 13
        mov _stringcolor, 0eh
        mov _stringlength, 17
        call _printtext         

         
        mov bp, offset line4_menu         
        mov _stringx, 04
        mov _stringy, 15
        mov _stringcolor, 0eh
        mov _stringlength, 12
        call _printtext   


        ; these are just two horizontal lines
            mov ah, 02h     
            mov bh, 00h     
            mov dh, 02    
            mov dl, 08     
            int 10h
            mov ah, 09h              
            mov al, 05fh           
            mov bh, 0          
            mov bl, 0fh              
            mov cx, 24
            int 10h

            mov ah, 02h     
            mov bh, 00h     
            mov dh, 05    
            mov dl, 08     
            int 10h
            mov ah, 09h              
            mov al, 05fh           
            mov bh, 0          
            mov bl, 0fh              
            mov cx, 24
            int 10h  
            
        ret
    menuscreen_printtext endp

    render_menutower proc near
        mov si, offset menutower_topchest
        mov ax, menutowerx
        mov rendercoordX, ax
        mov ax, menutowerchesty
        mov rendercoordY, ax
        mov _rendersizeX, 57
        mov _rendersizeY, 24
        call _rendersprite

        mov si, offset menutower_seg1
        mov ax, menutowerx
        mov rendercoordX, ax
        mov rendercoordY, 103
        mov _rendersizeX, 57
        mov _rendersizeY, 17
        call _rendersprite

        mov si, offset menutower_seg2
        mov ax, menutowerx
        mov rendercoordX, ax
        mov rendercoordY, 119
        mov _rendersizeX, 57
        mov _rendersizeY, 17
        call _rendersprite

        mov si, offset menutower_seg1
        mov ax, menutowerx
        mov rendercoordX, ax
        mov rendercoordY, 135
        mov _rendersizeX, 57
        mov _rendersizeY, 17
        call _rendersprite

        mov si, offset menutower_seg2
        mov ax, menutowerx
        mov rendercoordX, ax
        mov rendercoordY, 151
        mov _rendersizeX, 57
        mov _rendersizeY, 17
        call _rendersprite

        mov si, offset menutower_seg1
        mov ax, menutowerx
        mov rendercoordX, ax
        mov rendercoordY, 167
        mov _rendersizeX, 57
        mov _rendersizeY, 17
        call _rendersprite

        mov si, offset menutower_seg2
        mov ax, menutowerx
        mov rendercoordX, ax
        mov rendercoordY, 183
        mov _rendersizeX, 57
        mov _rendersizeY, 17
        call _rendersprite
        xor si, si
        ret
    render_menutower endp

    render_sideboxmenu proc near
            mov si, offset RightsideBox       
            mov rendercoordX, 64
            mov rendercoordY, 25
            mov _rendersizeX, 07
            mov _rendersizeY, 23
            call _rendersprite

            mov si, offset LeftsideBox      
            mov rendercoordX, 250
            mov rendercoordY, 25
            mov _rendersizeX, 07
            mov _rendersizeY, 23
            call _rendersprite

     render_sideboxmenu endp

    render_icicle proc near

        cmp icicle_state, 1          
        je icicle_trackingrender

        cmp icicle_state, 2          
        je icicle_activerender

        jmp exit_rendericicle
        icicle_trackingrender:
            mov ah, 2ch                      
            int 21h                          

            xor ax, ax                       
            mov al, dl                       
            mov bl, 2                        
            div bl                           

            cmp ah, 0                        
            jne icicle_activerender          
            ret                              

        icicle_activerender:
            push si                          
            mov si, offset icicle            
            mov ax, iciclex
            mov rendercoordX, ax             
            mov ax, icicley
            mov rendercoordY, ax             
            mov _rendersizeX, 10             
            mov _rendersizeY, 15             
            call _rendersprite
            pop si                           
            jmp exit_rendericicle

        exit_rendericicle:  ret
    render_icicle endp

    move_icicle proc near    
        cmp icicle_state, 1              
        je icicle_tracking

        cmp icicle_state, 2              
        je icicle_active                 

        jmp exit_moveicicle              

        icicle_tracking:                 
            mov ax, char_x
            add ax, 4                    
            mov iciclex, ax         

            cmp enemy_state, 2
            je exit_moveicicle           

             
            mov icicle_state, 2          
            jmp exit_moveicicle
            
        icicle_active:
            mov ax, icicle_velocity
            add icicley, ax              

            mov ax, y_bottomlimit        
            add ax, 16
            cmp icicley, ax
            jle exit_moveicicle          

            mov icicle_state, 0          
            mov icicley, 8
            jmp exit_moveicicle
        exit_moveicicle:    ret
    move_icicle endp

    move_tower proc 
        push si                              
        mov si, offset towery                
                                             
        mov cx, 11                           

        loop_movetower:
            mov ax, y_velocity
            add [si], ax                     

            mov ax, y_bottomlimit
            add ax, 32                       
            cmp [si], ax                     
            jng loopcheck_movetower          

             
            mov ax, 9
            mov [si], ax                     

        loopcheck_movetower:
            add si, 2                        
            loop loop_movetower 
            pop si                           
            ret                              
    move_tower endp

    render_gametower proc near
        mov cx, 1                            
        mov towerx, 151                      

        tower_segment1:
            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax             
            mov ax, [si+0]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg1
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+6]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg1
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+12]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg1
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+18]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg1
            call _rendersprite

        tower_segment2:
            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+2]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg2
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+8]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg2
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+14]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg2
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+20]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg2
            call _rendersprite

        tower_segment3:
            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+4]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg3
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+10]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg3
            call _rendersprite

            mov si, offset towery
            mov ax, towerx
            mov rendercoordX, ax            
            mov ax, [si+16]
            mov rendercoordY, ax             
            mov _rendersizeX, 33             
            mov _rendersizeY, 16             
            mov si, offset ingame_towerseg3
            call _rendersprite

            cmp towerx, 239
            je exit_rendertower
            mov towerx, 239
            jmp tower_segment1

        exit_rendertower:
            mov si, 0
            ret
    render_gametower endp

    check_tick proc near
        mov ah, 2ch
        int 21h                  

        cmp dl, current_tick         
        jne changetick
        jmp check_state

        changetick:
            mov current_tick, dl         
            cmp prevtime, dh
            je exit_checktick

            mov prevtime, dh
            mov current_seconds, dh
            call increment_score

            cmp has_speed, 1
            jne skip_slowmotion_timer

            cmp speed_timer, 0
            je disable_slowmotion

            dec speed_timer
            jmp skip_slowmotion_timer

            disable_slowmotion:
                mov has_speed, 0
                mov y_velocity, 8  
                mov powerup_logo_active, 0

            skip_slowmotion_timer:

            cmp has_double_score, 1
            jne skip_double_timer

            cmp double_score_timer, 0
            je disable_double

            dec double_score_timer
            jmp skip_double_timer

            disable_double:
                mov has_double_score, 0
                mov doublescore_logo_active, 0

            skip_double_timer:

        exit_checktick:
            ret
    check_tick endp

    render_enemy proc near
        cmp enemy_state, 0               
        je exit_drawenemy

        mov si, offset enemy             
        mov ax, enemy_x
        mov rendercoordX, ax             
        mov ax, enemy_y
        mov rendercoordY, ax             
        mov _rendersizeX, 17             
        mov _rendersizeY, 17             
        call _rendersprite

        cmp enemy_state, 2              
        jne exit_drawenemy               
                                         

         
        mov ah, 2ch                      
        int 21h
        cmp tempmsecond, dh              
        jne exclamation                 

         
        mov enemy_state, 3

        exclamation:
            mov ah, 02h                  
            mov bh, 0     
            mov dh, 2                
            mov dl, 26               
            int 10h 

            mov ah, 0Eh              
            mov al, '!'
            mov bh, 0
            mov bl, 23h              
            int 10h

            mov ah, 2ch              
            int 21h

            xor ax, ax
            mov al, dl       
            mov bl, 2        
            div bl           

            cmp ah, 0        
            je draw_exclamation     
            ret

            draw_exclamation:
                mov ah, 02h              
                mov bh, 0     
                mov dh, 2               
                mov dl, 26              
                int 10h 

                mov ah, 0Eh              
                mov al, ' '
                mov bh, 0
                mov bl, 23h              
                int 10h
                jmp exit_drawenemy


        exit_drawenemy:
            ret
    render_enemy endp

    move_enemy proc near
        cmp enemy_state, 1           
        je descending

         
        
        cmp enemy_state, 3           
        je ascending

        ret

        ascending:
            cmp enemy_y, 8
            jle exit_ascending
            dec enemy_y
            ret

        exit_ascending:
            mov enemy_state, 0       
            ret

        descending:
            cmp enemy_y, 31
            jge exit_descending
            inc enemy_y
            ret

        exit_descending:
            mov enemy_state, 2       
            mov icicle_state, 1      
            mov ah, 2ch              
            int 21h

            mov tempmsecond, dh
            add tempmsecond, 2       
            cmp tempmsecond, 59
            jg adjust_tempmsecond
            ret

            adjust_tempmsecond:
                sub tempmsecond, 60
                ret
    move_enemy endp

    update_difficulty proc near          
        call calculate_overallscore
        mov si, 0 
         
        cmp score_overallhex, 100         
        jl lowdiff
        cmp score_overallhex, 200         
        jl mediumdiff
        cmp score_overallhex, 300
        jl intermediatediff
        cmp score_overallhex, 400
        jl harddiff
        jmp extremediff
        exit_updatediff:    ret
        lowdiff:
            mov .obs_activetemp[si+0], 1         
            mov .obs_activetemp[si+2], 0         
            mov .obs_activetemp[si+4], 0
            mov .obs_activetemp[si+6], 0
            mov .obs_activetemp[si+8], 0
            jmp beginupdate
        mediumdiff:
            mov .obs_activetemp[si+0], 1
            mov .obs_activetemp[si+2], 0
            mov .obs_activetemp[si+4], 0
            mov .obs_activetemp[si+6], 1
            mov .obs_activetemp[si+8], 0
            jmp beginupdate
        intermediatediff:
            mov .obs_activetemp[si+0], 1
            mov .obs_activetemp[si+2], 0
            mov .obs_activetemp[si+4], 1
            mov .obs_activetemp[si+6], 0
            mov .obs_activetemp[si+8], 1
            jmp beginupdate
        harddiff:
            mov .obs_activetemp[si+0], 1
            mov .obs_activetemp[si+2], 1
            mov .obs_activetemp[si+4], 0
            mov .obs_activetemp[si+6], 1
            mov .obs_activetemp[si+8], 1
            jmp beginupdate
        extremediff:
            mov .obs_activetemp[si+0], 1
            mov .obs_activetemp[si+2], 1
            mov .obs_activetemp[si+4], 1
            mov .obs_activetemp[si+6], 1
            mov .obs_activetemp[si+8], 1
            jmp beginupdate

        beginupdate:
            mov cx, 5                    
            
        updateactive:
            cmp obs_ypos[si], 7          
            jne skip_update
            mov ax, .obs_activetemp[si]
            mov obs_isactive[si], ax     

        skip_update:
            add si, 2                     
            loop updateactive             
            ret
    update_difficulty endp

    calculate_overallscore proc near
    	cmp score_ones, 10
   	    jl check_tens
    	sub score_ones, 10
    	inc score_tens
        check_tens:
    	cmp score_tens, 10
    	jl check_hund
    	sub score_tens, 10
    	inc score_hund
        check_hund:
    	cmp score_hund, 10
    	jl exit_adjust
        
        exit_adjust:
        xor ax, ax           
        mov score_overallhex, ax
        mov al, score_ones
        add score_overallhex, ax
        xor ax, ax           
        mov al, score_tens
        mov bl, 10
        mul bl
        add score_overallhex, ax
        xor ax, ax           
        mov al, score_hund
        mov bl, 100
        mul bl
        add score_overallhex, ax
        ret
    calculate_overallscore endp

    update_enemydifficulty proc
        cmp enemy_state, 0
        jne exit_updatteenemy
        cmp icicle_state, 0
        jne exit_updatteenemy  
        

        cmp score_overallhex, 100
        jl set_intervaleasy

        cmp score_overallhex, 200
        jl set_intervalmedium

        cmp score_overallhex, 300
        jl set_intervalintermediate

        cmp score_overallhex, 400
        jl set_intervalhard

        cmp score_overallhex, 250
        jl set_intervalextreme

        exit_updatteenemy:  ret

        set_intervaleasy:
            mov icicle_velocity, 4
            mov enemy_interval, 10
            jmp check_interval

        set_intervalmedium:
            mov icicle_velocity, 6
            mov enemy_interval, 8

            jmp check_interval

        set_intervalintermediate:
            mov icicle_velocity, 8
            mov enemy_interval, 7

            jmp check_interval

        set_intervalhard:
            mov icicle_velocity, 10
            mov enemy_interval, 4

            jmp check_interval

        set_intervalextreme:
            mov icicle_velocity, 16
            mov enemy_interval, 2
            jmp check_interval

        check_interval:
            
            mov ah, 2ch              
            int 21h
            xor ax, ax
            mov al, dh                   
            inc al
            mov bl, enemy_interval       
            div bl                       
            cmp ah, 0                    
            jne exit_updatteenemy             

        update_enemy:                    
            mov enemy_state, 1
            ret
    update_enemydifficulty endp

     
    _update_obsXpos proc near
        mov al, randomNum            

         
        cmp al, 01
        je obs1_position1
        
         
        cmp al, 02
        je obs1_position2

         
        cmp al, 03
        je obs1_position3

         
        cmp al, 04
        je obs1_position4

        ret                  

        obs1_position1:
            mov obs_xpos[si], 135
            ret

        obs1_position2:
            mov obs_xpos[si], 182
            ret

        obs1_position3:
            mov obs_xpos[si], 223
            ret

        obs1_position4:
            mov obs_xpos[si], 270
            ret

        obs1_exit_xupdate:
            ret
    _update_obsXpos endp

    nurng proc       
         
        mov ax, rngseed
        mov bx, 0A9h
        mul bx                 
        add ax, 1              
        mov rngseed, ax       
         

        xor dx, dx         
        mov bx, 5           
        div bx              
        inc dl
        mov randomNum, dl
        ret
    nurng endp

    generateseed proc near
        mov ah, 00h                  
        int 1ah
        mov rngseed, dx
        ret
    generateseed endp

    default_gamevalue proc near
        mov enemy_state, 1
        mov coin_state, 1
        mov icicley, 8
        mov icicle_state, 0
        mov si, 0
        mov y_velocity, 8
        mov doublescore_logo_active, 0
        mov powerup_logo_active, 0
         
        mov towery[si+0], 17
        mov towery[si+2], 33
        mov towery[si+4], 49
        mov towery[si+6], 65
        mov towery[si+8], 81
        mov towery[si+10], 97
        mov towery[si+12], 113
        mov towery[si+14], 129
        mov towery[si+16], 145
        mov towery[si+18], 162
        mov towery[si+20], 178

         
        mov enemy_state, 0
        mov enemy_y, 8

        mov si, 0
         
        mov obs_ypos[si+0], 23
        mov obs_ypos[si+2], 55
        mov obs_ypos[si+4], 87
        mov obs_ypos[si+6], 119
        mov obs_isactive[si+0], 1
        mov obs_isactive[si+2], 0
        mov obs_isactive[si+4], 0
        mov obs_isactive[si+6], 0
        mov obs_isactive[si+8], 0

        mov randomNum, 2              
        call _update_obsXpos
        mov char_xfixedpos, 1
        mov char_y, 0098h
        mov score_ones, 0
        mov score_hund, 0
        mov score_tens, 0
        mov allowscore, 0
        ret
    default_gamevalue endp 

    gameover_input proc near
        mov ah, 00h              
        int 16h                  
        cmp al, 'm'              
        je gameover_menu      
        cmp al, 'M'              
        je gameover_menu 

        cmp al, 'p'              
        je gameover_playagain       
        cmp al, 'P'              
        je gameover_playagain       

        jmp gameover_input           

        gameover_menu:
            mov game_state, 0
            call default_gamevalue
            call generateseed
            call _update_obsXpos
            ret
        gameover_playagain:
            call default_gamevalue
            call generateseed
            call _update_obsXpos
            mov game_state, 1
            ret
    gameover_input endp

    gameover_rendersprite proc near
            mov si, offset coin
            mov rendercoordX, 143
            mov rendercoordY, 70
            mov _rendersizeX, 9
            mov _rendersizeY, 9
            call _rendersprite

            mov si, offset coin
            mov rendercoordX, 155
            mov rendercoordY, 70
            mov _rendersizeX, 9
            mov _rendersizeY, 9
            call _rendersprite

            mov si, offset coin
            mov rendercoordX, 167
            mov rendercoordY, 70
            mov _rendersizeX, 9
            mov _rendersizeY, 9
            call _rendersprite

            mov si, offset Player_up
            mov rendercoordX, 150
            mov rendercoordY, 83
            mov _rendersizeX, 16
            mov _rendersizeY, 16
            call _rendersprite
    gameover_rendersprite endp

    render_sideboxover proc near
            mov si, offset RightsideBox       
            mov rendercoordX, 93
            mov rendercoordY, 25
            mov _rendersizeX, 07
            mov _rendersizeY, 23
            call _rendersprite

            mov si, offset LeftsideBox      
            mov rendercoordX, 220
            mov rendercoordY, 25
            mov _rendersizeX, 07
            mov _rendersizeY, 23
            call _rendersprite
        
    render_sideboxover endp

    gameover_printtext proc near        
             
            mov ah, 02h              
            mov bh, 00h     
            mov dh, 02    
            mov dl, 12     
            int 10h
            mov ah, 09h              
            mov al, 05fh           
            mov bh, 0          
            mov bl, 0fh              
            mov cx, 16
            int 10h

            mov ah, 02h              
            mov bh, 00h     
            mov dh, 05    
            mov dl, 12     
            int 10h
            mov ah, 09h              
            mov al, 05fh           
            mov bh, 0          
            mov bl, 0fh              
            mov cx, 16
            int 10h 

            mov bp, offset line1_over         
            mov _stringx, 15
            mov _stringy, 4
            mov _stringcolor, 04h
            mov _stringlength, 10
            call _printtext

            call Highscore
            mov bp, offset line2_over         
            mov _stringx, 10
            mov _stringy, 14
            mov _stringcolor, 0fh
            mov _stringlength, 11
            call _printtext
            call printhigh

            mov bp, offset line3_over        
            mov _stringx, 6
            mov _stringy, 21
            mov _stringcolor, 0eh
            mov _stringlength, 8
            call _printtext

            mov bp, offset line5_over        
            mov _stringx, 20
            mov _stringy, 21
            mov _stringcolor, 0eh
            mov _stringlength, 14
            call _printtext

            mov ah, 02h
            mov dh, 10h
            mov dl, 14h
            call .printscore

            mov bp, offset line4_over         
            mov _stringx, 10
            mov _stringy, 16
            mov _stringcolor, 0fh
            mov _stringlength, 11
            call _printtext


        
        ret
    gameover_printtext endp
    
    playinggame_printtext proc near
        mov ah, 02h          
        mov bh, 00h          
        mov dh, 02h          
        mov dl, 02h          
        int 10h
        mov ah, 09h
        mov dx, offset line1_game        
        int 21h

        mov ah, 02h
        mov bh, 00h
        mov dh, 03h
        mov dl, 02h
        int 10h
        mov ah, 09h
        mov dx, offset line2_game        
        int 21h

        mov ah, 02h
        mov bh, 00h
        mov dh, 10h
        mov dl, 02h
        int 10h
        mov ah, 09h
        mov dx, offset line5_game        
        int 21h

        call calculate_overallscore
        mov ah, 02h
        mov dh, 10h
        mov dl, 02h
        call .printscore

        mov ah, 02h
        mov bh, 00h
        mov dh, 06h
        mov dl, 02h
        int 10h
        mov ah, 09h
        mov dx, offset line7_game  
        int 21h

        mov ah, 02h
        mov bh, 00h
        mov dh, 07h
        mov dl, 02h
        int 10h
        mov ah, 09h
        mov dx, offset line6_game  
        int 21h

        mov ah, 02h
        mov bh, 00h
        mov dh, 08h
        mov dl, 02h
        int 10h
        mov ah, 09h
        mov dx, offset line8_game  
        int 21h

        ret
    playinggame_printtext endp

    playinggame_input proc near
        mov ah, 01h              
        int 16h
        jnz continue_input
        jmp exit_input         

        continue_input:
            mov ah, 00h
            int 16h


            cmp ah, 48h		    ; up arrow key
            je w_pressed
            
            
            cmp ah, 4Bh  		; left arrow key
            je a_pressed
            
            
            cmp ah, 4Dh  		; right arrow key
            je d_pressed

            
            cmp ah, 50h  		; down arrow key
            je s_pressed

            
            cmp al, 57h  
            je w_pressed
            cmp al, 77h  
            je w_pressed
            
            
            cmp al, 41h  
            je a_pressed
            cmp al, 61h  
            je a_pressed
            
            
            cmp al, 44h  
            je d_pressed
            cmp al, 64h  
            je d_pressed

            
            cmp al, 53h  
            je s_pressed
            cmp al, 73h  
            je s_pressed


            cmp al, 1bh         ; pause game
            je esc_pressed

            cmp al, 20h         ; resume game
            je space_pressed
            
            cmp al, 72h         ; restart game
            je r_pressed
            cmp al, 52h         ; restart game
            je r_pressed

            cmp al, 71h         ; quit game
            je q_pressed
            cmp al, 51h         ; quit game
            je q_pressed

            
            jmp exit_input

            w_pressed:
                call sound_move
                mov ax, y_toplimit       
                cmp char_y, ax
                je exit_input            

                
                mov ax, char_velocity
                sub char_y, ax
                jmp exit_input

            a_pressed:
                call sound_move
                mov ax, char_xfixedpos
                cmp ax, 01h
                je exit_input            

                
                dec char_xfixedpos
                jmp exit_input

            s_pressed:
                call sound_move
                mov ax, y_bottomlimit    
                cmp char_y, ax 
                je exit_input            

                
                mov ax, char_velocity
                add char_y, ax
                jmp exit_input

            d_pressed:
                call sound_move
                mov ax, char_xfixedpos
                cmp ax, 04h
                je exit_input            
            
                
                inc char_xfixedpos
                jmp exit_input

            esc_pressed:                        ; pause game
                mov game_state, 4
                jmp exit_input

            space_pressed:                      ; resume game
                cmp game_state, 4
                jne exit_input            
                mov game_state, 1
                jmp exit_input

            r_pressed:                          ; restart game  
                ;mov game_state, 0
                call default_gamevalue
                call generateseed
                call _update_obsXpos
                ret

            q_pressed:                          ; quit game  
                mov game_state, 0
                call default_gamevalue
                call generateseed
                call _update_obsXpos
                ret

            exit_input: 
                mov ax, char_xfixedpos

                
                cmp ax, 01h
                je position1
                
                
                cmp ax, 02h
                je position2

                
                cmp ax, 03h
                je position3

                
                cmp ax, 04h
                je position4

                position1:
                    mov char_x, 0087h
                    jmp exit_update

                position2:
                    mov char_x, 00b7h
                    jmp exit_update

                position3:
                    mov char_x, 00dfh
                    jmp exit_update

                position4:
                    mov char_x, 010fh
                    jmp exit_update

                exit_update:
                    ret
    playinggame_input endp

    show_pause_screen proc near         ; show pause screen
        mov ah, 0
        mov al, 03h 

        ;mov si, offset coinsilver
        ;mov rendercoordX, 100
        ;mov rendercoordY, 85
        ;mov _rendersizeX, 9
        ;mov _rendersizeY, 9
        ;call _rendersprite
        
        ;mov si, offset coin
        ;mov rendercoordX, 115
        ;mov rendercoordY, 85
        ;mov _rendersizeX, 9
        ;mov _rendersizeY, 9
        ;call _rendersprite

        ;mov si, offset coinruby
        ;mov rendercoordX, 130
        ;mov rendercoordY, 85
        ;mov _rendersizeX, 9
        ;mov _rendersizeY, 9
        ;call _rendersprite

        ;mov si, offset Player_up
        ;mov rendercoordX, 150
        ;mov rendercoordY, 80
        ;mov _rendersizeX, 16
        ;mov _rendersizeY, 16
        ;call _rendersprite

        ;mov si, offset coinruby
        ;mov rendercoordX, 180
        ;mov rendercoordY, 85
        ;mov _rendersizeX, 9
        ;mov _rendersizeY, 9
        ;call _rendersprite

        ;mov si, offset coin
        ;mov rendercoordX, 195
        ;mov rendercoordY, 85
        ;mov _rendersizeX, 9
        ;mov _rendersizeY, 9
        ;call _rendersprite
        
        ;mov si, offset coinsilver
        ;mov rendercoordX, 210
        ;mov rendercoordY, 85
        ;mov _rendersizeX, 9
        ;mov _rendersizeY, 9
        ;call _rendersprite

        mov bp, offset line1_pause
        mov _stringx, 08	
        mov _stringy, 13	
        mov _stringcolor, 0fh 	
        mov _stringlength, 24	
        call _printtext

        ret
    show_pause_screen endp

    check_collission proc near
         
         
         
        mov cx, 5
        push si
        mov si, 0

        collission_obstacle:
            cmp obs_isactive[si], 0          
            je exit_collissionobstacle
            
            mov ax, char_x
            add ax, char_size
            cmp ax, obs_xpos[si]
            jng exit_collissionobstacle

            mov ax, obs_xpos[si]
            add ax, char_size
            cmp char_x, ax
            jnl exit_collissionobstacle

            mov ax, char_y
            add ax, char_size
            cmp ax, obs_ypos[si]
            jng exit_collissionobstacle

            mov ax, obs_ypos[si]
            add ax, char_size
            cmp char_y, ax
            jnl exit_collissionobstacle

             
            mov game_state, 2          
            jmp check_state

         
        exit_collissionobstacle:
            add si, 2
            loop collission_obstacle
            pop si
        
         
         
         
        collission_icicle:
            cmp icicle_state, 0
            je exit_collission
            
            mov ax, char_x
            add ax, char_size
            cmp ax, iciclex
            jng exit_collission

            mov ax, iciclex
            add ax, char_size
            cmp char_x, ax
            jnl exit_collission

            mov ax, char_y
            sub ax, 2
            add ax, char_size
            cmp ax, icicley
            jng exit_collission

            mov ax, icicley
            add ax, char_size
            sub ax, 2
            cmp char_y, ax
            jnl exit_collission

             
            mov game_state, 2          
            jmp check_state
        exit_collission:    ret
    check_collission endp

    move_obstacle proc near        
         
        push si
        mov si, 0
        mov cx, 5                                    

        loophere:
            mov ax, y_velocity
            add obs_ypos[si], ax                     

            mov ax, y_bottomlimit
            add ax, 12
            cmp obs_ypos[si], ax                     
            jg returntop_obstacle                    

            add si, 2
            loop loophere                            
            pop si
            ret

        returntop_obstacle:
            mov allowscore, 1                        
            
            mov ax, 7
            mov obs_ypos[si], ax                     

            call nurng                               
            call _update_obsXpos
            add si, 2
            loop loophere                            
            pop si

            ret
    move_obstacle endp

    render_obstacle proc 
         
        render_obstacle1:
            mov _rendersizeX, 18             
            mov _rendersizeY, 17             
            mov si, offset obs_isactive
            mov ax, [si+0]
            cmp ax, 0
            je render_obstacle2
            mov si, offset obs_xpos
            mov ax, [si+0]
            mov rendercoordX, ax              
            mov si, offset obs_ypos
            mov ax, [si+0]
            inc ax
            mov rendercoordY, ax              
            mov si, 0
            call check_leftright
            call _rendersprite
            jmp render_obstacle2

         
        render_obstacle2:
            mov _rendersizeX, 18             
            mov _rendersizeY, 17             
            mov si, offset obs_isactive
            mov ax, [si+2]
            cmp ax, 0
            je render_obstacle3
            mov si, offset obs_xpos
            mov ax, [si+2]
            mov rendercoordX, ax              
            mov si, offset obs_ypos
            mov ax, [si+2]
            inc ax
            mov rendercoordY, ax              
            mov si, 2
            call check_leftright
            call _rendersprite
            jmp render_obstacle3

         
        render_obstacle3:
            mov _rendersizeX, 18             
            mov _rendersizeY, 17             
            mov si, offset obs_isactive
            mov ax, [si+4]
            cmp ax, 0
            je render_obstacle4
            mov si, offset obs_xpos
            mov ax, [si+4]
            mov rendercoordX, ax              
            mov si, offset obs_ypos
            mov ax, [si+4]
            inc ax
            mov rendercoordY, ax              
            mov si, 4
            call check_leftright
            call _rendersprite
            jmp render_obstacle4

         
        render_obstacle4:
            mov _rendersizeX, 18             
            mov _rendersizeY, 17             
            mov si, offset obs_isactive
            mov ax, [si+6]
            cmp ax, 0
            je render_obstacle5
            mov si, offset obs_xpos
            mov ax, [si+6]
            mov rendercoordX, ax              
            mov si, offset obs_ypos
            mov ax, [si+6]
            inc ax
            mov rendercoordY, ax              
            mov si, 6
            call check_leftright
            call _rendersprite
            jmp render_obstacle5

         
        render_obstacle5:
            mov _rendersizeX, 18             
            mov _rendersizeY, 17             
            mov si, offset obs_isactive
            mov ax, [si+8]
            cmp ax, 0
            je exit_renderobstacle
            mov si, offset obs_xpos
            mov ax, [si+8]
            mov rendercoordX, ax              
            mov si, offset obs_ypos
            mov ax, [si+8]
            inc ax
            mov rendercoordY, ax              
            mov si, 8
            call check_leftright
            call _rendersprite
            jmp exit_renderobstacle

        check_leftright:
            cmp obs_xpos[si], 135
            je render_obsleft

            cmp obs_xpos[si], 223
            je render_obsleft

            cmp obs_xpos[si], 182
            je render_obsright

            cmp obs_xpos[si], 270
            je render_obsright

        render_obsleft:
            mov si, offset obstacle_left             
            ret

        render_obsright:
            mov si, offset obstacle_right            
            ret

        exit_renderobstacle:    ret
    render_obstacle endp
   
         
         
         
         
         
         
         
         
         

    _rendersprite proc near          
        push ax
        push bx
        push cx
        push dx
        sub _rendersizeX, 2
        sub _rendersizeY, 2
        mov cx, rendercoordX
        mov dx, rendercoordY
        dec dx
        render_horizontal:
             
            mov ah, 0ch                  
            mov al, [si]                 
            mov bh, 00h                  
            int 10h                      

            inc cx
            inc si                           
            mov ax, cx
            sub ax, rendercoordX
            cmp ax, _rendersizeX
            jng render_horizontal        
                                         
             
            mov cx, rendercoordX
            inc dx
            inc si
            mov ax, dx 
            sub ax, rendercoordY
            cmp ax, _rendersizeY
            jng render_horizontal        
                                         
            pop ax
            pop bx
            pop cx
            pop dx
            ret
    _rendersprite endp
    

         
         
         
         
         
         
         

    _printtext proc
        mov  ax, ds
        mov  es, ax
        mov dh, _stringy
        mov dl, _stringx
        mov bl, _stringcolor
        mov cx, _stringlength
        mov ax, 1301h   
        mov bh, 00h    
        int 10h
        mov bp, 0
        ret 
    _printtext endp

    render_char proc near
        cmp char_xfixedpos, 1
        je render_leftchar
        cmp char_xfixedpos, 3
        je render_leftchar

        cmp char_xfixedpos, 2
        je render_rightchar
        cmp char_xfixedpos, 4
        je render_rightchar

        render_leftchar:
            mov si, offset Player_left        
            mov ax, char_x
            mov rendercoordX, ax              
            mov ax, char_y
            inc ax
            mov rendercoordY, ax              
            mov _rendersizeX, 17              
            mov _rendersizeY, 17              
            call _rendersprite
            ret

        render_rightchar:
            mov si, offset Player_right        
            mov ax, char_x
            mov rendercoordX, ax              
            mov ax, char_y
            mov rendercoordY, ax              
            mov _rendersizeX, 17              
            mov _rendersizeY, 17
            call _rendersprite
            ret
    render_char endp

    increment_score proc near
        cmp allowscore, 0
        je exit_increment

        mov al, score_rate
        call apply_double_score
        add score_ones, al
    	cmp score_ones, 10
   	    jl exit_increment

    	sub score_ones, 10
    	inc score_tens
    	cmp score_tens, 10
    	jl exit_increment

    	sub score_tens, 10
    	inc score_hund
    	cmp score_hund, 10
    	jl exit_increment
    
    	exit_increment: ret
    increment_score endp

    Highscore proc 
        xor ax, ax           
        mov .highscore, ax
        mov al, tempscore[si+0]
        add .highscore, ax
        xor ax, ax           
        mov al, tempscore[si+1]
        mov bl, 10
        mul bl
        add .highscore, ax
        xor ax, ax           
        mov al, tempscore[si+2]
        mov bl, 100
        mul bl
        add .highscore, ax

        mov ax, score_overallhex
        cmp .highscore, ax
        jnl exit_high
        jmp set_high

        set_high:
            mov al, score_ones
            mov tempscore[si], al    
            mov al, score_tens
            mov tempscore[si+1], al  
            mov al, score_hund
            mov tempscore[si+2], al  
            jmp exit_high
            

        exit_high:  ret
    Highscore endp

    printhigh proc
        mov si, 0
        mov ah, 02h
        mov dh, 14     
        mov dl, 27   
        int 10h

         
    	push dx
        mov dl, tempscore[si+2]
    	add dl, '0'
    	int 21h
        pop dx

    	inc dl               
   	    int 10h
        
         
    	push dx
        mov dl, tempscore[si+1]
    	add dl, '0'
    	int 21h
        pop dx

    	inc dl               
    	int 10h

         

    	push dx
        mov dl, tempscore[si+0]
    	add dl, '0'
    	int 21h
        pop dx

        ret

    printhigh endp

    .printscore proc near     
        add dl, 7        
        int 10h

         
    	push dx
        mov dl, score_hund
    	add dl, '0'
    	int 21h
        pop dx

    	inc dl               
   	    int 10h
        
         
    	push dx
        mov dl, score_tens
    	add dl, '0'
    	int 21h
        pop dx

    	inc dl               
    	int 10h

         
    	push dx
        mov dl, score_ones
    	add dl, '0'
    	int 21h
        pop dx

        ret
    .printscore endp

    sound_on proc
        push ax
        push dx
        mov al, 0B6h
        out 43h, al
        mov dx, ax
        out 42h, al
        mov al, ah
        out 42h, al
        in al, 61h
        or al, 03h
        out 61h, al
        pop dx
        pop ax
        ret
    sound_on endp

    sound_off proc
        in al, 61h
        and al, 0FCh
        out 61h, al
        ret
    sound_off  endp

    play_note:
        push ax
        push bx

        mov ah, 2ch
        int 21h
        mov start_time, dl
        mov note_duration, bl

        pop bx
        pop ax

        call sound_on
        ret

    check_stop_note:        
        mov ah, 2ch
        int 21h

        mov al, dl
        sub al, start_time

        cmp al, note_duration
        jb no_stop  


        call sound_off
        ret    

    no_stop:
        ret

    sound_coin:
        mov ax, la
        mov bl, 10
        call play_note
        mov ax, ti
        mov bl, 10
        call play_note
        ret

    sound_move:
        mov ax, do
        mov bl, 10
        call play_note    
        ret    

    sound_power:
        mov ax, mi
        mov bl, 10
        call play_note
        ret

    sound_death:
        mov ax, sol
        mov bl, 10
        call play_note
        mov ax, re
        mov bl, 10
        call play_note
        ret

    clear_screen proc near
        mov ah, 00h          
        mov al, 13h          
        int 10h              

        mov ah, 0bh
        mov bh, 00h
        mov bl, 00h
        int 10h
        ret
    clear_screen endp
end main