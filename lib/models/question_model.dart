
class Question {
  final String id;
  final String type; // 'text', 'multiple_choice', 'checkbox'
  final String question;
  final List<String>? options;
  String answer;

  Question({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.answer = '',
  });
}