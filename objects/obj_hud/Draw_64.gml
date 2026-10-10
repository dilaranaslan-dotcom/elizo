// Sadece savaş alanındayken arayüzü çiz (Dükkanda veya Gelişim Ağacında gizlensin)
if (room == rm_gameplay) {
    
    // -------------------------------------------------------------
    // 1. SOL ÜST: KEDİNİN CAN BARI (HP BAR)
    // -------------------------------------------------------------
    if (instance_exists(obj_cat)) {
        var _hp_x = 15;
        var _hp_y = 15;
        var _bar_width = 100;
        var _bar_height = 8;
        
        // Kedinin can yüzdesini hesapla (0 ile 100 arası)
        var _hp_percent = (obj_cat.current_hp / obj_cat.max_hp) * 100;
        
        // Arka Plan (Siyah Çerçeve)
        draw_set_color(c_black);
        draw_rectangle(_hp_x - 1, _hp_y - 1, _hp_x + _bar_width + 1, _hp_y + _bar_height + 1, false);
        
        // Boş Can Alanı (Koyu Gri)
        draw_set_color(c_dkgray);
        draw_rectangle(_hp_x, _hp_y, _hp_x + _bar_width, _hp_y + _bar_height, false);
        
        // Dolu Can Alanı (Kırmızı)
        if (_hp_percent > 0) {
            draw_set_color(c_red);
            draw_rectangle(_hp_x, _hp_y, _hp_x + (_bar_width * (_hp_percent / 100)), _hp_y + _bar_height, false);
        }
        
        // Can Yazısı (Örn: HP: 100/100)
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_text(_hp_x, _hp_y + 12, "HP: " + string(round(obj_cat.current_hp)) + "/" + string(obj_cat.max_hp));
    }
    
       // -------------------------------------------------------------
    // 2. ORTA ÜST: DALGA BİLGİSİ VE BİYOM İSMİ (UPDATED)
    // -------------------------------------------------------------
    if (instance_exists(obj_game_controller)) {
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        
        var _wave = obj_game_controller.current_wave;
        var _stage_name = "STAGE 1: DARK SEWER"; // Varsayılan Biyom
        
        // Dalga sayısına göre biyom ismini dinamik değiştiriyoruz
        if (_wave >= 41) _stage_name = "STAGE 3: DUSTY ATTIC";
        else if (_wave >= 21) _stage_name = "STAGE 2: DANGEROUS KITCHEN";
        
        // Biyom ismini küçük, Wave yazısını büyük yazdıralım
        draw_set_color(c_gray);
        draw_text(room_width / 2, 10, _stage_name);
        
        draw_set_color(c_white);
        draw_text(room_width / 2, 25, "WAVE " + string(_wave));
        
        // Dalganın bitmesine kaç fare kaldığını gösteren sayaç
        var _alive_enemies = instance_number(obj_mouse) + instance_number(obj_fast_mouse) + instance_number(obj_ranged_mouse) + instance_number(obj_explosive_mouse) + instance_number(obj_shield_mouse) + instance_number(obj_spider_mouse) + instance_number(obj_mini_boss);
        draw_set_color(c_gray);
        draw_text(room_width / 2, 40, "Enemies Left: " + string(_alive_enemies));
    }

    
    // -------------------------------------------------------------
    // 3. SAĞ ÜST: CÜZDAN (WALLET)
    // -------------------------------------------------------------
    draw_set_halign(fa_right);
    draw_set_color(c_yellow);
    draw_text(room_width - 15, 15, "Fishbones: " + string(global.gold));
}

    // -------------------------------------------------------------
    // 4. TOP CENTER: MINI-BOSS HEALTH BAR (FIXED)
    // -------------------------------------------------------------
    if (instance_exists(obj_mini_boss)) {
        
        var _boss_bar_w = 200; 
        var _boss_bar_h = 10; // This is the correct variable name
        var _boss_x = (room_width / 2) - (_boss_bar_w / 2); 
        var _boss_y = 45; 
        
        var _boss_hp_percent = (obj_mini_boss.hp / 450) * 100;
        
        // Background (Black Frame)
        draw_set_color(c_black);
        draw_rectangle(_boss_x - 1, _boss_y - 1, _boss_x + _boss_bar_w + 1, _boss_y + _boss_bar_h + 1, false);
        
        // Empty Bar Area (Dark Gray)
        draw_set_color(c_dkgray);
        draw_rectangle(_boss_x, _boss_y, _boss_x + _boss_bar_w, _boss_y + _boss_bar_h, false);
        
        // Filled Bar Area (Lime Green)
        if (_boss_hp_percent > 0) {
            draw_set_color(c_lime); 
            draw_rectangle(_boss_x, _boss_y, _boss_x + (_boss_bar_w * (_boss_hp_percent / 100)), _boss_y + _boss_bar_h, false);
        }
        
        // Boss Title text
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(room_width / 2, _boss_y - 12, "SLUDGE BREAKER (MINI-BOSS)");
    }
    // -------------------------------------------------------------
    // 5. TOP CENTER: SEWER KING MAJOR BOSS HEALTH BAR (Eklendi)
    // -------------------------------------------------------------
    if (instance_exists(obj_sewer_king)) {
        var _bar_w = 260; // Ana boss barı daha da uzun ve heybetli olsun
        var _bar_h = 12;
        var _bx = (room_width / 2) - (_bar_w / 2);
        var _by = 55;
        
        // Kralın can yüzdesini 1200 HP üzerinden hesapla
        var _king_percent = (obj_sewer_king.hp / 1200) * 100;
        
        // Arka Plan (Siyah Çerçeve)
        draw_set_color(c_black);
        draw_rectangle(_bx - 2, _by - 2, _bx + _bar_w + 2, _by + _bar_h + 2, false);
        
        // Boş Can Alanı (Koyu Gri)
        draw_set_color(c_dkgray);
        draw_rectangle(_bx, _by, _bx + _bar_w, _by + _bar_h, false);
        
        // Dolu Can Alanı (Asil Bir Kan Kırmızısı - c_purple veya c_red)
        if (_king_percent > 0) {
            draw_set_color(c_purple); // Krala yakışan koyu mor/eflatun rengi
            draw_rectangle(_bx, _by, _bx + (_bar_w * (_king_percent / 100)), _by + _bar_h, false);
        }
        
        // Boss Başlığı
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(room_width / 2, _by - 14, "THE SEWER KING (STAGE 1 BOSS)");
    }

