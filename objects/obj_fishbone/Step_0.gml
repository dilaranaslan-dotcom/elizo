if (instance_exists(obj_cat)) {
    // Kedi ile bu kılçık arasındaki mesafeyi ölç
    var _dist = point_distance(x, y, obj_cat.x, obj_cat.y);
    
    // Kedinin mıknatıs menzilini kontrol et (Şimdilik temel olarak 40 piksel verdik)
    // İleride "Mıknatıslı Bıyık" kalıcı eşyasını alırsak bu menzil global değişkenle artacak!
    var _magnet_range = 40; 
    
    // Eğer kedi yakınsa veya para zaten çekilmeye başladıysa
    if (_dist < _magnet_range || is_pulled) {
        is_pulled = true; // Parayı kalıcı olarak çekim moduna sok (kedi kaçsa da para takip etsin)
        
        // Kediye doğru olan açıyı bul
        var _dir = point_direction(x, y, obj_cat.x, obj_cat.y);
        
        // Çekilme hızını gitgide artır (Görsel olarak daha akıcı durur)
        magnet_speed += 0.2;
        magnet_speed = clamp(magnet_speed, 1, 5); // Maksimum hızı 5 ile sınırla
        
        // Parayı kediye doğru hareket ettir
        x += lengthdir_x(magnet_speed, _dir);
        y += lengthdir_y(magnet_speed, _dir);
        
        // Eğer para kediye tamamen değdiyse (mesafe 5 pikselden azsa) parayı topla!
        if (_dist < 5) {
            global.gold += value; // Kedinin cüzdanına parayı ekle
            instance_destroy();   // Kılçığı ekrandan sil
        }
    }
}
