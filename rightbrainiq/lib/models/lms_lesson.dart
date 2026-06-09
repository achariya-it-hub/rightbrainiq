class LmsLesson {
  final String id;
  final String title;
  final String type;
  final int cardCount;
  final List<FlashcardData> cards;

  const LmsLesson({
    required this.id,
    required this.title,
    this.type = 'flashcard',
    this.cardCount = 0,
    this.cards = const [],
  });
}

class FlashcardData {
  final String question;
  final String answer;

  const FlashcardData({required this.question, required this.answer});
}
