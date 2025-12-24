import 'package:flutter/material.dart';

void main() {
  runApp(const YemekhaneApp());
}

class YemekhaneApp extends StatelessWidget {
  const YemekhaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Okul Bilgi Sistemi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const HomePage(),
    );
  }
}

/* -------------------- ANA SAYFA (DASHBOARD) -------------------- */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Okul Rehberi"),
        centerTitle: true,
        backgroundColor: Colors.red.shade800,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildNavCard(
              context,
              "Yemek Menüsü",
              "Günlük Menüler",
              Icons.restaurant_menu,
              Colors.orange,
              const MenuPage(),
            ),
            _buildNavCard(
              context,
              "Shuttle Saatleri",
              "Mahmutbey - Gayrettepe-Bakırköy-Yenibosna Seferleri",
              Icons.directions_bus,
              Colors.blue,
              const ShuttlePage(),
            ),
            _buildNavCard(
              context,
              "Öğretim Görevlileri",
              "Ofis Numaraları ",
              Icons.work,
              Colors.green,
              const OfficePage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavCard(BuildContext context, String title, String subTitle, IconData icon, Color color, Widget destination) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(subTitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
      ),
    );
  }
}

/* -------------------- YEMEK MENÜSÜ EKRANI (AY/GÜN) -------------------- */

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Örnek: Ekim ve Kasım ayları
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Yemek Menüsü"),
          bottom: const TabBar(
            tabs: [Tab(text: "Aralık"), Tab(text: "Ocak")],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDailyList("Aralık"),
            _buildDailyList("Ocak"),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyList(String month) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 5, // Örnek 5 gün
      itemBuilder: (context, index) {
        return ExpansionTile(
          leading: const Icon(Icons.calendar_today),
          title: Text("${index + 1} $month"),
          children: const [
            ListTile(title: Text("🍲 Mercimek Çorbası")),
            ListTile(title: Text("🍛 Döner")),
            ListTile(title: Text("🍚 Pirinç Pilavı")),
            ListTile(title: Text("🍮 Baklava")),
          ],
        );
      },
    );
  }
}

