import 'package:pluvia/src/app.dart';
import 'package:pluvia/src/services/contacts_service.dart';
import 'package:pluvia/src/services/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pluvia/src/services/notification.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:pluvia/src/utils/time_notification.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> startBackgroundService() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Aguas da Borborema",
    notificationText: "Rodando em segundo plano",
    notificationImportance: AndroidNotificationImportance.max,
    enableWifiLock: true,
  );

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

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  
  // Check if the app was launched by a notification when it was terminated
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await NotificationService.getNotificationLaunchDetails();

  ReceivedNotification? initialNotification;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final response = notificationAppLaunchDetails!.notificationResponse;
    if (response != null) {
      initialNotification = ReceivedNotification(
        id: response.id ?? 0,
        title: response.payload,
        body: null,
        payload: response.payload,
      );
      if (kDebugMode) {
        print('App launched via notification with payload: ${initialNotification.payload}');
      }
    }
  }

  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(
    child: ChatAppWrapper()
  ));
}

// Update ChatApp to listen to the new provider
class ChatAppWrapper extends ConsumerStatefulWidget {
  final ReceivedNotification? initialNotification;

  const ChatAppWrapper({
    super.key,
    this.initialNotification,
  });

  @override
  ConsumerState<ChatAppWrapper> createState() => _ChatAppWrapperState();
}

class _ChatAppWrapperState extends ConsumerState<ChatAppWrapper> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure context is available for dialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialNotification();
    });
    _listenForNotifications();
  }

  void _handleInitialNotification() {
    if (widget.initialNotification != null) {
      _showNotificationDialog(widget.initialNotification!);
    }
  }

  void _listenForNotifications() {
    // Listen for notification taps when the app is in the foreground/background
    NotificationService.onNotifications.listen((notification) {
      print('Received notification tap in UI stream: ${notification.payload}');
      _showNotificationDialog(notification);
    });
  }

  void _showNotificationDialog(ReceivedNotification notification) {
    if (navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
        context: navigatorKey.currentState!.overlay!.context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(notification.title ?? 'N/A'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(notification.payload ?? 'N/A'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(timerServiceProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const ChatApp(),
    );
  }
}