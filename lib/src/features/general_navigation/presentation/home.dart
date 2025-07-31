import 'package:flutter/material.dart';
import 'package:aguas_da_borborema/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:aguas_da_borborema/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool option = false;

  void alternateOption() {
    setState(() {
      option = !option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // cards grandes
    var candidate1 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _NavigationCard(
          title: l10n.navChat,
          subtitle: l10n.homeChatSubtitle,
          icon: Icons.chat,
          color: Colors.blue,
          onTap: () => context.goNamed(AppRoute.chat.name),
        ),
        _NavigationCard(
          title: l10n.navMap,
          subtitle: l10n.homeMapSubtitle,
          icon: Icons.map_outlined,
          color: Colors.blue,
          onTap: () => context.goNamed(AppRoute.map.name),
        ),
        _NavigationCard(
          title: l10n.navForecast,
          subtitle: l10n.homeForecastSubtitle,
          icon: Icons.cloudy_snowing,
          color: Colors.blue,
          onTap: () => context.goNamed(AppRoute.forecast.name),
        ),
        _NavigationCard(
          title: l10n.navContacts,
          subtitle: l10n.homeContactsSubtitle,
          icon: Icons.people,
          color: Colors.blue,
          onTap: () => context.goNamed(AppRoute.contacts.name),
        ),
        _NavigationCard(
          title: l10n.navSettings,
          subtitle: l10n.homeSettingsSubtitle,
          icon: Icons.settings,
          color: Colors.blue,
          onTap: () => context.goNamed(AppRoute.settings.name),
        ),
      ],
    );

    // cards pequenos
    var candidate2 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            _SmallNavigationCard(
              title: l10n.navChat,
              icon: Icons.chat,
              color: Colors.blue,
              onTap: () => context.goNamed(AppRoute.chat.name),
            ),
            _SmallNavigationCard(
              title: l10n.navMap,
              icon: Icons.map_outlined,
              color: Colors.blue,
              onTap: () => context.goNamed(AppRoute.map.name),
            ),
            _SmallNavigationCard(
              title: l10n.navForecast,
              icon: Icons.cloudy_snowing,
              color: Colors.blue,
              onTap: () => context.goNamed(AppRoute.forecast.name),
            ),
            _SmallNavigationCard(
              title: l10n.navContacts,
              icon: Icons.people,
              color: Colors.blue,
              onTap: () => context.goNamed(AppRoute.contacts.name),
            ),
            _SmallNavigationCard(
              title: l10n.navSettings,
              icon: Icons.settings,
              color: Colors.blue,
              onTap: () => context.goNamed(AppRoute.settings.name),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0b2351),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: alternateOption,
                child: Text(l10n.buttonToggleView),
              ),
              const Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              Text(
                l10n.homeWelcomeTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.homeWelcomeSubtitle,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              if (option) candidate1,
              if (!option) candidate2,
            ],
          )
        ]),
      ),
    );
  }
}

class _SmallNavigationCard extends StatelessWidget {
  const _SmallNavigationCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1a3a5c),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationCard extends StatelessWidget {
  const _NavigationCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1a3a5c),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
