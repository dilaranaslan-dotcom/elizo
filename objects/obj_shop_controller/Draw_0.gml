draw_set_halign(fa_center);
draw_set_color(c_white);

// Shop Title
draw_text(room_width / 2, 15, "=== SHOP ===");

// Wallet Info
draw_set_halign(fa_left);
draw_text(30, 35, "Wallet: " + string(global.gold) + " Fishbones");

// Reroll Info
draw_set_halign(fa_right);
draw_text(room_width - 30, 35, "[R] Reroll: " + string(reroll_cost) + " F.");
// -------------------------------------------------------------
// DYNAMIC ITEM DESCRIPTION DRAW (Eklendi)
// -------------------------------------------------------------
var _hovered_any_card = false;

// Odadaki tüm dükkan kartlarını kontrol et
with (obj_shop_card) {
    // Eğer oyuncunun faresi bu kartın üzerindeyse ve kart henüz satın alınmadıysa
    if (position_meeting(mouse_x, mouse_y, id) && !is_bought) {
        draw_set_halign(fa_center);
        draw_set_color(c_yellow); // Açıklamalar sarı renkle parlasın
        
        // Ekranın alt kısmına (Kartların hemen altına) açıklamayı yazdır
        draw_text(room_width / 2, room_height - 45, item_desc);
        _hovered_any_card = true;
    }
}

// Eğer fare hiçbir kartın üzerinde değilse varsayılan dükkan talimatını yaz
if (!_hovered_any_card) {
    draw_set_halign(fa_center);
    draw_set_color(c_gray);
    draw_text(room_width / 2, room_height - 45, "Hover over an item to see its effects.");
}
// -------------------------------------------------------------

// Bottom Navigation Info
draw_set_halign(fa_center);
draw_text(room_width / 2, room_height - 25, "Press [SPACE] to start next wave!");
