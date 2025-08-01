import 'dart:async';
import 'package:aguas_da_borborema/src/services/notification.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> checarDB() async {
  try {
    final response = await http.get(Uri.parse('http://IP_DO_SERVIDOR:PORTA/api/notificacoes'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> notificacoes = data as List<dynamic>;

      return notificacoes.isNotEmpty;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}




Timer? _timer;

void iniciarTimerNotificacao() {
  const intervalo = Duration(minutes: 15);

  _timer = Timer.periodic(intervalo, (timer) async {
    final deposito = await checarDB();

    if (deposito) {
      await NotificationService.showNotification();
    }
  });
}