/* -------------------- SHUTTLE EKRANI -------------------- */
class ShuttlePage extends StatelessWidget {
  const ShuttlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // 4 ana güzergah grubu
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shuttle Saatleri"),
          bottom: const TabBar(
            isScrollable: true, // Başlıklar uzun olduğu için kaydırılabilir yaptık
            tabs: [
              Tab(text: "Bakırköy"),
              Tab(text: "Gayrettepe"),
              Tab(text: "Mahmutbey Metro"),
              Tab(text: "Yenibosna"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Bakırköy Kampüs Rotaları
            _buildShuttleList([
              "Mahmutbey -> Bakırköy: 07:30 - 11:00 - 16:00",
              "Bakırköy -> Mahmutbey: 08:20 - 12:00 - 17:45"
            ]),
            // Gayrettepe Rotaları
            _buildShuttleList([
              "Mahmutbey -> Gayrettepe: 07:15 - 12:00 - 16:00",
              "Gayrettepe -> Mahmutbey: 08:40 - 13:00 - 17:45"
            ]),
            // Mahmutbey Metro Rotaları
            _buildShuttleList([
              "Metro -> Mahmutbey: 08:10 - 08:20 - 13:00",
              "Mahmutbey -> Metro: 08:15 - 12:45 - 17:30"
            ]),
            // Yenibosna Rotaları
            _buildShuttleList([
              "Mahmutbey -> Yenibosna: 14:00 - 16:00",
              "Yenibosna -> Mahmutbey: 07:45 - 08:00"
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildShuttleList(List<String> times) {
    return ListView.builder(
      itemCount: times.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.bus_alert),
            title: Text(times[index], style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
/* -------------------- OFİS BİLGİLERİ EKRANI -------------------- */

class OfficePage extends StatelessWidget {
  const OfficePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lecturers = [
     {"name": "Abdullah Huzeyfe KÖSE", "office": "D Blok - Kat 4 - 406Y"},
      {"name": "Abdullahi Abdu İBRAHİM", "office": "D Blok - Kat 4 - 410"},
      {"name": "Alparslan Numan YILDIZ", "office": "D Blok - Kat 4 - 406Z"},
      {"name": "Ayça Kurnaz TÜRKBEN", "office": "D Blok - Kat 3 - 319"},
      {"name": "Aykut ERKAL", "office": "D Blok - Kat 5 - 518"},
      {"name": "Aykut KARAMAN", "office": "D Blok - Kat 3 - 311"},
      {"name": "Ayşe AKNESİL", "office": "D Blok - Kat 3 - 311"},
      {"name": "Begüm AKTAŞ", "office": "D Blok - Kat 2 - 206Y"},
      {"name": "Beyza ARAL BAHTİYAROĞULLARI", "office": "D Blok - Kat 4 - 420"},
      {"name": "Burcu ORHAN", "office": "D Blok - Kat 4 - 406X"},
      {"name": "Büşra BAŞKURT", "office": "D Blok - Kat 5 - 511"},
      {"name": "Can TURKUN", "office": "D Blok - Kat 3 - 306C"},
      {"name": "Can UZUN", "office": "D Blok - Kat 5 - 515"},
      {"name": "Çağda ÖZBAKİ", "office": "D Blok - Kat 5 - 510"},
      {"name": "Çisem BOZBEK", "office": "D Blok - Kat 2 - 206X"},
      {"name": "DEKAN-Galip CANSEVER", "office": "D Blok - Kat 4 - 414"},
      {"name": "Deniz ÇETİN", "office": "D Blok - Kat 5 - 510"},
      {"name": "Didem UĞURLU", "office": "D Blok - Kat 5 - 519"},
      {"name": "Doğan KANIĞ", "office": "D Blok - Kat 6 - 612"},
      {"name": "Doğu Çağdaş ATİLLA", "office": "D Blok - Kat 3 - 316"},
      {"name": "Ekrem YILMAZ", "office": "D Blok - Kat 4 - 406Y"},
      {"name": "Elif Bağnu KORKMAZ", "office": "D Blok - Kat 3 - 306B"},
      {"name": "Elif SÖNMEZ", "office": "D Blok - Kat 4 - 412"},
      {"name": "Emrah BÖLÜK", "office": "D Blok - Kat 4 - 406X"},
      {"name": "Engin SANSARCI", "office": "D Blok - Kat 3 - 306C"},
      {"name": "Erinç ONBAY", "office": "D Blok - Kat 5 - 519"},
      {"name": "Fatih YİĞİT", "office": "D Blok - Kat 3 - 310"},
      {"name": "Fikret Korhan TURAN", "office": "D Blok - Kat 5 - 520"},
      {"name": "Funda DAYLAK", "office": "D Blok - Kat 3 - 306B"},
      {"name": "Furkan NARLITEPE", "office": "D Blok - Kat 3 - 306A"},
      {"name": "Gökhan CESUR", "office": "D Blok - Kat 4 - 415"},
      {"name": "Göktuğ Görkem MARDİN", "office": "D Blok - Kat 2 - 206Z"},
      {"name": "Gülay YEDEKÇİ", "office": "D Blok - Kat 5 - 516"},
      {"name": "Hakan KARADEMİR", "office": "D Blok - Kat 4 - 406X"},
      {"name": "Hakan KAYGUSUZ", "office": "D Blok - Kat 4 - 417"},
      {"name": "Hakan KOYUNCU", "office": "D Blok - Kat 3 - 310"},
      {"name": "Hasan ABDULKADER", "office": "D Blok - Kat 3 - 318"},
      {"name": "İbrahim KOÇ", "office": "D Blok - Kat 5 - 512"},
      {"name": "Kevork MARDİKYAN", "office": "D Blok - Kat 3 - 320"},
      {"name": "Mehmet Emre BALAN", "office": "D Blok - Kat 4 - 406Z"},
      {"name": "Mehmet KARA", "office": "D Blok - Kat 2 - 206Z"},
      {"name": "Merih KASAP", "office": "D Blok - Kat 5 - 511"},
      {"name": "Merve ÇİLTAŞ ÇATALBAŞ", "office": "D Blok - Kat 2 - 206Y"},
      {"name": "Merve BULUT YILGÖR", "office": "D Blok - Kat 5 - 514"},
      {"name": "Mesut ÇEVİK", "office": "D Blok - Kat 2 - 218"},
      {"name": "Mohsen VIAND", "office": "D Blok - Kat 3 - 318"},
      {"name": "Muhammad ILYAS", "office": "D Blok - Kat 2 - 216"},
      {"name": "Münevver Aygün AŞIK", "office": "D Blok - Kat 2 - 206Y"},
      {"name": "Nur Banu ÖZBALTA", "office": "D Blok - Kat 2 - 206X"},
      {"name": "Oğuz ATA", "office": "D Blok - Kat 2 - 217"},
      {"name": "Oğuz BAYAT", "office": "D Blok - Kat 5 - 513"},
      {"name": "Oğuz KARAN", "office": "D Blok - Kat 4 - 410"},
      {"name": "Osman Mutluhan UĞUREL", "office": "D Blok - Kat 4 - 406Y"},
      {"name": "Osman Nuri Uçan", "office": "D Blok - Kat 3 - 317"},
      {"name": "Özge Deniz DAYIOĞLU", "office": "D Blok - Kat 3 - 306B"},
      {"name": "Özge POLATLI", "office": "D Blok - Kat 3 - 306B"},
      {"name": "Pınar ERTAŞ", "office": "D Blok - Kat 4 - 416"},
      {"name": "Rahime YILMAZ", "office": "D Blok - Kat 4 - 406X"},
      {"name": "Saliha Büşra GÜNDÜZ", "office": "D Blok - Kat 3 - 306A"},
      {"name": "Sami Aydın ŞALCI", "office": "D Blok - Kat 3 - 313"},
      {"name": "Seda ZAFER", "office": "D Blok - Kat 6 - 611"},
      {"name": "Sefer KURNAZ", "office": "D Blok - Kat 3 - 319"},
      {"name": "Selin Selen ÖZBEK ŞİMŞEK", "office": "D Blok - Kat 5 - 514"},
      {"name": "Selin YILMAZ", "office": "D Blok - Kat 4 - 418"},
      {"name": "Seniha Deniz SARICIOĞLU", "office": "D Blok - Kat 2 - 206Y"},
      {"name": "Sepanta Naimi", "office": "D Blok - Kat 5 - 517"},
      {"name": "Sepher SEYEDİ", "office": "D Blok - Kat 3 - 314"},
      {"name": "Serdar AY", "office": "D Blok - Kat 5 - 512"},
      {"name": "Sinan ÖZGAN", "office": "D Blok - Kat 5 - 513"},
      {"name": "Süleyman BAŞTÜRK", "office": "D Blok - Kat 3 - 312"},
      {"name": "Sümeyra AKGÜN", "office": "D Blok - Kat 2 - 206X"},
      {"name": "Şehnaz KANLI", "office": "D Blok - Kat 5 - 519"},
      {"name": "Timur İNAN", "office": "D Blok - Kat 2 - 218"},
      {"name": "Tuncer ÇELİK", "office": "D Blok - Kat 3 - 411"},
      {"name": "Uğur DÜNDAR", "office": "D Blok - Kat 3 - 306A"},
      {"name": "Vahid HAJIPOUR", "office": "D Blok - Kat 3 - 314"},
      {"name": "Yasa EKŞİOĞLU ÖZOK", "office": "D Blok - Kat 4 - 413"},
      {"name": "Yaser ALAIWI", "office": "D Blok - Kat 5 - 520"},
      {"name": "Yiğit ÇETİN", "office": "D Blok - Kat 6 - 611"},
      {"name": "Youcef BENFIADA", "office": "D Blok - Kat 3 - 314"},
      {"name": "Yusuf TUNCAY", "office": "D Blok - Kat 5 - 518"},
      {"name": "Zeki HASGÜR", "office": "D Blok - Kat 3 - 315"}
      
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Hoca Ofisleri")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lecturers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(lecturers[index]["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Ofis: ${lecturers[index]["office"]}"),
              trailing: const Icon(Icons.location_on, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
