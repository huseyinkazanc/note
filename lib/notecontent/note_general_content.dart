import 'dart:ui';

class NoteGeneralContent {
  final String id;
  String messageTitle;
  String messageContent;
  Color? noteColor; // Eklenen alan

  NoteGeneralContent({
    required this.id,
    required this.messageTitle,
    required this.messageContent,
    this.noteColor, // Renk alanı opsionel olarak tanımlandı
  });
}
