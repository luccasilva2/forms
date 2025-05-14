import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';
import '../services/firebase_service.dart';
import '../widgets/question_widget.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({super.key});

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPublic = false;
  List<Question> _questions = [];

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Formulário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título do Formulário',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Formulário Público'),
                  subtitle: const Text('Visível para todos os usuários'),
                  value: _isPublic,
                  onChanged: (value) => setState(() => _isPublic = value),
                ),
                const Divider(height: 32),
                const Text(
                  'Perguntas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ..._questions.map((question) => QuestionWidget(
                      question: question,
                      onChanged: (value) => question.answer = value,
                      onDelete: () => _removeQuestion(question.id),
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.short_text),
                      label: const Text('Texto'),
                      onPressed: () => _addQuestion('text'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.radio_button_checked),
                      label: const Text('Múltipla Escolha'),
                      onPressed: () => _addQuestion('multiple_choice'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addQuestion(String type) {
    setState(() {
      _questions.add(Question(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        question: 'Nova pergunta',
        options: type == 'multiple_choice' ? ['Opção 1', 'Opção 2'] : null,
      ));
    });
  }

  void _removeQuestion(String id) {
    setState(() {
      _questions.removeWhere((q) => q.id == id);
    });
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate() && _questions.isNotEmpty) {
      try {
        await Provider.of<FirebaseService>(context, listen: false).createForm(
          title: _titleController.text,
          description: _descriptionController.text,
          isPublic: _isPublic,
          questions: _questions.map((q) => q.toMap()).toList(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulário salvo com sucesso!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Adicione pelo menos uma pergunta para salvar')),
      );
    }
  }
}