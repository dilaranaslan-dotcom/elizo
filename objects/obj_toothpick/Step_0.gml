x += lengthdir_x(move_speed, direction);
y += lengthdir_y(move_speed, direction);

// Ekran dışına çok çıkarsa mermiyi sil
if (x < -32 || x > room_width + 32 || y < -32 || y > room_height + 32) {
    instance_destroy();
}
