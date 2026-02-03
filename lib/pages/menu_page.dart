import 'package:flutter/material.dart';
import '../data/menu_repository.dart';
import '../l10n/app_localizations.dart';
import '../models/menu_models.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<DailyMenu> _menus = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; });
    var list = await MenuRepository.loadFromAsset();
    if (list.isEmpty) list = MenuRepository.getSampleMenus();
    if (mounted) setState(() { _menus = list; _loading = false; });
  }

  Future<void> _pickFile() async {
    final list = await MenuRepository.loadFromFilePicker();
    if (!mounted) return;
    if (list != null && list.isNotEmpty) {
      setState(() => _menus = list);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).menusLoaded(list.length)),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).noData),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menu),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load, tooltip: l10n.loadExcel),
          IconButton(icon: const Icon(Icons.upload_file), onPressed: _pickFile, tooltip: l10n.loadExcel),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade50, Colors.white],
          ),
        ),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _menus.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant_menu, size: 64, color: Colors.red.shade300),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(l10n.emptyMenu, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.red.shade700)),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.upload_file),
                          label: Text(l10n.loadExcel),
                          onPressed: _pickFile,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _menus.length,
                    itemBuilder: (context, index) {
                      final menu = _menus[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.red.shade200, width: 1),
                        ),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red.shade700,
                            child: const Icon(Icons.calendar_today, color: Colors.white),
                          ),
                          title: Text(_formatDate(menu.date), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900)),
                          subtitle: Text(
                            '${menu.items.length} ${l10n.menu.toLowerCase()} ? ${l10n.totalDailyCalories}: ${menu.totalCalories} kcal',
                            style: TextStyle(color: Colors.red.shade600, fontSize: 13),
                          ),
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.red.shade50,
                          children: menu.items.map((item) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(left: BorderSide(color: Colors.red.shade300, width: 3)),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.restaurant, color: Colors.red.shade700),
                                title: Text(item.name, style: const TextStyle(fontSize: 16)),
                                trailing: item.calories != null
                                    ? Text('${item.calories} kcal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade700))
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
