import 'package:aguas_da_borborema/src/features/notifications/presentation/last_week_notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// void main() {
//   runApp(NotificacoesApp());
// }

// class NotificacoesApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: NotificacoesPage(),
//     );
//   }
// }

class NotificacoesScreen extends ConsumerWidget {
  const NotificacoesScreen({super.key});

  Widget buildGravidade(String gravidade, List<String> ruas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gravidade,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if(ruas.isNotEmpty)
          ...ruas.map((rua) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("- $rua"),
              )),
        if(ruas.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("- Nenhuma rua com $gravidade"),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildPrevisaoItem(PrevisaoNotificao previsaoNotificao) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Previsão - ${DateFormat("dd/MM/y").format(previsaoNotificao.dataPrevisao)}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          buildGravidade("Gravidade Alta", previsaoNotificao.ruasGravidadeAlta),
          buildGravidade("Gravidade Média", previsaoNotificao.ruasGravidadeMedia),
          buildGravidade("Gravidade Baixa", previsaoNotificao.ruasGravidadeBaixa),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lastWeekNotificationsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsões'),
        backgroundColor: const Color(0xFF0b2351),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: ref.read(lastWeekNotificationsControllerProvider.notifier).refreshLastWeekUpdate,
          ),
        ],
      ),
      body: state.when(
        data: (previsoes) =>
          ListView.builder(
            itemCount: previsoes.length,
            itemBuilder: (context, index) {
              final previsao = previsoes[index];
              return ExpansionTile(
                title: Text(
                  "Data de execução\n${DateFormat("dd/MM/yyyy HH:mm:ss").format(previsao.dataExecucaoPrevisao)}",
                  // "Data de execução\n${previsao.dataExecucaoPrevisao.toIso8601String()}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: previsao.previsoes.map((notificacao) => buildPrevisaoItem(notificacao)).toList(),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Erro ao carregar notificações: $error')),
      )
    );
  }
}
