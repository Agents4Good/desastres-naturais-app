import 'package:aguas_da_borborema/src/app.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:aguas_da_borborema/src/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:aguas_da_borborema/src/services/notification.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:aguas_da_borborema/src/utils/time_notification.dart';

Future<void> startBackgroundService() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Aguas da Borborema",
    notificationText: "Rodando em segundo plano",
    notificationImportance: AndroidNotificationImportance.max,
    enableWifiLock: true,
  );

  // var hasPermissions = await FlutterBackground.hasPermissions;
  // if (!hasPermissions) {
    
  // }
  var hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
  if(hasPermissions) {
    await FlutterBackground.enableBackgroundExecution();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startBackgroundService();

  await contactService.open();  
  await NotificationService.initialize();

  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(
    child: ChatAppWrapper()
  ));
}

// Update ChatApp to listen to the new provider
class ChatAppWrapper extends ConsumerWidget {
  const ChatAppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This line is crucial. By watching the timerServiceProvider,
    // we ensure it is created and kept alive throughout the app's lifecycle.
    // The state value is not used, but the side effect (the timer) runs.
    final _ = ref.watch(timerServiceProvider);

    return const ChatApp();
  }
}