// Bu değişkenler sadece oyun ilk açıldığında 1 kez kurulacak
current_wave = 6;               
total_mice_to_spawn = 10;       
mice_spawned_so_far = 0;        
spawn_cooldown = 90;            
spawn_timer = 0;                
wave_active = true;             
// Spawn the very first persistent cat at the beginning of the entire game
if (!instance_exists(obj_cat)) {
    instance_create_layer(480 / 2, 270 / 2, "Instances", obj_cat);
}
	