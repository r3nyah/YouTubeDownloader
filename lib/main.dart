import 'package:flutter/material.dart';
import 'Src/Service/Model/Notification.dart';
import 'Src/Screen/Page/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.intialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Youtube Downloader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Home(),
    );
  }
}
