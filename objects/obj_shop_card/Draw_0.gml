draw_self();

draw_set_halign(fa_center);
if (is_bought) {
    draw_set_color(c_red);
    draw_text(x, y, "SOLD\nOUT");
} else {
    draw_set_color(c_white);
    // Draw item name slightly above the center of the card
    draw_text(x, y - 40, item_name);
    
    draw_set_color(c_yellow);
    draw_text(x, y + 15, string(item_price) + " F.");
    
    draw_set_color(c_lime);
    if (is_permanent) draw_text(x, y + 40, "(Perm)");
    else draw_text(x, y + 40, "(Temp)");
}
