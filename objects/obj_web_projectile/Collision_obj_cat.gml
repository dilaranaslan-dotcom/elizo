if (instance_exists(obj_cat)) {
    // Kedinin içindeki move_speed'i geçici olarak düşürmek için bir sayaç tetikleriz
    obj_cat.move_speed = 1.0; // Kediyi yavaşlat
    obj_cat.alarm[1] = 90;    // 1.5 saniye sonra hızı eski haline getirecek alarm
}
instance_destroy();
