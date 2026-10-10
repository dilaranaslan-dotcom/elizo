draw_set_halign(fa_center);
draw_set_color(c_white);

// Title
draw_text(room_width / 2, 15, "=== ANATOMICAL SKILL TREE ===");
draw_text(room_width / 2, 35, "Available Paw Points: " + string(global.pati_points));

// Bottom info section (Show description when hovering over an organ)
var _hovered_any = false;
with (obj_organ_button) {
    if (position_meeting(mouse_x, mouse_y, id)) {
        draw_set_halign(fa_center);
        draw_set_color(c_yellow);
        draw_text(room_width / 2, room_height - 50, organ_name + ": " + organ_desc);
        _hovered_any = true;
    }
}

// FIXED: Changed c_darkgray to c_gray since Game Maker does not have c_darkgray by default
if (!_hovered_any) {
    draw_set_color(c_gray);
    draw_text(room_width / 2, room_height - 50, "Hover over an organ to see details. Click to upgrade.");
}

// Exit Instructions
draw_set_color(c_white);
draw_text(room_width / 2, room_height - 25, "Press [SPACE] to return to the game!");
