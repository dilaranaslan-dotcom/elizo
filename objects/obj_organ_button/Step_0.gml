// Fare butonun üzerindeyse hafifçe büyüt, değilse eski haline döndür
if (position_meeting(mouse_x, mouse_y, id)) {
    base_scale = lerp(base_scale, 1.2, 0.1);
    
    // Fare tıklandığında ve oyuncunun harcayacak "Pati Puanı" varsa geliştirme yap
    if (mouse_check_button_pressed(mb_left)) {
        if (global.pati_points > 0) {
            global.pati_points -= 1;
            
                        switch (organ_id) {
                case 0: // Brain -> Attack Speed & Tier 2 Homing Furballs
                    global.level_brain += 1;
                    global.upgrade_speed_mult += 0.25; 
                    break;
                case 1: // Heart -> Level 1 grants Regen, Level 2 grants Counter-Spikes!
                    global.level_heart += 1;
                    // We removed max_hp increase to follow the new awesome design!
                    break;

                case 2: // Stomach -> Damage & Tier 2 Piercing Claws
                    global.level_stomach += 1;
                    global.upgrade_damage_mult += 0.35;
                    break;
                case 3: // Paws -> Move Speed & Tier 2 Fire Trail
                    global.level_paws += 1;
                    if (instance_exists(obj_cat)) { obj_cat.move_speed += 0.4; }
                    break;
            }

        }
    }
} else {
    base_scale = lerp(base_scale, 1.0, 0.1);
}

// Ölçekleme değerlerini sprite'a uygula
image_xscale = base_scale;
image_yscale = base_scale;
