import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(String) onChanged;
  final VoidCallback onDelete;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: question.question,
                    decoration: const InputDecoration(
                      labelText: 'Pergunta',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => question.question = value,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    switch (question.type) {
      case 'text':
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Resposta',
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
        );
      case 'multiple_choice':
        return Column(
          children: [
            ...?question.options?.map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: question.answer,
                  onChanged: (value) => onChanged(value ?? ''),
                )),
            TextButton(
              child: const Text('+ Adicionar Opção'),
              onPressed: () {},
            ),
          ],
        );
      default:
        return const Text('Tipo de pergunta não suportado');
    }
  }
}