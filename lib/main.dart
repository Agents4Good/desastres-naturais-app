import 'package:aguas_da_borborema/src/app.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aguas_da_borborema/src/services/notification.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:aguas_da_borborema/src/utils/time_notification.dart';

Future<void> startBackgroundService() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Aguas da Borborema",
    notificationText: "Rodando em segundo plano",
    notificationImportance: AndroidNotificationImportance.max,
    enableWifiLock: true,
  );

  final hasPermissions = await FlutterBackground.hasPermissions;
  if (!hasPermissions) {
    await FlutterBackground.initialize(androidConfig: androidConfig);
  }

  await FlutterBackground.enableBackgroundExecution();
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startBackgroundService();

  await contactService.open();  
  await NotificationService.initialize();
  iniciarTimerNotificacao();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(
    child: ChatApp()
  ));
}
