import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
          children: const [
            _JourneyCard(name: 'Running Expenses'),
            _JourneyCard(name: 'Trip / Travel'),
            _JourneyCard(name: 'Food Order'),
            _JourneyCard(name: 'Playstation Night'),
          ],
        ),
      ],
    );
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
