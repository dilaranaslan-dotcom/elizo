// 1. BOSS'UN KENDİ GÖVDESİNİ ÇİZ
draw_self();

// 2. EĞER SALDIRI ANINDAYSAK, EFEKTİ VE DAİREYİ KESİNLİKLE EN ÜSTTE ÇİZ!
if (state == "slash" && instance_exists(obj_cat)) {
    
    var _dir = point_direction(x, y, obj_cat.x, obj_cat.y);
    // Boss'un biraz önündeki vuruş koordinatını hesapla
    var _slash_x = x + lengthdir_x(25, _dir);
    var _slash_y = y + lengthdir_y(25, _dir);
    
    // ALTA KIRMIZI YARI SAYDAM TEHLİKE ÇEMBERİNİ ÇİZ
    draw_set_alpha(0.4);
    draw_set_color(c_red);
    draw_circle(_slash_x, _slash_y, 32, false);
    draw_set_alpha(1.0);
    
    // EN ÜSTTE PENÇE SPRITE'INI (spr_boss_slash) ZORLA BEYAZ RENKLE ÇİZ!
    if (sprite_exists(spr_boss_slash)) {
        draw_sprite_ext(spr_boss_slash, 0, _slash_x, _slash_y, 1, 1, _dir, c_white, 1);
    }
}
