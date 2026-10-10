// 💥 ACCURATE DAMAGE AND HIT FLASH TRANSITION
if (instance_exists(obj_scratch)) {
    // Take damage from the flying claw dynamically
    hp -= obj_scratch.damage;
    
    // Instantly force the flash timer to trigger
    flash_timer = 5; 
    
    // 🔒 PIERCING CLAW EVOLUTION: If Stomach is not Level 2, destroy the claw on hit.
    // If it IS Level 2, the claw pierces through enemies and keeps flying!
    if (global.level_stomach < 2) {
        with (obj_scratch) {
            instance_destroy();
        }
    }
}
