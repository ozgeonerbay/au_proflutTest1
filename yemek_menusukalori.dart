import 'package:flutter/material.dart';

Widget buildYemekMenusu(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(8.0),
    children: [
      _buildGunlukKart("02.02.2026 Pazartesi", "900", [
        "🍲 Kremalı Mantar Çorba (130 kcal)",
        "🥩 Et Döner / Etli Kuru Fasulye (300 kcal)",
        "🍚 Pirinç Pilavı / Erişte (250 kcal)",
        "🍯 Tahinli Kemalpaşa / Yoğurt (220 kcal)",
      ]),
      _buildGunlukKart("03.02.2026 Salı", "860", [
        "🍲 Yayla / Mercimek Çorba (95 kcal)",
        "🥘 Kıymalı Patates / Lahana Kavurma (250 kcal)",
        "🍝 Kaşarlı Makarna / Biber Dolma (280 kcal)",
        "🍮 Profiterol / Meyve (235 kcal)",
      ]),
      _buildGunlukKart("04.02.2026 Çarşamba", "685", [
        "🍲 Ezogelin / Karnabahar Çorba (120 kcal)",
        "🍢 Adana Köfte / Otlu Piliç (350 kcal)",
        "🌾 Bulgur Pilavı (215 kcal)",
      ]),
    ],
  );
}

Widget _buildGunlukKart(String gun, String kalori, List<String> yemekler) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: ExpansionTile(
      leading: const Icon(Icons.restaurant, color: Colors.orange),
      title: Text(gun, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Toplam: $kalori kcal"),
      children: yemekler.map((yemek) => ListTile(
        title: Text(yemek, style: const TextStyle(fontSize: 14)),
      )).toList(),
    ),
  );
}