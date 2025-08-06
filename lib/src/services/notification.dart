import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

// Data class to hold all relevant notification information for display
class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    this.title,
    this.body,
    this.payload,
  });
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static final BehaviorSubject<ReceivedNotification> onNotifications =
      BehaviorSubject<ReceivedNotification>();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'Channel_id',
    'Channel_title',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );

  static Future<void> initialize() async {
    // Cria o canal
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Solicita permissão no Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin, // Add for iOS
    );

    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
    );
  }

  static void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    print('Notification tapped (foreground/background): $payload');

    // Emit the full notification details
    onNotifications.add(
      ReceivedNotification(
        id: notificationResponse.id ?? 0, // Fallback to 0 if ID is null
        title: 'Flood Alert',
        body: notificationResponse.payload, // Body is not directly in NotificationResponse for simple tap
        payload: payload,
      ),
    );
  }

  // This callback is invoked on a background isolate when a user taps
  // a notification action, even if the app is terminated.
  @pragma('vm:entry-point') // Required for background isolates
  static void _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    print('Notification tapped (terminated/background isolate): $payload');
    // Note: You generally cannot perform UI navigation or show dialogs directly
    // from a background isolate. You might store the payload and handle it
    // when the app eventually launches.
  }

  // This callback is for iOS only, specifically for when a local notification
  // is received while the app is in the foreground.
  // It provides title, body, and payload directly.
  static Future<void> _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print('Foreground iOS notification received: $payload');
    // Emit the full notification details for iOS foreground
    onNotifications.add(
      ReceivedNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  }

  static Future<void> showNotification(String message, {String? title, String? payload}) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'Channel_id',
      'Channel_title',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(); // For iOS/macOS

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _plugin.show(
      0,
      title,
      message,
      notificationDetails,
      payload: payload
    );
  }

  static Future<NotificationAppLaunchDetails?> getNotificationLaunchDetails() async {
    return await _plugin.getNotificationAppLaunchDetails();
  }
}
