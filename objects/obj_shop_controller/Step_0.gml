// 1. REROLL MECHANIC
if (keyboard_check_pressed(ord("R"))) {
    if (global.gold >= reroll_cost) {
        global.gold -= reroll_cost;
        reroll_cost *= 2; // Double the cost for the next reroll
        generate_shop_items(); // Repopulate the shop cards
    }
}

// 2. NEXT WAVE NAVIGATION
if (keyboard_check_pressed(vk_space)) {
    room_goto(rm_gameplay); // Go back to the battle arena
}
