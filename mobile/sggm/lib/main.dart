import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sggm/controllers/escalas_controller.dart';
import 'package:sggm/controllers/eventos_controller.dart';
import 'package:sggm/controllers/musicos_controller.dart';
import 'package:sggm/views/login_page.dart';
import 'home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventoProvider()),
        ChangeNotifierProvider(create: (_) => EscalasProvider()),
        ChangeNotifierProvider(create: (_) => MusicosProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Eventos App',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
