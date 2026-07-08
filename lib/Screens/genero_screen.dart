import 'package:app_examen/Modelos/genero.dart';
import 'package:app_examen/Provider/provider_genero.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneroScreen extends StatefulWidget {
  const GeneroScreen({super.key});

  @override
  State<GeneroScreen> createState() => _GeneroScreenState();
}

class _GeneroScreenState extends State<GeneroScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar datos al entrar a la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProviderGenero>().cargarGeneros();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gestión de Géneros")),
      body: Consumer<ProviderGenero>(
        builder: (context, provider, child) {
          if (provider.isLoading)
            return Center(child: CircularProgressIndicator());

          if (provider.generos.isEmpty)
            return Center(child: Text("No hay géneros registrados."));

          return ListView.builder(
            itemCount: provider.generos.length,
            itemBuilder: (context, index) {
              final genero = provider.generos[index];
              return Card(
                child: ListTile(
                  title: Text(genero.descripcion), // Ajusta según tu modelo
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () =>
                            _abrirFormulario(context, genero: genero),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => provider.eliminarGenero(genero.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _abrirFormulario(context),
      ),
    );
  }

  // Método para abrir un formulario (Dialog o Nueva Pantalla)
  // En tu pantalla (ListaGenerosScreen o ListaPacientesScreen)
  void _abrirFormulario(BuildContext context, {Genero? genero}) {
    final controller = TextEditingController(text: genero?.descripcion ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(genero == null ? "Agregar" : "Editar"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: "Nombre"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              final nuevo = Genero(
                id: genero?.id ?? 0,
                descripcion: controller.text,
              );
              if (genero == null) {
                await context.read<ProviderGenero>().guardarGenero(nuevo);
              } else {
                await context.read<ProviderGenero>().actualizarGenero(nuevo);
              }
              Navigator.pop(context);
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
