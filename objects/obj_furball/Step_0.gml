var _target = instance_nearest(x, y, obj_mouse); // Veya en yakın herhangi bir fare
if (instance_exists(_target)) {
    var _dir = point_direction(x, y, _target.x, _target.y);
    direction = _dir;
    image_angle = _dir;
}
x += lengthdir_x(move_speed, direction);
y += lengthdir_y(move_speed, direction);
if (alarm <= 0) instance_destroy();
