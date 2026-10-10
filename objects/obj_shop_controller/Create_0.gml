// Reroll pricing
reroll_cost = 15;

// Array holding the item IDs for the 3 shop slots (-1 means empty)
shop_slots = [-1, -1, -1];

// Function to randomly populate the shop with EXACTLY 2 Temporary and 1 Permanent item
function generate_shop_items() {
    if (instance_exists(obj_shop_card)) {
        with (obj_shop_card) { instance_destroy(); }
    }
    
    var _card_x_start = 80;  
    var _card_spacing = 160; 
    var _card_y = 110;       
    
    for (var i = 0; i < 3; i++) {
        var _random_item_id = -1;
        
        if (i == 0 || i == 1) {
            // Slots 0 and 1 are ALWAYS Temporary items (ID 0 or 1)
            _random_item_id = choose(0, 1); 
        } else {
            // Slot 2 is ALWAYS a Permanent item.
            // FIXED: Creating an array dynamically with 2 starting slots instead of empty brackets
            var _perm_pool = array_create(2);
            _perm_pool[0] = 2; // ID 2: Cat Glasses
            _perm_pool[1] = 3; // ID 3: Spiky Collar
            
            // If Lucky Toy Mouse is unlocked, add ID 4 to the pool
            if (global.unlock_lucky_mouse == 1) {
                array_push(_perm_pool, 4);
            }
            // If Cat Instinct is unlocked, add ID 5 to the pool
            if (global.unlock_cat_instinct == 1) {
                array_push(_perm_pool, 5);
            }
            
            // Randomly choose an item ONLY from the available pool
            var _random_index = irandom(array_length(_perm_pool) - 1);
            _random_item_id = _perm_pool[_random_index];
        }
        
        shop_slots[i] = _random_item_id;
        
        var _card = instance_create_layer(_card_x_start + (i * _card_spacing), _card_y, "Instances", obj_shop_card);
        _card.slot_index = i;
        _card.item_id = _random_item_id;
        
        switch (_random_item_id) {
            case 0:
                _card.item_name = "Cat Food"; _card.item_price = 40; _card.is_permanent = false;
                _card.item_desc = "Instantly restores 30% of your maximum health.";
                break;
            case 1:
                _card.item_name = "Catnip"; _card.item_price = 50; _card.is_permanent = false;
                _card.item_desc = "Gives a temporary speed boost for the next wave.";
                break;
            case 2:
                _card.item_name = "Cat Glasses"; _card.item_price = 200; _card.is_permanent = true;
                _card.item_desc = "Permanently increases your scratch damage by +35%.";
                break;
            case 3:
                _card.item_name = "Spiky Collar"; _card.item_price = 250; _card.is_permanent = true;
                _card.item_desc = "Permanently grants you +20 Maximum Health.";
                break;
                
            // NEW UNLOCKED ITEMS 
            case 4:
                _card.item_name = "Lucky Toy Mouse"; _card.item_price = 300; _card.is_permanent = true;
                _card.item_desc = "UNLOCKED! Permanently increases fishbone drops by +20%.";
                break;
            case 5:
                _card.item_name = "Cat Instinct"; _card.item_price = 350; _card.is_permanent = true;
                _card.item_desc = "UNLOCKED! Permanently grants +15% Critical Strike Chance.";
                break;
        }
    }
}

// Initial shop generation
generate_shop_items();
