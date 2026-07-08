import 'package:app_examen/Provider/provider_genero.dart';
import 'package:app_examen/Provider/provider_login.dart';
import 'package:app_examen/Provider/provider_paciente.dart';
import 'package:app_examen/Screens/dashboard_screen.dart';
import 'package:app_examen/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(create: (_) => ProviderGenero()),
        ChangeNotifierProvider(create: (_) => ProviderPaciente()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderLogin>(
      builder: (context, authProvider, _) {
        if (authProvider.token != null) {
          return DashboardScreen(); // Tu pantalla principal
        } else {
          return LoginScreen(); // Tu pantalla de Login
        }
      },
    );
  }
}
