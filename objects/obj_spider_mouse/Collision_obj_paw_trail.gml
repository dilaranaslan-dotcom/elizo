if (instance_exists(obj_paw_trail)) {
    // İz üzerinden geçerken her karede canı erimesin diye, 
    // fare izle her temas ettiğinde doğrudan 2 HP hasar alsın
    hp -= obj_paw_trail.damage;
    flash_timer = 5; // Hasar aldığında o şahane kırmızı parlamayı tetikle!
}
