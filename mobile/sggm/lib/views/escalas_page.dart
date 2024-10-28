import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sggm/controllers/escalas_controller.dart';
import 'package:sggm/models/escalas.dart';

class EscalasPage extends StatefulWidget {
  const EscalasPage({super.key});

  @override
  State<EscalasPage> createState() => _EscalasPageState();
}

class _EscalasPageState extends State<EscalasPage> {
  late Future<void> _carregarEscalasFuture;

  @override
  void initState() {
    super.initState();
    _carregarEscalasFuture = Provider.of<EscalasProvider>(context, listen: false).listarEscalas();
  }

  @override
  Widget build(BuildContext context) {
    final escalaProvider = Provider.of<EscalasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escalas'),
      ),
      body: FutureBuilder(
        future: _carregarEscalasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: escalaProvider.escalas.length,
            itemBuilder: (context, index) {
              final escala = escalaProvider.escalas[index];
              return ListTile(
                title: Text(escala.musico.toString()),
                subtitle: Text(escala.evento.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    escalaProvider.deletarEvento(escala.escalaId!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final novaEscala = Escalas(
            escalaId: escalaProvider.escalas.length + 1,
            dataEscala: DateTime.now().toString(),
            // musico: 'Novo Evento',
            // evento: 'Local Teste',
          );
          escalaProvider.adicionarEvento(novaEscala);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
