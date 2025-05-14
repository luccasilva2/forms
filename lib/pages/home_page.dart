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
        itemCount: 5, // Mock de formulários
        itemBuilder: (context, index) {
          return FormCard(
            title: "Formulário ${index + 1}",
            date: "10/0${index + 1}/2023",
            onEdit: () => print("Editar $index"),
            onDelete: () => print("Excluir $index"),
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
}