import 'package:flutter/material.dart';
import '../data/shuttle_repository.dart';
import '../l10n/app_localizations.dart';

class ShuttlePage extends StatefulWidget {
  const ShuttlePage({super.key});

  @override
  State<ShuttlePage> createState() => _ShuttlePageState();
}

class _ShuttlePageState extends State<ShuttlePage> with SingleTickerProviderStateMixin {
  List<ShuttleCampus> _campuses = [];
  bool _loading = true;
  TabController? _tabController;
  bool _isWeekend = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await ShuttleRepository.load();
    if (mounted) {
      _tabController?.dispose();
      setState(() {
        _campuses = list;
        _loading = false;
        _tabController = list.isEmpty ? null : TabController(length: list.length, vsync: this);
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  String _campusTitle(String id) {
    final l10n = AppLocalizations.of(context);
    switch (id) {
      case 'bakirkoy': return l10n.bakirkoy;
      case 'gayrettepe': return l10n.gayrettepe;
      case 'mahmutbey_metro': return l10n.mahmutbeyMetro;
      case 'yenibosna': return l10n.yenibosna;
      default: return id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.shuttle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_campuses.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.shuttle)),
        body: Center(child: Text(l10n.emptyShuttle)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shuttle),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text(l10n.weekday),
                    selected: !_isWeekend,
                    onSelected: (v) => setState(() => _isWeekend = false),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text(l10n.weekend),
                    selected: _isWeekend,
                    onSelected: (v) => setState(() => _isWeekend = true),
                  ),
                ],
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: _campuses.map((c) => Tab(text: _campusTitle(c.id))).toList(),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: TabBarView(
          controller: _tabController!,
          children: _campuses.map((c) {
            final lines = _isWeekend ? c.weekend : c.weekday;
            if (lines.isEmpty) {
              return Center(child: Text(l10n.noData));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: lines.length,
              itemBuilder: (_, i) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade700,
                    child: const Icon(Icons.directions_bus, color: Colors.white),
                  ),
                  title: Text(lines[i], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
