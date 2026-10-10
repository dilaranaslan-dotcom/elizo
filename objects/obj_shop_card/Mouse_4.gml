if (!is_bought && global.gold >= item_price) {
    global.gold -= item_price;
    is_bought = true;
    
    // Eşyanın etkisini kediye kalıcı veya geçici olarak uygula!
    switch (item_id) {
        case 0: // Balık Konservesi (Can)
            if (instance_exists(obj_cat)) {
                obj_cat.current_hp = min(obj_cat.max_hp, obj_cat.current_hp + (obj_cat.max_hp * 0.3));
            }
            break;
        case 1: // Kedi Nanesi (Geçici Hız - Sonraki dalgaya etki edecek)
            global.upgrade_speed_mult += 0.5; // Saldırı/hareket hızını geçici artır
            break;
        case 2: // Kedi Gözlüğü (Kalıcı Hasar)
            global.upgrade_damage_mult += 0.35; // Kalıcı olarak %35 hasar artışı
            break;
        case 3: // Dikenli Tasma (Kalıcı Başka stat - Örn: Can Havuzu)
            if (instance_exists(obj_cat)) { obj_cat.max_hp += 20; obj_cat.current_hp += 20; }
            break;
	    case 4: // Lucky Toy Mouse
            // Increases money drop logic multiplier (we will connect this to mouse drops)
            break;
        case 5: // Cat Instinct
            // Increases critical strike chance
            break;

    }
}
