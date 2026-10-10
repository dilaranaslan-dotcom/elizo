// 🧲 ENEMY SEPARATION (Sürü İtme Fiziği)
// Haritada kendine en yakın olan diğer fareyi bulur
var _nearest_enemy = instance_nearest(x, y, obj_enemy_parent);

// Eğer etrafta başka bir fare varsa ve o fare bizzat kendim değilsem
if (_nearest_enemy != noone && _nearest_enemy != id) {
    // Diğer fareyle aramdaki mesafeyi piksel olarak ölçüyorum
    var _dist_to_enemy = point_distance(x, y, _nearest_enemy.x, _nearest_enemy.y);
    
    // Eğer diğer fareyle 14 pikselden daha fazla iç içe girdiysek (üst üste biniyorsak)
    if (_dist_to_enemy < 14) {
        // Diğer fareden geriye doğru kaçacak olan zıt açıyı hesapla
        var _push_dir = point_direction(_nearest_enemy.x, _nearest_enemy.y, x, y);
        
        // Fareyi hafifçe dışarıya doğru ittir (0.4 piksel hızla omuz atar)
        x += lengthdir_x(0.4, _push_dir);
        y += lengthdir_y(0.4, _push_dir);
    }
}

// 💥 ENGINE LEVEL HIT FLASH (Asla sekmez motor hilesi)
if (flash_timer > 0) {
    flash_timer--;
    image_blend = c_red; // Fare hasar yediğinde gövdesini doğrudan kıpkırmızı boya!
} else {
    image_blend = c_white; // Parlama bittiyse orijinal rengine pürüzsüzce geri döndür
}

// Kediyi takip etme yapay zekası
if (instance_exists(obj_cat)) {
    var _dir = point_direction(x, y, obj_cat.x, obj_cat.y);
    x += lengthdir_x(move_speed, _dir);
    y += lengthdir_y(move_speed, _dir);
}

// Canı bittiğinde kılçık düşürerek yok olma
if (hp <= 0) {
    var _bone = instance_create_layer(x, y, "Instances", obj_fishbone);
    var _wave = obj_game_controller.current_wave;
    _bone.value = round(2 * (1 + (_wave * 0.1))); // Hızlı fareler temel 2 kılçık verir!
    
    global.total_kills += 1;
    instance_destroy();
}
