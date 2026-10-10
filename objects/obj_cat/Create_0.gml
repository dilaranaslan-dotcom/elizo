// Kedinin temel özellikleri
move_speed = 2.5;       // Yürüme hızı
max_hp = 100;           // Maksimum can
current_hp = max_hp;    // Şu anki can

// Otomatik saldırı ve hedefleme değişkenleri
attack_range = 80;      // Fareyi algılama menzili (piksel cinsinden)
attack_cooldown = 45;   // İki tırmalama arası beklenecek kare (frame) sayısı (yaklaşık 0.7 saniye)
attack_timer = 0;       // Zamanlayıcı

target_mouse = noone;   // En yakındaki fareyi tutacağımız değişken
regen_timer = 180; // 180 frame = Yaklaşık 3 saniyede bir can yenileyecek
old_hp = max_hp; // Başlangıç can kaydı
trail_timer = 0; // İzlerin üst üste binip haritayı boğmaması için sayaç
