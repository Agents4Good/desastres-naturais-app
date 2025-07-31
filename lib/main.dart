import 'package:aguas_da_borborema/src/app.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aguas_da_borborema/src/services/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await contactService.open();  
  await NotificationService.initialize();
  await NotificationService.showTestNotification();
  //await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(
    child: ChatApp()
  ));
}
