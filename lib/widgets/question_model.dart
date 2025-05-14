import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Map<String, dynamic> question;
  final Function(String) onAnswerChanged;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question['question'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildInputField(),
      ],
    );
  }

  Widget _buildInputField() {
    switch (question['type']) {
      case 'text':
        return TextFormField(
          onChanged: onAnswerChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Digite sua resposta',
          ),
        );
      case 'multiple_choice':
        return Column(
          children: (question['options'] as List<String>)
              .map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: question['answer'],
                    onChanged: (value) => onAnswerChanged(value ?? ''),
                  ))
              .toList(),
        );
      default:
        return const Text('Tipo de pergunta não suportado');
    }
  }
}