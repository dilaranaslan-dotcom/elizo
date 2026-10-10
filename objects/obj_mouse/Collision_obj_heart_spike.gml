if (instance_exists(obj_heart_spike)) {
    hp -= obj_heart_spike.damage;
    flash_timer = 5; // Vurulduğunda kırmızı parlasın!
    with (obj_heart_spike) { instance_destroy(); } // Dikeni yok et
}
