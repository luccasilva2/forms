class Question {
  final String id;
  final String type;
  String question;
  List<String>? options;
  String answer;

  Question({
    required this.id,
    required this.type,
    required this.question,
    this.options,
    this.answer = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }
}