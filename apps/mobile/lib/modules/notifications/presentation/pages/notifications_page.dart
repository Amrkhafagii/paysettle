import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/theme/tokens.dart';
import '../../domain/entities/app_notification.dart';
import '../controllers/notifications_controller.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsControllerProvider);
    final controller = ref.read(notificationsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (state.isRealtimeConnected)
            const Padding(
              padding: EdgeInsets.only(right: Spacing.md),
              child: Chip(
                label: Text('Live'),
                avatar: Icon(Icons.wifi, size: 16),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: state.feed.when(
          loading: () => const _NotificationsLoading(),
          error: (error, _) => _NotificationsError(
            message: error.toString(),
            onRetry: controller.refresh,
          ),
          data: (feed) => _NotificationsList(
            feed: feed,
            onMarkAsRead: controller.markAsRead,
          ),
        ),
      ),
    );
  }
}

class _NotificationsLoading extends StatelessWidget {
  const _NotificationsLoading();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: const [
        LinearProgressIndicator(),
        SizedBox(height: Spacing.lg),
        LinearProgressIndicator(),
      ],
    );
  }
}

class _NotificationsError extends StatelessWidget {
  const _NotificationsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        Text('Unable to load notifications',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.xs),
        Text(message),
        const SizedBox(height: Spacing.md),
        FilledButton(onPressed: onRetry, child: const Text('Try again')),
      ],
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList({
    required this.feed,
    required this.onMarkAsRead,
  });

  final NotificationFeed feed;
  final Future<void> Function(String id) onMarkAsRead;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding:
          const EdgeInsets.fromLTRB(Spacing.lg, Spacing.lg, Spacing.lg, 120),
      children: [
        if (feed.newItems.isNotEmpty) ...[
          Text('New', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: Spacing.sm),
          ...feed.newItems.map((item) => _NotificationTile(
                notification: item,
                onMarkAsRead: onMarkAsRead,
              )),
          const SizedBox(height: Spacing.lg),
        ],
        Text('Earlier', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: Spacing.sm),
        if (feed.earlierItems.isEmpty) const Text('No earlier notifications'),
        ...feed.earlierItems.map((item) => _NotificationTile(
              notification: item,
              onMarkAsRead: onMarkAsRead,
            )),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onMarkAsRead,
  });

  final AppNotification notification;
  final Future<void> Function(String id) onMarkAsRead;

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(notification.severity);
    final icon = _iconFor(notification.type);
    final isUnread = notification.readAt == null;
    return Card(
      color: isUnread ? AppColors.surfaceAccent : AppColors.neutral0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(notification.title),
        subtitle: Text(notification.body),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_timeAgo(notification.createdAt)),
            if (isUnread)
              TextButton(
                onPressed: () => onMarkAsRead(notification.id),
                child: const Text('Mark read'),
              ),
          ],
        ),
      ),
    );
  }

  Color _colorFor(NotificationSeverity severity) {
    switch (severity) {
      case NotificationSeverity.success:
        return AppColors.brandMint500;
      case NotificationSeverity.warning:
        return AppColors.warning;
      case NotificationSeverity.critical:
        return AppColors.error;
      case NotificationSeverity.info:
      default:
        return AppColors.info;
    }
  }

  IconData _iconFor(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.budget:
        return Icons.pie_chart_rounded;
      case AppNotificationType.payment:
        return Icons.currency_exchange_rounded;
      case AppNotificationType.reminder:
        return Icons.alarm_rounded;
      case AppNotificationType.insight:
        return Icons.bar_chart_rounded;
      case AppNotificationType.system:
      default:
        return Icons.notifications_rounded;
    }
  }

  String _timeAgo(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inMinutes < 1) {
      return 'Now';
    }
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }
    return '${difference.inDays}d ago';
  }
}
