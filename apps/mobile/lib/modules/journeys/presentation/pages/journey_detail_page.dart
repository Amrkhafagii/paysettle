import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../src/theme/tokens.dart';

enum _JourneyDetailTab { spending, settlement }

class JourneyDetailPage extends StatefulWidget {
  const JourneyDetailPage({required this.journeyName, super.key});

  final String journeyName;

  @override
  State<JourneyDetailPage> createState() => _JourneyDetailPageState();
}

class _JourneyDetailPageState extends State<JourneyDetailPage> {
  _JourneyDetailTab _tab = _JourneyDetailTab.spending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.journeyName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _JourneySummaryHeader(
            journeyName: widget.journeyName,
            view: _tab,
            onViewChanged: (value) => setState(() => _tab = value),
          ),
          const SizedBox(height: Spacing.lg),
          if (_tab == _JourneyDetailTab.spending)
            const _JourneySpendingTable()
          else
            const _JourneySettlementView(),
          const SizedBox(height: Spacing.lg),
          const _JourneyActionsGrid(),
        ],
      ),
    );
  }
}

class _JourneySummaryHeader extends StatelessWidget {
  const _JourneySummaryHeader({
    required this.journeyName,
    required this.view,
    required this.onViewChanged,
  });

  final String journeyName;
  final _JourneyDetailTab view;
  final ValueChanged<_JourneyDetailTab> onViewChanged;

  @override
  Widget build(BuildContext context) {
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
          Text(journeyName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: Spacing.xs),
          Text('Total Spent', style: Theme.of(context).textTheme.bodyMedium),
          Text('EGP 24,509.86',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: Spacing.lg),
          SegmentedButton<_JourneyDetailTab>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: _JourneyDetailTab.spending,
                label: Text('Spending'),
              ),
              ButtonSegment(
                value: _JourneyDetailTab.settlement,
                label: Text('Settlement'),
              ),
            ],
            selected: {view},
            onSelectionChanged: (value) => onViewChanged(value.first),
          ),
        ],
      ),
    );
  }
}

class _JourneySpendingTable extends StatelessWidget {
  const _JourneySpendingTable();

  static const _columns = <String>[
    'Participant',
    'Accommodation',
    'Transport',
    'Shared Snacks',
    'Other'
  ];

  static const _rows = [
    ['Noha', '-', '-', '-', '-'],
    ['Ahmed', '-', '-', '-', '-'],
    ['Tarek', '-', '-', '-', '-'],
    ['Seleim', '-', '2,000', '-', '-'],
    ['Hend', '-', '2,000', '-', '-'],
    ['Shawky', '-', '-', '-', '-'],
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.card),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          boxShadow: AppShadows.level1,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                MaterialStatePropertyAll(AppColors.surfaceCardAlt),
            columns: _columns
                .map(
                  (label) => DataColumn(
                    label: Text(label,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                )
                .toList(growable: false),
            rows: _rows
                .map(
                  (row) => DataRow(
                    cells: row
                        .map(
                          (value) => DataCell(
                            Text(value,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        )
                        .toList(growable: false),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class _JourneySettlementView extends StatelessWidget {
  const _JourneySettlementView();

  static const _settlements = [
    {'name': 'Noha', 'status': 'Collect 1,200'},
    {'name': 'Ahmed', 'status': 'Pay 850'},
    {'name': 'Hend', 'status': 'Collect 640'},
    {'name': 'Shawky', 'status': 'Pay 320'},
  ];

  @override
  Widget build(BuildContext context) {
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
          Text('Settlement Summary',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: Spacing.sm),
          ..._settlements.map(
            (entry) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: AppColors.brandMint100,
                child: Text(entry['name']!.substring(0, 1)),
              ),
              title: Text(entry['name']!,
                  style: Theme.of(context).textTheme.titleSmall),
              subtitle: Text(entry['status']!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.neutral600)),
            ),
          ),
          const SizedBox(height: Spacing.sm),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Settle All Payments'),
          ),
        ],
      ),
    );
  }
}

class _JourneyActionsGrid extends StatelessWidget {
  const _JourneyActionsGrid();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _JourneyAction(
        icon: Icons.edit_rounded,
        label: 'Add / Edit Expense',
        onTap: () => _showExpenseSheet(context),
      ),
      _JourneyAction(
        icon: Icons.search_rounded,
        label: 'Inspect Expense',
        onTap: () => _showInspectDialog(context),
      ),
      _JourneyAction(
        icon: Icons.download_rounded,
        label: 'Extract Report',
        onTap: () => _simulateExport(context),
      ),
      _JourneyAction(
        icon: Icons.gavel_rounded,
        label: 'Dispute / Enquire',
        onTap: () => _showDisputeSheet(context),
      ),
    ];

    return Wrap(
      spacing: Spacing.md,
      runSpacing: Spacing.md,
      children: actions
          .map(
            (action) => _JourneyQuickActionCard(action: action),
          )
          .toList(growable: false),
    );
  }

  static Future<void> _showExpenseSheet(BuildContext context) {
    final amountController = TextEditingController();
    final nameController = TextEditingController();
    DateTime date = DateTime.now();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.card)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.lg,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + Spacing.lg,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add / Edit Expense',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: Spacing.md),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Expense Name',
                  hintText: 'e.g. Uber to airport',
                ),
              ),
              const SizedBox(height: Spacing.md),
              TextField(
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'EGP ',
                ),
              ),
              const SizedBox(height: Spacing.md),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today_rounded),
                title: Text(
                    'Date • ${DateFormat.yMMMd().format(date)}'),
                trailing: TextButton(
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (selected != null) {
                      setState(() => date = selected);
                    }
                  },
                  child: const Text('Change'),
                ),
              ),
              const SizedBox(height: Spacing.md),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${nameController.text.isEmpty ? 'Expense' : nameController.text} saved'),
                    ),
                  );
                },
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _showInspectDialog(BuildContext context) {
    const sampleExpenses = [
      {'name': 'Shared Snacks', 'amount': 'EGP 300', 'owner': 'Noha'},
      {'name': 'Transport', 'amount': 'EGP 1,800', 'owner': 'Tarek'},
      {'name': 'Accommodation', 'amount': 'EGP 4,500', 'owner': 'Ahmed'},
    ];
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Inspect Expenses'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: sampleExpenses.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) {
              final expense = sampleExpenses[index];
              return ListTile(
                dense: true,
                title: Text(expense['name']!),
                subtitle: Text('Owner: ${expense['owner']}'),
                trailing: Text(expense['amount']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static void _simulateExport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report exported to Files/PaySettle/Wahat-Farm.xlsx'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static Future<void> _showDisputeSheet(BuildContext context) {
    final controller = TextEditingController();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.card)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.lg,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + Spacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dispute / Enquire',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Spacing.sm),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Describe the issue',
                hintText: 'Let us know what needs to be reviewed.',
              ),
            ),
            const SizedBox(height: Spacing.md),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dispute submitted • we will reply shortly'),
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class _JourneyAction {
  const _JourneyAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class _JourneyQuickActionCard extends StatelessWidget {
  const _JourneyQuickActionCard({required this.action});

  final _JourneyAction action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Radii.card),
      onTap: action.onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: AppColors.brandMint500,
          borderRadius: BorderRadius.circular(Radii.card),
          boxShadow: AppShadows.level1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(action.icon, color: AppColors.neutral0),
            const SizedBox(height: Spacing.sm),
            Text(
              action.label,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.neutral0),
            ),
          ],
        ),
      ),
    );
  }
}
