import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/performance/lazy_data_list_view.dart';
import '../../../../src/theme/tokens.dart';
import '../../domain/entities/contact.dart';
import '../../domain/value_objects/contact_sort.dart';
import '../controllers/contacts_controller.dart';

class ContactsPage extends ConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactsControllerProvider);
    final controller = ref.watch(contactsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'Search contacts',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Radii.card),
                ),
              ),
              onChanged: controller.updateQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Row(
              children: [
                Text('Sort by', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: Spacing.sm),
                DropdownButton<ContactSort>(
                  value: state.sort,
                  onChanged: (value) {
                    if (value != null) controller.updateSort(value);
                  },
                  items: ContactSort.values
                      .map((sort) => DropdownMenuItem(
                            value: sort,
                            child: Text(sort.label),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Expanded(
            child: state.contacts.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text(error.toString())),
              data: (contacts) => LazyDataListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.lg, vertical: Spacing.sm),
                itemBuilder: (context, index) => _ContactTile(
                  contact: contacts[index],
                  onDelete: () => controller.deleteContact(contacts[index].id),
                ),
                separatorBuilder: (_, __) => const SizedBox(height: Spacing.sm),
                itemCount: contacts.length,
                hasMore: state.hasMore,
                isLoadingMore: state.isLoadingMore,
                onEndReached: state.hasMore ? controller.loadMore : null,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openContactSheet(context, controller),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Contact'),
      ),
    );
  }

  void _openContactSheet(BuildContext context, ContactsController controller) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.card)),
      ),
      builder: (context) => _ContactForm(controller: controller),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact, required this.onDelete});

  final Contact contact;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(contact.displayName.isEmpty ? '?' : contact.displayName[0])),
        title: Text(contact.displayName,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.email != null)
              Text(contact.email!, style: Theme.of(context).textTheme.bodySmall),
            if (contact.phone != null)
              Text(contact.phone!, style: Theme.of(context).textTheme.bodySmall),
            if (contact.links.isNotEmpty)
              Wrap(
                spacing: Spacing.xs,
                children: contact.links
                    .map((link) => Chip(
                          label: Text(link.label ?? link.type.name),
                          visualDensity: VisualDensity.compact,
                        ))
                    .toList(),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm({required this.controller});

  final ContactsController controller;

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: Spacing.lg,
        right: Spacing.lg,
        top: Spacing.lg,
        bottom: bottomPadding + Spacing.lg,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Contact', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Spacing.md),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: Spacing.sm),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: Spacing.sm),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: Spacing.lg),
            FilledButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final contact = Contact(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    displayName: _nameController.text.trim(),
                    email: _emailController.text.trim().isEmpty
                        ? null
                        : _emailController.text.trim(),
                    phone: _phoneController.text.trim().isEmpty
                        ? null
                        : _phoneController.text.trim(),
                    tags: const [],
                    links: const [],
                    createdAt: DateTime.now(),
                  );
                  await widget.controller.saveContact(contact);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
