// 1. EĞER TAŞ HENÜZ DÜŞMEDİYSE (UYARI AŞAMASI) YERDE KIRMIZI ŞEFFAF ÇEMBER ÇİZ
if (!is_dropped) {
    draw_set_alpha(0.4);
    draw_set_color(c_red);
    draw_circle(x, y, 16, false); // Tehlike alanı
    draw_set_alpha(1.0);
} else {
    // 2. TAŞ YERE DÜŞTÜĞÜ AN KENDİ SPRITE'INI KESKİNCE ÇİZ
    draw_self();
}
