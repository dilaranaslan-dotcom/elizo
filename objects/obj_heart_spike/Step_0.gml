// Diken fırlatıldığı açıya doğru düz uçsun
x += lengthdir_x(move_speed, direction);
y += lengthdir_y(move_speed, direction);

if (alarm <= 0) instance_destroy();
