import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sggm/controllers/eventos_controller.dart';
import 'package:sggm/models/eventos.dart';

class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  late Future<void> _carregarEventosFuture;

  @override
  void initState() {
    super.initState();
    _carregarEventosFuture = Provider.of<EventoProvider>(context, listen: false).listarEventos();
  }

  @override
  Widget build(BuildContext context) {
    final eventoProvider = Provider.of<EventoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
      ),
      body: FutureBuilder(
        future: _carregarEventosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: eventoProvider.eventos.length,
            itemBuilder: (context, index) {
              final evento = eventoProvider.eventos[index];
              return ListTile(
                title: Text(evento.nome!),
                subtitle: Text(evento.descricao!),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    eventoProvider.deletarEvento(evento.eventoId!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final novoEvento = Eventos(
            nome: 'Novo Evento',
            dataEvento: DateTime.now().toString(),
            local: 'Local Teste',
            descricao: 'Descrição Teste',
          );
          eventoProvider.adicionarEvento(novoEvento);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
