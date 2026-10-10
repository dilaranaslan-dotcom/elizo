// Farklı organlara farklı neon renkler veriyoruz
switch (organ_id) {
    case 0: draw_set_flash_color = c_fuchsia; break; // Brain
    case 1: draw_set_flash_color = c_red; break;     // Heart
    case 2: draw_set_flash_color = c_orange; break;  // Stomach
    case 3: draw_set_flash_color = c_yellow; break;  // Paws
}

// Eğer fare üzerindeyse o renkte çiz, değilse beyaz çiz
if (position_meeting(mouse_x, mouse_y, id)) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, draw_set_flash_color, 1);
} else {
    draw_self();
}
