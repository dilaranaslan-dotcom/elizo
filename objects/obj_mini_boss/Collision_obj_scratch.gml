// 💥 BOSS DAMAGE AND HIT FLASH TRANSITION
if (instance_exists(obj_scratch)) {
    // Take damage from the flying claw dynamically
    hp -= obj_scratch.damage;
    
    // Instantly force the boss flash timer to trigger
    flash_timer = 5; 
    
    // Manually destroy the scratch effect on impact
    with (obj_scratch) {
        instance_destroy();
    }
}
