import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FormCard({
    super.key,
    required this.title,
    required this.date,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text("Criado em: $date"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}