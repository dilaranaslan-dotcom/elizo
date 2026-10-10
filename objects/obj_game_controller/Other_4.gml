// 🔓 UNFREEZE THE BATTLEFIELD WHEN RETURNING
// Tüm dondurulan objeleri uykudan uyandırır ve kaldıkları yerden devam etmelerini sağlar.
instance_activate_all();

// Triggered every time we return to the gameplay battlefield
if (room == rm_gameplay) {
    mice_spawned_so_far = 0;
    spawn_timer = 0;
    wave_active = true;
    
    // 📈 DYNAMIC SPAWN SPEED FORMULA (Kaos Ayarı)
    // Base cooldown is 90 frames (1.5 seconds).
    // As current_wave increases, we subtract more frames, making them spawn faster.
    // Example: Wave 1  -> 90 - (1 * 5) = 85 frames
    //          Wave 5  -> 90 - (5 * 5) = 65 frames (Approx. 1.0 second)
    //          Wave 12 -> 90 - (12 * 5) = 30 frames (Exact 0.5 second! Extreme chaos)
    
    var _calculated_cooldown = 90 - (current_wave * 5);
    
    // SAFETY LIMITER: Clamp it so it never goes below 10 frames (~0.16 seconds). 
    // Otherwise, spawning every 1 frame would instantly crash or freeze the engine!
    spawn_cooldown = clamp(_calculated_cooldown, 10, 90);
}

// -------------------------------------------------------------
// MAP EVOLUTION: STAGE 1 ACID PUDDLES
// -------------------------------------------------------------
// Eğer oyuncu Wave 11 ile Wave 20 arasındaysa haritaya asit havuzları yerleştir!
if (current_wave >= 11 && current_wave <= 20) {
    // Eğer haritada zaten asit havuzları yoksa (Kopyalanmayı önlemek için güvenlik kilidi)
    if (!instance_exists(obj_acid_puddle)) {
        
        // Dynamic layer safety: Kedinin katmanını bulalım
        var _spawn_layer = "Instances";
        if (instance_exists(obj_cat)) {
            _spawn_layer = obj_cat.layer;
        }
        
        // Haritanın 4 farklı köşesine stratejik olarak asit havuzlarını diziyoruz
        // Oda boyutumuz 480x270 olduğu için köşelerin koordinatları:
        instance_create_layer(60, 60, _spawn_layer, obj_acid_puddle);    // Sol Üst
        instance_create_layer(420, 60, _spawn_layer, obj_acid_puddle);   // Sağ Üst
        instance_create_layer(60, 210, _spawn_layer, obj_acid_puddle);   // Sol Alt
        instance_create_layer(420, 210, _spawn_layer, obj_acid_puddle);  // Sağ Alt
    }
}
