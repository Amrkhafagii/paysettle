import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../localization/l10n.dart';
import '../theme/tokens.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.strings;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        height: 72,
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          _NavDestination(
              icon: Icons.account_balance_wallet_rounded,
              label: strings.walletTab),
          _NavDestination(
              icon: Icons.route_rounded, label: strings.journeysTab),
          _NavDestination(
              icon: Icons.group_rounded, label: strings.contactsTab),
          _NavDestination(
              icon: Icons.notifications_rounded, label: strings.alertsTab),
          _NavDestination(
              icon: Icons.settings_rounded, label: strings.settingsTab),
        ]
            .map((dest) => NavigationDestination(
                icon: dest.inactiveIcon,
                selectedIcon: dest.activeIcon,
                label: dest.label))
            .toList(),
        onDestinationSelected: (index) => navigationShell.goBranch(index,
            initialLocation: index == navigationShell.currentIndex),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.brandMint100,
      ),
    );
  }
}

class _NavDestination {
  _NavDestination({required IconData icon, required this.label})
      : inactiveIcon = Icon(icon),
        activeIcon = Icon(icon, color: AppColors.brandMint600);

  final Widget inactiveIcon;
  final Widget activeIcon;
  final String label;
}
