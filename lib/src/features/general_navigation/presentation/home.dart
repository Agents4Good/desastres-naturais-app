import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluvia/src/features/language/language_controller.dart';
import 'package:pluvia/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:pluvia/l10n/app_localizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool option = false;

  void alternateOption() {
    setState(() {
      option = !option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageController = ref.watch(languageControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0b2351),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                // const Icon(
                //   Icons.chat_bubble_outline,
                //   size: 80,
                //   color: Colors.white,
                // ),
                Image.asset(
                  'assets/white_logo_bg.png',
                  width: 80,
                  height: 80,
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
                Column(
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
                    // **Novo card de idioma**
                    _NavigationCard(
                      title: 'Language',
                      subtitle: languageController.isEnglish ? 'EN' : 'PT', // mostra EN quando inglês ativo
                      icon: Icons.language,
                      color: Colors.blue, // mesma cor dos outros
                      onTap: () {
                        ref.read(languageControllerProvider).toggleLanguage();
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
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
