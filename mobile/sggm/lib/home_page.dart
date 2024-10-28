import 'package:flutter/material.dart';
import 'package:sggm/views/escalas_page.dart';
import 'package:sggm/views/eventos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SGGM'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (bc) => const EventosPage())),
            child: const Text('Eventos'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (bc) => const EscalasPage())),
            child: const Text('Escalas'),
          ),
        ],
      )),
    );
  }
}
