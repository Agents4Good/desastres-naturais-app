import 'package:aguas_da_borborema/src/app.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await contactService.open();
  runApp(const ProviderScope(child: ChatApp()));
}
