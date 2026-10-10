// 🔒 SHOP SAFETY AND SCREEN POSITION RESET
if (room == rm_shop || room == rm_skilltree) {
    // Eğer dükkanda veya gelişim ağacındaysak kediyi tamamen gizle ve dondur
    visible = false; 
    x = -999; // Ekranın tamamen dışına fırlat ki dükkan butonlarına basarken çakışmasın
    y = -999;
} 
else if (room == rm_gameplay) {
    // Savaş alanına geri döndüğümüzde kediyi tekrar görünür yap
    visible = true;
    
    // Kediyi yeni dalga için ekranın tam ortasına ışınla!
    x = room_width / 2;
    y = room_height / 2;
}
