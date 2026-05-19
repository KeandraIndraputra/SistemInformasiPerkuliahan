import 'dart:io';
import 'package:flutter/material.dart';

// 🔥 SQLite FFI (desktop)
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// 🔥 WAJIB biar sqlite3.dll ke-load (fix error kamu)
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

// 🔗 Screens
import 'login_screen.dart';
import 'dashboard_screen.dart';
import 'create_account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ INIT SQLITE UNTUK DESKTOP
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Portal',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/create': (context) => const CreateAccountScreen(),
      },
    );
  }
}