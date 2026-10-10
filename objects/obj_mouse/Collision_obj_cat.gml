// Deal damage to the cat when touching it
if (instance_exists(obj_cat)) {
    // If we deal damage every single frame, the cat dies in 1 second. 
    // So we reduce the HP by a very small amount per frame (approx. 10-15 HP per second)
    obj_cat.current_hp -= 0.2; 
	
}
