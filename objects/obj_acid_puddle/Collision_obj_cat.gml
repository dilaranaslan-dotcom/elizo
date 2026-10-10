// Deal damage over time (DoT) to the cat while standing in acid
if (instance_exists(obj_cat)) {
    // Reduces HP by a tiny amount per frame (approx. 10 HP per second)
    obj_cat.current_hp -= 0.15; 
}
