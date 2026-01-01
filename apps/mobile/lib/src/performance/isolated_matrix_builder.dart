import 'package:flutter/foundation.dart';

class JourneyMatrix {
  const JourneyMatrix({
    required this.categories,
    required this.rows,
    required this.total,
  });

  final List<String> categories;
  final List<JourneyMatrixRow> rows;
  final double total;
}

class JourneyMatrixRow {
  const JourneyMatrixRow({
    required this.participant,
    required this.values,
    required this.rowTotal,
  });

  final String participant;
  final Map<String, double> values;
  final double rowTotal;
}

class IsolatedMatrixBuilder {
  static Future<JourneyMatrix> build(List<Map<String, dynamic>> rawEntries) {
    return compute(_buildInternal, rawEntries);
  }

  static JourneyMatrix _buildInternal(List<Map<String, dynamic>> rawEntries) {
    final categories = <String>{};
    final rows = <String, Map<String, double>>{};
    double total = 0;

    for (final entry in rawEntries) {
      final participant = (entry['participant'] ?? 'Unknown').toString();
      final category = (entry['category'] ?? 'Other').toString();
      final amount = (entry['amount'] as num?)?.toDouble() ?? 0;
      categories.add(category);
      total += amount;
      final participantTotals = rows.putIfAbsent(participant, () => {});
      participantTotals.update(category, (value) => value + amount,
          ifAbsent: () => amount);
    }

    final orderedCategories = categories.toList()..sort();
    final matrixRows = rows.entries
        .map((entry) {
          final participant = entry.key;
          final values = <String, double>{};
          double rowTotal = 0;
          for (final category in orderedCategories) {
            final value = entry.value[category] ?? 0;
            values[category] = value;
            rowTotal += value;
          }
          return JourneyMatrixRow(
            participant: participant,
            values: values,
            rowTotal: rowTotal,
          );
        })
        .toList()
      ..sort((a, b) => b.rowTotal.compareTo(a.rowTotal));

    return JourneyMatrix(
      categories: orderedCategories,
      rows: matrixRows,
      total: total,
    );
  }
}
