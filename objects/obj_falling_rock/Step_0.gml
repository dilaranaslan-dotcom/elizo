if (!is_dropped) {
    warning_time--;
    
    // Yerdeki kırmızı tehlike alanı göstergesi
    image_alpha = 0.4;
    
    if (warning_time <= 0) {
        is_dropped = true;
        image_alpha = 1.0; // Taş tamamen düştü!
    }
} else {
    // Taş yere düştükten sonra çok az durup kaybolsun
    warning_time--;
    if (warning_time <= -10) {
        instance_destroy();
    }
}
