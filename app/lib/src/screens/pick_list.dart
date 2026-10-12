import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i18n.dart';

/// Tri d'une liste de choix ; pour les personnes, la première colonne
/// affichée suit le tri (nom, matricule ou identifiant Staff Flow).
enum PickSort {
  natural,
  name,
  number,
  sfId;

  String label(L10n t) => switch (this) {
        natural => t.sortNatural,
        name => t.sortName,
        number => t.employeeNumber,
        sfId => t.sfIdLabel,
      };
}

/// Tri des personnes choisi par le responsable, gardé sur l'appareil.
class PickPrefs {
  static const _key = 'pick_sort';
  static final people = ValueNotifier(PickSort.name);
  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      people.value = PickSort.values.asNameMap()[prefs.getString(_key)] ?? PickSort.name;
    } catch (_) {
      // Pas de stockage : tri par nom.
    }
  }

  static Future<void> set(PickSort sort) async {
    people.value = sort;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, sort.name);
    } catch (_) {}
  }
}

/// Une ligne d'une liste de choix.
class PickItem {
  final String id;
  final String name;

  /// Matricule donné par l'employeur.
  final String? number;

  /// Identifiant Staff Flow (SF-…).
  final String? sfId;

  /// Précision affichée en petit (rôle, poste, autre entreprise…).
  final String? detail;

  /// Absent ou déjà en service : « ! » en rouge (rien n'est bloqué).
  final bool warn;

  /// Niveau dans un arbre (sites), pour décaler la ligne.
  final int indent;

  /// Texte affiché une fois choisi (chemin complet d'un site).
  final String? selectedText;

  const PickItem(this.id, this.name,
      {this.number, this.sfId, this.detail, this.warn = false, this.indent = 0, this.selectedText});

  /// Colonnes dans l'ordre du tri : la clé de tri d'abord.
  List<String> columns(PickSort sort) {
    final all = [name, ?number, ?sfId];
    final first = switch (sort) {
      PickSort.number => number,
      PickSort.sfId => sfId,
      _ => name,
    };
    return first == null ? all : [first, ...all.where((c) => c != first)];
  }
}

/// Recherche sans majuscules ni accents (« eve » trouve « Ève »).
String foldText(String s) {
  const from = 'àáâãäåçèéêëìíîïñòóôõöùúûüýÿœæ';
  const to = 'aaaaaaceeeeiiiinooooouuuuyyoa';
  final b = StringBuffer();
  for (final r in s.toLowerCase().runes) {
    final c = String.fromCharCode(r);
    final i = from.indexOf(c);
    b.write(i < 0 ? c : to[i]);
  }
  return b.toString();
}

/// Comparaison « naturelle » : M-9 avant M-10.
int naturalCompare(String a, String b) {
  final re = RegExp(r'(\d+)|(\D+)');
  final x = re.allMatches(foldText(a)).toList(), y = re.allMatches(foldText(b)).toList();
  for (var i = 0; i < x.length && i < y.length; i++) {
    final p = x[i][0]!, q = y[i][0]!;
    final c = x[i][1] != null && y[i][1] != null ? int.parse(p).compareTo(int.parse(q)) : p.compareTo(q);
    if (c != 0) return c;
  }
  return x.length.compareTo(y.length);
}

/// Trie [items] ; les lignes sans matricule (ou sans ID) passent à la fin.
List<PickItem> sortItems(List<PickItem> items, PickSort sort) {
  if (sort == PickSort.natural) return items;
  String? key(PickItem i) => switch (sort) {
        PickSort.number => i.number,
        PickSort.sfId => i.sfId,
        _ => i.name,
      };
  return [...items]..sort((a, b) {
      final x = key(a), y = key(b);
      if (x == null || y == null) return x == null ? (y == null ? naturalCompare(a.name, b.name) : 1) : -1;
      final c = naturalCompare(x, y);
      return c != 0 ? c : naturalCompare(a.name, b.name);
    });
}

