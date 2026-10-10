// 4 Ana organı oluştur ve özelliklerini ata
var _brain = instance_create_layer(210, 100, "Instances", obj_organ_button);
_brain.organ_id = 0;
_brain.organ_name = "BRAIN";
_brain.organ_desc = "Increases Attack Speed (+20%)";

var _heart = instance_create_layer(230, 130, "Instances", obj_organ_button);
_heart.organ_id = 1;
_heart.organ_name = "HEART";
_heart.organ_desc = "Lvl 1: Health Regen";


var _stomach = instance_create_layer(260, 140, "Instances", obj_organ_button);
_stomach.organ_id = 2;
_stomach.organ_name = "STOMACH";
_stomach.organ_desc = "Increases Scratch Damage (+25%)";

var _paws = instance_create_layer(250, 180, "Instances", obj_organ_button);
_paws.organ_id = 3;
_paws.organ_name = "PAWS";
_paws.organ_desc = "Increases Movement Speed (+0.5)";
