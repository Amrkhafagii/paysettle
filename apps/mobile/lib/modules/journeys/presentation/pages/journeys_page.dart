import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../src/navigation/routes.dart';
import '../../../../src/performance/isolated_matrix_builder.dart';
import '../../../../src/theme/tokens.dart';

class JourneysPage extends ConsumerWidget {
  const JourneysPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Journeys')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _JourneyHeroCard(
            title: 'Welcome Amr',
            description: 'Keep tabs on running, past, and calendar journeys.',
          ),
          const SizedBox(height: Spacing.lg),
          const _JourneySection(title: 'Active'),
          const SizedBox(height: Spacing.lg),
          const _JourneySection(title: 'Past'),
          const SizedBox(height: Spacing.lg),
          const _JourneySpendingMatrix(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.journeyCreate),
        icon: const Icon(Icons.add),
        label: const Text('New Journey'),
      ),
    );
  }
}

class _JourneyHeroCard extends StatelessWidget {
  const _JourneyHeroCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.card),
        color: AppColors.brandMint50,
      ),
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: Spacing.sm),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _JourneySection extends StatelessWidget {
  const _JourneySection({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        Wrap(
          spacing: Spacing.md,
          runSpacing: Spacing.md,
          children: [
            _JourneyCard(
              name: 'Running Expenses',
              onTap: () => context.go(
                  '${AppRoutes.journeys}/${Uri.encodeComponent('Running Expenses')}'),
            ),
            _JourneyCard(
              name: 'Trip / Travel',
              onTap: () => context.go(
                  '${AppRoutes.journeys}/${Uri.encodeComponent('Trip / Travel')}'),
            ),
            _JourneyCard(
              name: 'Food Order',
              onTap: () => context.go(
                  '${AppRoutes.journeys}/${Uri.encodeComponent('Food Order')}'),
            ),
            _JourneyCard(
              name: 'Playstation Night',
              onTap: () => context.go(
                  '${AppRoutes.journeys}/${Uri.encodeComponent('Playstation Night')}'),
            ),
          ],
        ),
      ],
    );
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.name, required this.onTap});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Radii.card),
      onTap: onTap,
      child: Container(
        width: 150,
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.neutral0,
          borderRadius: BorderRadius.circular(Radii.card),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
          ],
        ),
        padding: const EdgeInsets.all(Spacing.md),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(name, style: Theme.of(context).textTheme.titleSmall),
        ),
      ),
    );
  }
}

class _JourneySpendingMatrix extends StatefulWidget {
  const _JourneySpendingMatrix();

  @override
  State<_JourneySpendingMatrix> createState() => _JourneySpendingMatrixState();
}

class _JourneySpendingMatrixState extends State<_JourneySpendingMatrix> {
  late Future<JourneyMatrix> _matrixFuture;

  @override
  void initState() {
    super.initState();
    _matrixFuture = IsolatedMatrixBuilder.build(_matrixSampleEntries);
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: 'EGP ');
    return FutureBuilder<JourneyMatrix>(
      future: _matrixFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(Radii.card),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final matrix = snapshot.data;
        if (matrix == null) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.card),
            color: AppColors.surfaceCard,
            boxShadow: AppShadows.level1,
          ),
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Journey Spending Matrix',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: Spacing.xs),
              Text('Computed off the main isolate to keep scrolling smooth.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.neutral600)),
              const SizedBox(height: Spacing.md),
              Text('Total Spent: ${formatter.format(matrix.total)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: Spacing.md),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStatePropertyAll(
                    AppColors.surfaceCardAlt,
                  ),
                  dataRowHeight: 54,
                  columns: [
                    const DataColumn(
                        label: Text('Participant',
                            style: TextStyle(fontWeight: FontWeight.w600))),
                    ...matrix.categories.map(
                      (category) => DataColumn(
                        label: Text(category.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                    ),
                    const DataColumn(
                        label: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.w600))),
                  ],
                  rows: matrix.rows
                      .map(
                        (row) => DataRow(
                          cells: [
                            DataCell(Text(row.participant)),
                            ...matrix.categories.map(
                              (category) => DataCell(Text(
                                row.values[category] == null
                                    ? '-'
                                    : formatter.format(
                                        row.values[category],
                                      ),
                              )),
                            ),
                            DataCell(Text(formatter.format(row.rowTotal))),
                          ],
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

const _matrixSampleEntries = [
  {'participant': 'Noha', 'category': 'Accommodation', 'amount': 1200},
  {'participant': 'Noha', 'category': 'Transport', 'amount': 640},
  {'participant': 'Ahmed', 'category': 'Accommodation', 'amount': 800},
  {'participant': 'Ahmed', 'category': 'Food', 'amount': 540},
  {'participant': 'Tarek', 'category': 'Transport', 'amount': 120},
  {'participant': 'Tarek', 'category': 'Activities', 'amount': 420},
  {'participant': 'Hend', 'category': 'Food', 'amount': 300},
  {'participant': 'Hend', 'category': 'Activities', 'amount': 650},
  {'participant': 'Seleim', 'category': 'Accommodation', 'amount': 900},
  {'participant': 'Shawky', 'category': 'Transport', 'amount': 150},
  {'participant': 'Shawky', 'category': 'Food', 'amount': 80},
];
