import 'package:aguas_da_borborema/src/features/notifications/presentation/last_week_notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:aguas_da_borborema/l10n/app_localizations.dart';

class NotificacoesScreen extends ConsumerWidget {
  const NotificacoesScreen({super.key});

  Widget buildGravidade(BuildContext context, String label, List<String> ruas) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (ruas.isNotEmpty)
          ...ruas.map((rua) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("- $rua"),
              )),
        if (ruas.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(l10n.noStreetsWithSeverity(label)),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildPrevisaoItem(BuildContext context, PrevisaoNotificao previsao) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat(l10n.dateFormatUpToDay).format(previsao.dataPrevisao);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.forecastItemTitle(dateStr),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          buildGravidade(context, l10n.severityHigh, previsao.ruasGravidadeAlta),
          buildGravidade(context, l10n.severityMedium, previsao.ruasGravidadeMedia),
          buildGravidade(context, l10n.severityLow, previsao.ruasGravidadeBaixa),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(lastWeekNotificationsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationsScreenTitle),
        backgroundColor: const Color(0xFF0b2351),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: ref.read(lastWeekNotificationsControllerProvider.notifier)
                           .refreshLastWeekUpdate,
          ),
        ],
      ),
      body: state.when(
        data: (previsoes) => ListView.builder(
          itemCount: previsoes.length,
          itemBuilder: (context, index) {
            final previsao = previsoes[index];
            final execDate = DateFormat("dd/MM/yyyy HH:mm:ss")
                .format(previsao.dataExecucaoPrevisao);
            return ExpansionTile(
              title: Text(
                l10n.executionDate(execDate),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: previsao.previsoes
                  .map((notificacao) => buildPrevisaoItem(context, notificacao))
                  .toList(),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text(l10n.notificationsError(error.toString()))),
      ),
    );
  }
}
