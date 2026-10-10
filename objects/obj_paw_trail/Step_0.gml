// ⏳ ASLA SEKEMEZ SİLME MOTORU
// Her karede ömür sayacını el ile 1 düşürüyoruz (Alarmlara gerek kalmadı!)
lifetime--;

// İz yerde kalma süresi azaldıkça pürüzsüzce şeffaflaşsın (Fade-out)
image_alpha = lifetime / 60;

// Ömür bittiği an bu izi hafızadan ve haritadan KESİNLİKLE yok et!
if (lifetime <= 0) {
    instance_destroy();
}