/// Garde les lignes qui contiennent [query] (nom, matricule ou ID).
List<PickItem> searchItems(List<PickItem> items, String query) {
  final q = foldText(query.trim());
  if (q.isEmpty) return items;
  return [
    for (final i in items)
      if (foldText(i.name).contains(q) ||
          foldText(i.number ?? '').contains(q) ||
          foldText(i.sfId ?? '').contains(q) ||
          foldText(i.detail ?? '').contains(q))
        i,
  ];
}

/// Menu déroulant avec recherche, tri et coches : on voit [visibleRows]
/// lignes et on fait défiler le reste (doigt ou molette). Plusieurs choix
/// possibles avec [multi].
class PickList extends StatefulWidget {
  final String label;
  final List<PickItem> items;
  final Set<String> selected;
  final bool multi;
  final ValueChanged<Set<String>> onChanged;

  /// Tris proposés ; avec [PickSort.name], [PickSort.number] ou
  /// [PickSort.sfId], le choix du responsable est gardé (personnes).
  final List<PickSort> sorts;

  /// Texte quand rien n'est choisi ; avec [allowNone], une ligne pour
  /// ne rien choisir (liste à un seul choix).
  final String emptyText;
  final bool allowNone;

  /// Filtres affichés sous la recherche (postes, sites…).
  final List<Widget> filters;

  /// Petit texte sous la liste (par ex. « un service par personne »).
  final String? hint;

  final int visibleRows;

  const PickList({
    super.key,
    required this.label,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.multi = false,
    this.sorts = const [PickSort.natural, PickSort.name],
    required this.emptyText,
    this.allowNone = false,
    this.filters = const [],
    this.hint,
    this.visibleRows = 10,
  });

  @override
  State<PickList> createState() => _PickListState();
}

class _PickListState extends State<PickList> {
  static const _rowHeight = 56.0;
  bool _open = false;
  final _query = TextEditingController();

  /// Liste de personnes : le tri suit la préférence gardée.
  bool get _people => widget.sorts.contains(PickSort.number) || widget.sorts.contains(PickSort.sfId);
  late PickSort _sort = widget.sorts.first;

