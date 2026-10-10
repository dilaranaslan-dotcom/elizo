randomize(); // Game Maker'ın rastgelelik mekanizmasını gerçek zamanlı olarak aktif eder!

global.gold = 0;
global.total_kills = 0;
global.pati_points = 0; // Keeping the unique "Pati" flavor, or can use global.paw_points = 0;

// Stat multipliers for upgrades
global.upgrade_damage_mult = 1.0; 
global.upgrade_speed_mult = 1.0;
// 🔒 LOCK / UNLOCK SYSTEM VARIABLES (0 = Locked, 1 = Unlocked)
global.unlock_lucky_mouse = 0; // Mission: Kill 50 total mice
global.unlock_cat_instinct = 0; // Mission: Defeat the 10th Wave Mini-Boss

// Function to SAVE progress to the computer
function save_game_data() {
    ini_open("save_data.ini"); // Creates or opens the file
    ini_write_real("Unlocks", "lucky_mouse", global.unlock_lucky_mouse);
    ini_write_real("Unlocks", "cat_instinct", global.unlock_cat_instinct);
    ini_write_real("Stats", "total_kills", global.total_kills);
    ini_close(); // Always close the file!
}

// Function to LOAD progress from the computer
function load_game_data() {
    ini_open("save_data.ini");
    // If the file doesn't exist yet, it defaults to 0
    global.unlock_lucky_mouse = ini_read_real("Unlocks", "lucky_mouse", 0);
    global.unlock_cat_instinct = ini_read_real("Unlocks", "cat_instinct", 0);
    global.total_kills = ini_read_real("Stats", "total_kills", 0);
    ini_close();
}

// Automatically load the saved data right at the start of the game
load_game_data();
// 🧠 Organ levels (0 = Not upgraded, 1 = Tier 1 Stat, 2 = Tier 2 EVOLUTION!)
global.level_brain = 0;
global.level_heart = 0;
global.level_stomach = 0;
global.level_paws = 0;
