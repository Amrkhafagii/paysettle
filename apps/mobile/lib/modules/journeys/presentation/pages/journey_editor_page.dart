import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../src/theme/tokens.dart';

class JourneyEditorPage extends StatefulWidget {
  const JourneyEditorPage({super.key});

  @override
  State<JourneyEditorPage> createState() => _JourneyEditorPageState();
}

class _JourneyEditorPageState extends State<JourneyEditorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final initial = isStart ? _startDate ?? DateTime.now() : _endDate ?? _startDate ?? DateTime.now();
    final firstDate = DateTime(DateTime.now().year - 1);
    final lastDate = DateTime(DateTime.now().year + 2);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = picked;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Journey draft saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();
    return Scaffold(
      appBar: AppBar(title: const Text('New Journey')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Journey Name',
                hintText: 'Ex: Wahat Farm Trip',
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Please enter a name' : null,
            ),
            const SizedBox(height: Spacing.lg),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'What are you splitting?',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: Spacing.lg),
            Row(
              children: [
                Expanded(
                  child: _DateInputTile(
                    label: 'Start',
                    value: _startDate == null ? 'Select date' : formatter.format(_startDate!),
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _DateInputTile(
                    label: 'End',
                    value: _endDate == null ? 'Select date' : formatter.format(_endDate!),
                    onTap: () => _selectDate(context, false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),
            Text('Participants', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: Spacing.sm),
            Wrap(
              spacing: Spacing.sm,
              runSpacing: Spacing.sm,
              children: [
                ...const ['Noha', 'Ahmed', 'Tarek', 'Hend']
                    .map((name) => Chip(
                          label: Text(name),
                          backgroundColor: AppColors.brandMint50,
                        )),
                ActionChip(
                  label: const Text('+ Add'),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),
            Text(
              'Pre-fill expenses, assign categories, and decide how settlements should be handled.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.neutral600),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          ),
          child: const Text('Create Journey'),
        ),
      ),
    );
  }
}

class _DateInputTile extends StatelessWidget {
  const _DateInputTile({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Radii.card),
      child: Container(
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.card),
          color: AppColors.surfaceCard,
          boxShadow: AppShadows.level1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.neutral600)),
            const SizedBox(height: Spacing.xs),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
