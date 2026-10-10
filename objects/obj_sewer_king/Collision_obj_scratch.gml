if (instance_exists(obj_scratch)) {
    hp -= obj_scratch.damage;
    flash_timer = 5; // Hasar parlamasını tetikle
    with (obj_scratch) { instance_destroy(); } // Pençeyi yok et
}