  @override
  void initState() {
    super.initState();
    if (_people) {
      _sort = PickPrefs.people.value;
      PickPrefs.load().then((_) {
        if (mounted && widget.sorts.contains(PickPrefs.people.value)) setState(() => _sort = PickPrefs.people.value);
      });
    }
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void _toggle(String id) {
    if (widget.multi) {
      final next = {...widget.selected};
      if (!next.remove(id)) next.add(id);
      widget.onChanged(next);
    } else {
      widget.onChanged(id.isEmpty ? {} : {id});
      setState(() => _open = false);
    }
  }

  String _summary(L10n t) {
    final chosen = [for (final i in widget.items) if (widget.selected.contains(i.id)) i];
    if (chosen.isEmpty) return widget.emptyText;
    if (!widget.multi) return chosen.first.selectedText ?? chosen.first.columns(_sort).join(' · ');
    final names = chosen.take(3).map((i) => i.name).join(', ');
    return chosen.length > 3 ? '$names +${chosen.length - 3}' : names;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final shown = sortItems(searchItems(widget.items, _query.text), _sort);
    final rows = [if (widget.allowNone && !widget.multi && _query.text.isEmpty) PickItem('', widget.emptyText), ...shown];
    final count = widget.selected.length;
    // Une seule surface aux coins arrondis : l'en-tête, puis la liste dépliée.
    final radius = BorderRadius.circular(18);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => setState(() => _open = !_open),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
                child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(widget.multi && count > 0 ? '${widget.label} · $count' : widget.label,
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary)),
                      const SizedBox(height: 2),
                      Text(_summary(t), maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyLarge),
                    ]),
                  ),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more),
                  ),
                ]),
              ),
            ),
            if (_open) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 4, 0),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: _query,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        prefixIcon: const Icon(Icons.search, size: 20),
                        hintText: _people ? t.pickSearchPeople : t.pickSearch,
                        suffixIcon: _query.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () => setState(_query.clear),
                              ),
                      ),
                    ),
                  ),
                  if (widget.sorts.length > 1)
                    PopupMenuButton<PickSort>(
                      tooltip: t.pickSortTitle,
                      icon: const Icon(Icons.sort),
                      initialValue: _sort,
                      onSelected: (s) {
                        setState(() => _sort = s);
                        if (_people) PickPrefs.set(s);
                      },
                      itemBuilder: (_) => [
                        for (final s in widget.sorts)
                          CheckedPopupMenuItem(value: s, checked: s == _sort, child: Text(s.label(t))),
                      ],
                    ),
                ]),
              ),
              if (widget.filters.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                  child: Wrap(spacing: 6, runSpacing: 4, children: widget.filters),
                ),
              if (widget.multi)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 6, 0),
                  child: Row(children: [
                    Expanded(child: Text(t.pickSelected('$count'), style: theme.textTheme.bodySmall)),
                    TextButton(
                      onPressed:
                          shown.isEmpty ? null : () => widget.onChanged({...widget.selected, for (final i in shown) i.id}),
                      child: Text(t.pickCheckAll),
                    ),
                    TextButton(
                      onPressed: count == 0 ? null : () => widget.onChanged({}),
                      child: Text(t.pickClear),
                    ),
                  ]),
                ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                height: _rowHeight * (rows.isEmpty ? 1 : rows.length.clamp(1, widget.visibleRows)),
                decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(14)),
                clipBehavior: Clip.antiAlias,
                child: rows.isEmpty
                    ? Center(child: Text(t.pickNoResult, style: theme.textTheme.bodySmall))
                    : Scrollbar(
                        thumbVisibility: rows.length > widget.visibleRows,
                        child: ListView.builder(
                          primary: false,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          itemExtent: _rowHeight,
                          itemCount: rows.length,
                          itemBuilder: (context, i) => _row(rows[i], theme),
                        ),
                      ),
              ),
              if (widget.hint != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Text(widget.hint!, style: theme.textTheme.bodySmall),
                ),
            ],
          ],
        ),
      ),
    );
  }

  /// Ligne choisie : fond teinté et coche à droite ; les autres, rien.
  Widget _row(PickItem item, ThemeData theme) {
    final on = item.id.isEmpty ? widget.selected.isEmpty : widget.selected.contains(item.id);
    final cols = item.columns(_sort);
    final warn = item.warn ? TextStyle(color: theme.colorScheme.error) : null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Material(
        color: on ? theme.colorScheme.primaryContainer.withValues(alpha: 0.6) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _toggle(item.id),
          child: Padding(
            padding: EdgeInsets.only(left: 12 + 16.0 * item.indent, right: 12),
            child: Row(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        if (item.warn) TextSpan(text: '! ', style: warn),
                        TextSpan(
                            text: cols.first,
                            style: (warn ?? const TextStyle()).copyWith(fontWeight: on ? FontWeight.w700 : FontWeight.w600)),
                        if (cols.length > 1) TextSpan(text: '  ${cols.skip(1).join(' · ')}', style: theme.textTheme.bodySmall),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.detail != null)
                      Text(item.detail!, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              if (on) Icon(Icons.check_rounded, color: theme.colorScheme.primary, size: 24),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Petit filtre « Poste : Tous ▾ » : [options] (id → nom), `null` pour tous.
class FilterMenu extends StatelessWidget {
  final String label;
  final String? value;
  final Map<String, String> options;
  final ValueChanged<String?> onChanged;

  const FilterMenu({super.key, required this.label, required this.value, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return PopupMenuButton<String>(
      tooltip: label,
      onSelected: (v) => onChanged(v.isEmpty ? null : v),
      itemBuilder: (_) => [
        CheckedPopupMenuItem(value: '', checked: value == null, child: Text(t.filterAll)),
        for (final e in options.entries) CheckedPopupMenuItem(value: e.key, checked: value == e.key, child: Text(e.value)),
      ],
      child: Chip(
        avatar: Icon(Icons.filter_list, size: 16, color: value == null ? null : Theme.of(context).colorScheme.primary),
        label: Text(t.filterValue(label, value == null ? t.filterAll : options[value] ?? '?')),
      ),
    );
  }
}
