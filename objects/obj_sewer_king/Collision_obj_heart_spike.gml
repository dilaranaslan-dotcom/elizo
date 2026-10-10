if (instance_exists(obj_heart_spike)) {
    hp -= obj_heart_spike.damage;
    flash_timer = 5;
    with (obj_heart_spike) { instance_destroy(); }
}
