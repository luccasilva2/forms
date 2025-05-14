import 'package:flutter/material.dart';
import 'create_form_page.dart';
import '../widgets/form_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Formulários'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return FormCard(
            title: "Formulário ${index + 1}",
            date: "10/0${index + 1}/2023",
            onEdit: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateFormPage()),
            ),
            onDelete: () => _showDeleteDialog(context),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Formulário'),
        content: const Text('Tem certeza que deseja excluir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Formulário excluído!')),
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}