// 1. ENGINE LEVEL HIT FLASH
if (flash_timer > 0) { flash_timer--; image_blend = c_red; } else { image_blend = c_white; }

if (instance_exists(obj_cat)) {
    // 2. CHASE THE CAT
    var _dir = point_direction(x, y, obj_cat.x, obj_cat.y);
    x += lengthdir_x(move_speed, _dir);
    y += lengthdir_y(move_speed, _dir);
    
    // Görsel yön çevirme
    if (obj_cat.x < x) image_xscale = -1;
    else image_xscale = 1;
    
    // 3. MINION SUMMONING MECHANIC
    summon_timer--;
    if (summon_timer <= 0) {
        // Boss çığlık atarken 0.2 saniyeliğine tamamen kırmızı parlasın (Çığlık görseli efekti)
        flash_timer = 12; 
        
        // Rastgele 3 adet güçlü minyon fare çağır (Hızlı, Nişancı, Zırhlı veya Barutçu)
        repeat(3) {
            var _spawn_x = x + random_range(-50, 50);
            var _spawn_y = y + random_range(-50, 50);
            
            // Bizim eklediğimiz 4 özel fare objesinden birini rastgele seçip kralın yanında doğurur
            var _minion_type = choose(obj_fast_mouse, obj_ranged_mouse, obj_shield_mouse, obj_explosive_mouse);
            instance_create_layer(_spawn_x, _spawn_y, layer, _minion_type);
        }
        
        summon_timer = summon_cooldown; // Kronometreyi sıfırla
    }
}

// 4. BOSS DEATH LOGIC
if (hp <= 0) {
    // Öldüğünde etrafa tam bir kılçık serveti saçar!
    repeat(40) {
        var _bone = instance_create_layer(x + random_range(-25, 25), y + random_range(-25, 25), "Instances", obj_fishbone);
        _bone.value = 5;
    }
    
    // Gelişim ağacı için oyuncuya tam 2 Pati Puanı hediye eder!
    global.pati_points += 2;
    
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.wave_active = false;
    }
    
    global.total_kills += 1;
    room_goto(rm_skilltree); // Oyuncuyu gururla Gelişim Ağacına fırlatır
    instance_destroy(); // Hafızadan sil
}
