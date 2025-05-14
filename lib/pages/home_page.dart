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
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: 5, // Isso futuramente virá de um banco (Firebase, por ex.)
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final formTitle = "Formulário ${index + 1}";
            final formDate = "10/0${index + 1}/2023";

            return FormCard(
              title: formTitle,
              date: formDate,
              onEdit: () => _navigateToCreateForm(context),
              onDelete: () => _showDeleteDialog(context, formTitle),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateForm(context),
        tooltip: 'Criar novo formulário',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateFormPage()),
    );
  }

  void _showDeleteDialog(BuildContext context, String formTitle) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Formulário'),
        content: Text('Tem certeza que deseja excluir "$formTitle"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('"$formTitle" foi excluído.')),
              );
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
