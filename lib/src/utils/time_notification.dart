import 'dart:ui';
import 'dart:async';
import 'package:aguas_da_borborema/src/features/forecast/application/forecast_service.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_forecast.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aguas_da_borborema/src/services/notification.dart';
import 'package:flutter_riverpod/legacy.dart'; // Assuming this is your forecast service


/// This provider is responsible for managing the background timer
/// and triggering the notification check.
final timerServiceProvider = StateNotifierProvider<TimerService, bool>((ref) {
  return TimerService(ref);
});

/// The StateNotifier that handles the timer logic.
class TimerService extends StateNotifier<bool> {
  final Ref _ref;
  Timer? _timer;

  TimerService(this._ref) : super(false) {
    // The timer is started as soon as the provider is created.
    startTimer();

    // Use ref.onDispose to automatically cancel the timer
    // when the provider is no longer in use. This prevents memory leaks.
    _ref.onDispose(() {
      _timer?.cancel();
    });
  }

  void startTimer() {
    const intervalo = Duration(minutes: 4);
    _timer = Timer.periodic(intervalo, (timer) async {
      final locale = window.locale;
      final isEn = locale.languageCode == 'en';
      final forecastService = _ref.read(forecastServiceProvider);
      final tomorrow = DateTime.now().add(const Duration(days: 1));

      // Get data from the provider
      final previsaoCompleta = await forecastService.fetchCurrentPrevisaoCompletaUltimosTresDias(tomorrow);
      final contacts = await contactService.getContacts();

      final contactsString = StringBuffer();
      for (final contact in contacts) {
        // Assuming each contact has a method to check flood risk
        GravidadeAlagamento? risk = contact.alagamentoMaisProximo(previsaoCompleta.previsoes);
        if (risk != null) {
          if (isEn) {
            contactsString.writeln('The contact \'${contact.name}\' runs a risk of ${risk.name} severity');
          } else {
            contactsString.writeln('O contato \'${contact.name}\' corre o risco de ${risk.name} severidade');
          }
        }
      }

      // Your logic to check if a notification should be shown
      if (contactsString.isNotEmpty) {
        // Access the notification service provider to show the notification
        // final notificationService = _ref.read(notificationServiceProvider);
        if (isEn) {
          NotificationService.showNotification('${previsaoCompleta.mensagemAntesEn}\nContacts risk:\n${contactsString.toString()}\n${previsaoCompleta.mensagemDepoisEn}');
        } else {
          NotificationService.showNotification('${previsaoCompleta.mensagemAntesPt}\nRisco dos contatos:\n${contactsString.toString()}\n${previsaoCompleta.mensagemDepoisPt}');
        }
      }
    });
  }
}