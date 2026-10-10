if (instance_exists(obj_cat)) {
    
    // -------------------------------------------------------------
    // MEKANİK 2: YUKARIDAN DÜŞEN TAŞ YAĞMURU
    // -------------------------------------------------------------
    // Her 80 karede bir rastgele taş yağdırır
    if (irandom(80) == 5) {
        instance_create_layer(obj_cat.x, obj_cat.y, layer, obj_falling_rock);
    }

    // -------------------------------------------------------------
    // YAPAY ZEKA DURUM MAKİNESİ (STATE MACHINE)
    // -------------------------------------------------------------
    
    // 1. WALK STATE
    if (state == "walk") {
        var _dir = point_direction(x, y, obj_cat.x, obj_cat.y);
        x += lengthdir_x(move_speed, _dir);
        y += lengthdir_y(move_speed, _dir);
        
        if (obj_cat.x < x) image_xscale = -1;
        else image_xscale = 1;
        
        attack_timer--;
        if (attack_timer <= 0) {
            state = "anticipation"; 
            attack_duration = 45; // 0.75 saniye boyunca parlayacak
        }
    }
    
    // 2. ANTICIPATION STATE (NİŞAN ALMA / UYARI)
    if (state == "anticipation") {
        attack_duration--;
        image_blend = c_red; // Kırmızıya bürün
        
        if (attack_duration <= 0) {
            state = "slash"; 
            attack_duration = 20; // Saldırı efekti ekranda 20 kare kalacak
            
            // HASAR MEKANİĞİ (DOĞRUDAN BURADA TETİKLENİYOR):
            // Eğer saldırı anında kedi boss'un tam önündeki 45 piksellik alandaysa HASAR YESİN!
            var _dist_to_cat = point_distance(x, y, obj_cat.x, obj_cat.y);
            if (_dist_to_cat <= 55) {
                obj_cat.current_hp -= 25; // 25 Pençe hasarı vur!
            }
        }
    }
    
    // 3. SLASH STATE (EFEKTİN EKRANDA KALMA SÜRESİ)
    if (state == "slash") {
        attack_duration--;
        image_blend = c_white; // Rengi normale döndür
        
        if (attack_duration <= 0) {
            state = "walk";
            attack_timer = 180; // Yeni saldırı için 3 saniye sayaç
        }
    }
}

// 4. BOSS ÖLÜM KONTROLÜ
if (hp <= 0) {
    repeat(15) {
        var _bone = instance_create_layer(x + random_range(-15, 15), y + random_range(-15, 15), "Instances", obj_fishbone);
        _bone.value = 5;
    }
    global.pati_points += 1;
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.wave_active = false;
    }
    global.total_kills += 1;
    room_goto(rm_skilltree);
    instance_destroy();
	    if (global.unlock_cat_instinct == 0) {
        global.unlock_cat_instinct = 1;
        show_message("[🔒 UNLOCKED!] 'Cat Instinct' can now appear in the Shop!");
        
        if (instance_exists(obj_global_init)) { obj_global_init.save_game_data(); }
    }

}
