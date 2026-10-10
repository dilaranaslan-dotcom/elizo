// 🔒 STOP CAT LOGIC IF NOT IN THE BATTLEFIELD
if (room != rm_gameplay) {
    exit; // Eğer savaş alanında değilsek, aşağıdaki hiçbir yürüme veya saldırma kodunu çalıştırma!
}

// 1. INPUT HANDLING & WASD MOVEMENT
var _input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Normalize diagonal movement speed
if (_input_x != 0 && _input_y != 0) {
    _input_x *= 0.707;
    _input_y *= 0.707;
}

// Update position
x += _input_x * move_speed;
y += _input_y * move_speed;

// Keep the cat inside room boundaries
x = clamp(x, 12, room_width - 12);
y = clamp(y, 12, room_height - 12);


// 2. AUTOMATIC TARGETING SYSTEM (DYNAMIC RADAR FIX)
// We set the initial search distance to room width so it scans the ENTIRE visible screen!
var _nearest_dist = room_width; 
target_mouse = noone;            

// Check normal mice
with (obj_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}

// Check fast mice
with (obj_fast_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}

// Check ranged mice
with (obj_ranged_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}

// Check mini-boss
with (obj_mini_boss) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}


// Check fast mice
with (obj_fast_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}

// Check mini-boss (Fixed paranthesis hierarchy)
with (obj_mini_boss) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}

// Check explosive mice (Barutçuları da kedinin otomatik radarına ekledik!)
with (obj_explosive_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}
// Check shield mice (Zırhlıları da kedinin otomatik radarına ekledik!)
with (obj_shield_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) {
        _nearest_dist = _dist;
        other.target_mouse = id; 
    }
}
with (obj_spider_mouse) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) { _nearest_dist = _dist; other.target_mouse = id; }
}
// Check Sewer King Major Boss
with (obj_sewer_king) {
    var _dist = point_distance(other.x, other.y, x, y);
    if (_dist < _nearest_dist) { _nearest_dist = _dist; other.target_mouse = id; }
}

// 3. DYNAMIC ATTACK TIMERS & FLYING SLASHES
if (attack_timer > 0) {
    attack_timer--;
}

var _dynamic_cooldown = attack_cooldown / global.upgrade_speed_mult;

if (target_mouse != noone && attack_timer <= 0) {
    var _dir = point_direction(x, y, target_mouse.x, target_mouse.y);
    
    // Spawn the slash effect right in front of the cat
    var _slash_x = x + lengthdir_x(15, _dir);
    var _slash_y = y + lengthdir_y(15, _dir);
    
    var _slash = instance_create_layer(_slash_x, _slash_y, "Instances", obj_scratch);
    _slash.image_angle = _dir; 
    _slash.damage = 10 * global.upgrade_damage_mult;
    
    // NEW FLYING MECHANIC: Set the speed and direction of the slash towards the target!
    _slash.direction = _dir;
    _slash.speed = 4.5; // The claw projectile flies through the air to catch distant ranged mice
    
    attack_timer = _dynamic_cooldown; 
	    // 🔒 HOMING FURBALL EVOLUTION: If Brain is Level 2, spawn extra homing projectiles!
    if (global.level_brain >= 2) {
        repeat(2) {
            var _furball = instance_create_layer(x, y, "Instances", obj_furball);
            _furball.direction = _dir + random_range(-30, 30); // Spread out slightly
        }
    }

}
// 🔒 SHOP IMMUNITY: If we are in the shop or skill tree, don't check for death or take any hidden damage!
if (room != rm_gameplay) {
    current_hp = clamp(current_hp, 0, max_hp); // Keep HP clamped
    exit; // Stop running death checking loops outside the arena
}


// 4. HP LIMITER & DEATH CHECK
current_hp = clamp(current_hp, 0, max_hp);
// 🔒 NEW HEART ORGAN SYSTEM
// STAGE 1: HEALTH REGENERATION (Şimdi Level 1 ve üzeri olduğunda direkt aktif!)
if (global.level_heart >= 1 && current_hp < max_hp) {
    regen_timer--;
    if (regen_timer <= 0) {
        current_hp = min(current_hp + 1, max_hp); 
        regen_timer = 180; 
    }
}

// STAGE 2: SPIKE COUNTER EVOLUTION
// Fareler kediye her hasar verdiğinde eğer kedi hasar alıyorsa ve Kalp Level 2 ise etrafa 8 adet diken saçsın!
// Bunu her farenin çarpışma olayında tek tek tetiklemek yerine, kedinin canı anlık düştüğünde algılayan muazzam bir kontrol yazıyoruz:
if (global.level_heart >= 2) {
    // Eğer kedinin canı, bir önceki karedeki (frame) canından azaldıysa (yani hasar yiyorsa!)
    // Not: Bu kontrolün çalışması için Create olayına 'old_hp = current_hp;' ekleyeceğiz.
    if (current_hp < old_hp) {
        // Tam bir çember oluşturacak şekilde 8 farklı yöne (0, 45, 90, 135...) diken fırlat
        for (var angle = 0; angle < 360; angle += 45) {
            var _spike = instance_create_layer(x, y, "Instances", obj_heart_spike);
            _spike.direction = angle;
            _spike.image_angle = angle;
        }
    }
}
// Her kare sonunda can kaydını güncelle
old_hp = current_hp;
// 🔒 PAWS TIER 2 EVOLUTION: LEAVE DAMAGING TRAIL
if (global.level_paws >= 2) {
    // Sadece karakter klavyeden WASD tuşlarına basıyorsa (yani gerçekten HAREKET EDİYORSA) iz bıraksın!
    if (_input_x != 0 || _input_y != 0) {
        if (trail_timer > 0) {
            trail_timer--;
        }
        
        if (trail_timer <= 0) {
            // Kedinin bastığı tam ayak koordinatında iz objesini yarat
            instance_create_layer(x, y, "Instances", obj_paw_trail);
            
            trail_timer = 8; // Her 8 karede bir iz bıraksın (Arkanda şık bir şerit oluşur)
        }
    }
}


if (current_hp <= 0) {
    show_message("GAME OVER! The mice got you...");
    
    global.gold = 0;
    global.upgrade_damage_mult = 1.0;
    global.upgrade_speed_mult = 1.0;
    
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.current_wave = 1;
        obj_game_controller.total_mice_to_spawn = 10;
        obj_game_controller.mice_spawned_so_far = 0;
        obj_game_controller.wave_active = true;
    }
    
    room_goto(rm_gameplay); 
}
