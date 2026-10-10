// 🔒 SHOP SAFETY WALL: If we are NOT on the battlefield, freeze all game controller logic instantly!
if (room != rm_gameplay) {
    exit; // Eğer dükkanda veya skill tree odasındaysak, aşağıdaki hiçbir doğurma veya dalga bitirme kodunu çalıştırma!
}

if (wave_active) {
    
    // 1. MOUSE SPAWN MECHANIC
    if (spawn_timer > 0) {
        spawn_timer--;
    }
    
    if (mice_spawned_so_far < total_mice_to_spawn && spawn_timer <= 0) {
        var _spawn_margin = 32; 
        var _spawn_x = 0;
        var _spawn_y = 0;
        var _side = irandom(3);
        
        switch (_side) {
            case 0: // Top
                _spawn_x = random_range(0, room_width);
                _spawn_y = -_spawn_margin;
                break;
            case 1: // Bottom
                _spawn_x = random_range(0, room_width);
                _spawn_y = room_height + _spawn_margin;
                break;
            case 2: // Left
                _spawn_x = -_spawn_margin;
                _spawn_y = random_range(0, room_height);
                break;
            case 3: // Right
                _spawn_x = room_width + _spawn_margin;
                _spawn_y = room_height + _spawn_margin;
                break;
        }
        
        // Dynamic layer safety
        var _target_layer = "Instances";
        if (instance_exists(obj_cat)) {
            _target_layer = obj_cat.layer;
        }
        
        // Increment spawn counter
        mice_spawned_so_far++; 
        
        // 🔒 FIXED ENEMY WAVE PACING CALENDAR (UPDATED EVERY 3 WAVES)
              // 🔒 MAJOR BOSS SPAWN ENGINES (FIXED FOR DIRECT TEST)
        if (current_wave == 20) {
            // WAVE 20: Sewer King (Biyom 1 Ana Boss'u)
            if (mice_spawned_so_far < total_mice_to_spawn) {
                instance_create_layer(room_width / 2, -32, _target_layer, obj_sewer_king);
                mice_spawned_so_far = total_mice_to_spawn; // Consume budget instantly
            }
        }
        else if (current_wave == 40) {
            // WAVE 40: Chef Squeak (Biyom 2 Ana Boss'u)
            if (mice_spawned_so_far < total_mice_to_spawn) {
                instance_create_layer(room_width / 2, -32, _target_layer, obj_chef_squeak);
                mice_spawned_so_far = total_mice_to_spawn; 
            }
        }
        else if (current_wave == 60) {
            // WAVE 60: Cyber-Rodent (FINAL BOSS!)
            if (mice_spawned_so_far < total_mice_to_spawn) {
                instance_create_layer(room_width / 2, -32, _target_layer, obj_cyber_rodent);
                mice_spawned_so_far = total_mice_to_spawn; 
            }
        }
        // Eğer bu özel boss dalgalarında değilsek, normal takvim aşağıda devam eder:
        else if (current_wave == 10) {


            // WAVE 10: Exactly 1 Mini-Boss
            if (mice_spawned_so_far == 1) {
                instance_create_layer(room_width / 2, -32, _target_layer, obj_mini_boss);
                mice_spawned_so_far = total_mice_to_spawn; 
            }
        } 
        else {
            var _chance = irandom_range(1, 100);
            
            // WAVE 15+: Introduces Spider Mouse (Slowing traps)
            if (current_wave >= 15) {
                if (_chance <= 12) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_fast_mouse);
                else if (_chance > 12 && _chance <= 24) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_ranged_mouse);
                else if (_chance > 24 && _chance <= 36) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_explosive_mouse);
                else if (_chance > 36 && _chance <= 48) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_shield_mouse);
                else if (_chance > 48 && _chance <= 60) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_spider_mouse); 
                else instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_mouse);
            }
            // WAVE 11-14: Introduces Explosive Mouse
            else if (current_wave >= 11) {
                if (_chance <= 15) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_fast_mouse);
                else if (_chance > 15 && _chance <= 30) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_ranged_mouse);
                else if (_chance > 30 && _chance <= 45) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_explosive_mouse); 
                else if (_chance > 45 && _chance <= 60) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_shield_mouse);
                else instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_mouse);
            }
            // WAVE 9: Introduces Ranged Mouse
            else if (current_wave >= 9) {
                if (_chance <= 20) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_fast_mouse);
                else if (_chance > 20 && _chance <= 40) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_ranged_mouse); 
                else if (_chance > 40 && _chance <= 55) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_shield_mouse);
                else instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_mouse);
            }
            // WAVE 6-8: Introduces Shield Mouse
            else if (current_wave >= 6) {
                if (_chance <= 25) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_fast_mouse);
                else if (_chance > 25 && _chance <= 45) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_shield_mouse); 
                else instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_mouse);
            }
            // WAVE 3-5: Introduces Fast Mouse
            else if (current_wave >= 3) {
                if (_chance <= 30) instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_fast_mouse); 
                else instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_mouse);
            }
            // WAVE 1 & 2: Tutorial Normal Mice
            else {
                instance_create_layer(_spawn_x, _spawn_y, _target_layer, obj_mouse);
            }
        }
        
        spawn_timer = spawn_cooldown;
    }
    
    // 2. WAVE END CHECK (ULTRA SECURED WITH CLEANER)
    var _mice_count = instance_number(obj_mouse) + instance_number(obj_fast_mouse) + instance_number(obj_ranged_mouse) + instance_number(obj_explosive_mouse) + instance_number(obj_shield_mouse) + instance_number(obj_spider_mouse) + instance_number(obj_mini_boss)+ instance_number(obj_sewer_king);
    
    if (_mice_count <= 0 && (mice_spawned_so_far >= total_mice_to_spawn || mice_spawned_so_far == total_mice_to_spawn - 1)) {
        wave_active = false;
        
        // SCREEN CLEANER BEFORE SHOP
        with (obj_scratch) { instance_destroy(); }
        with (obj_toothpick) { instance_destroy(); }
        with (obj_web_projectile) { instance_destroy(); }
        with (obj_explosion) { instance_destroy(); }
        
        current_wave += 1;
        total_mice_to_spawn = 10 + (current_wave * 5); 
        mice_spawned_so_far = 0;
        spawn_timer = 0;
        wave_active = true; 
        
        room_goto(rm_shop); 
    }
}
