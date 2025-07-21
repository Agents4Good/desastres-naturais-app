import 'package:aguas_da_borborema/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    // TODO: Remove
    var candidate1 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _NavigationCard(
            title: 'Chat',
            subtitle:
                'Navegue por uma gama de modelos que rodam localmente no seu dispostivo!',
            icon: Icons.chat,
            color: Colors.blue,
            onTap: () => context.goNamed(AppRoute.chat.name)),
        _NavigationCard(
            title: 'Mapa',
            subtitle: 'Visualize no mapa as novas atualizações de previsões!',
            icon: Icons.map_outlined,
            color: Colors.blue,
            onTap: () => context.goNamed(AppRoute.map.name)),
        _NavigationCard(
            title: 'Previsões',
            subtitle: 'Cheque as últimas previsões!',
            icon: Icons.cloudy_snowing,
            color: Colors.blue,
            onTap: () => context.goNamed(AppRoute.forecast.name)),
        _NavigationCard(
            title: 'Contatos',
            subtitle: 'Acesse sua lista de contatos.',
            icon: Icons.people,
            color: Colors.blue,
            onTap: () => context.goNamed(AppRoute.contacts.name)),
        _NavigationCard(
            title: 'Configurações',
            subtitle:
                'Acesse as configurações de modelos, casa e contatos salvos.',
            icon: Icons.settings,
            color: Colors.blue,
            onTap: () => context.goNamed(AppRoute.settings.name)),
      ],
    );

    var candidate2 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              _SmallNavigationCard(
                  title: 'Chat',
                  icon: Icons.chat,
                  color: Colors.blue,
                  onTap: () => context.goNamed(AppRoute.chat.name)),
              _SmallNavigationCard(
                  title: 'Mapa',
                  icon: Icons.map_outlined,
                  color: Colors.blue,
                  onTap: () => context.goNamed(AppRoute.map.name)),
              _SmallNavigationCard(
                  title: 'Previsões',
                  icon: Icons.cloudy_snowing,
                  color: Colors.blue,
                  onTap: () => context.goNamed(AppRoute.forecast.name)),
              _SmallNavigationCard(
                  title: 'Configurações',
                  icon: Icons.settings,
                  color: Colors.blue,
                  onTap: () => context.goNamed(AppRoute.settings.name)),
              _SmallNavigationCard(
                  title: 'Contatos',
                  icon: Icons.settings,
                  color: Colors.blue,
                  onTap: () => context.goNamed(AppRoute.contacts.name)),
            ])
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0b2351),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: alternateOption,
                  child: const Text("Alternar visualização")),
              const Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              const Text(
                'Bem-vindo ao Águas da Borborema',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Explore nossa solução de assistência à eventos de catástrofes naturais',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              if (option) candidate1,
              if (!option) candidate2
            ])
          ])),
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
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 24),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Expanded(
              //   child:
              // ),
              // const Icon(
              //   Icons.arrow_forward_ios,
              //   color: Colors.white54,
              //   size: 16,
              // ),
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
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 24),
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
