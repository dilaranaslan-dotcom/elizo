// EXIT NAVIGATION AND FORCE NEXT WAVE
if (keyboard_check_pressed(vk_space)) {
    
    // Prepare the game controller for the upcoming wave (Wave 11+)
    if (instance_exists(obj_game_controller)) {
        
        // 🔒 THE CRITICAL FIX: Manually advance the wave to 11 right here!
        // This breaks the infinite mini-boss loop completely.
        obj_game_controller.current_wave += 1; 
        
        // Clean the spawn budget for the new wave
        obj_game_controller.mice_spawned_so_far = 0;
        obj_game_controller.spawn_timer = 0;
        
        // Dynamic formula for the next wave (Wave 11 will have 10 + 11*5 = 65 mice budget!)
        obj_game_controller.total_mice_to_spawn = 10 + (obj_game_controller.current_wave * 5);
        
        // Re-activate the wave system
        obj_game_controller.wave_active = true;
    }
    
    // Return to the battlefield to fight the new evolved waves!
    room_goto(rm_gameplay);
}
