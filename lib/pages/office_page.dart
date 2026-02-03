import 'package:flutter/material.dart';
import '../data/lecturers_repository.dart';
import '../l10n/app_localizations.dart';
import '../models/lecturer.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({super.key});

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Lecturer> _all = [];
  List<Lecturer> _filtered = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await LecturersRepository.load();
    if (mounted) {
      setState(() {
        _all = list;
        _filtered = list;
        _loading = false;
      });
    }
  }

  void _filter(String query) {
    if (query.isEmpty) {
      setState(() => _filtered = List.from(_all));
      return;
    }
    final q = query.toLowerCase().trim();
    setState(() {
      _filtered = _all.where((l) {
        return l.name.toLowerCase().contains(q) ||
            l.office.toLowerCase().contains(q) ||
            l.email.toLowerCase().contains(q);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.lecturerOffices),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                onChanged: _filter,
                decoration: InputDecoration(
                  hintText: l10n.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _searchController,
                    builder: (_, value, __) {
                      return value.text.isEmpty
                          ? const SizedBox.shrink()
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _filter('');
                              },
                            );
                    },
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            if (_loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (_filtered.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.green.shade300),
                      const SizedBox(height: 16),
                      Text(l10n.noData, style: TextStyle(fontSize: 18, color: Colors.green.shade700)),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _filtered.length,
                  itemBuilder: (context, index) {
                    final l = _filtered[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade700,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(l.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(children: [
                              Icon(Icons.room, size: 16, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Expanded(child: Text('${l10n.office}: ${l.office}', style: const TextStyle(fontSize: 14))),
                            ]),
                            const SizedBox(height: 4),
                            Row(children: [
                              Icon(Icons.email, size: 16, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Expanded(child: Text('${l10n.email}: ${l.email}', style: const TextStyle(fontSize: 14))),
                            ]),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.email, color: Colors.red),
                          onPressed: () {},
                          tooltip: l10n.sendEmail,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
