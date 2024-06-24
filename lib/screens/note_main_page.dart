import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/screens/note_message_page.dart';
import 'package:note/services/note_firebase_service.dart';
import 'package:note/widgets/main/note_widget_floataction.dart';
import 'package:note/widgets/main/note_widget_show_before_delete.dart';
import 'package:note/widgets/common/note_widget_custom_iconbutton.dart';
import 'package:note/widgets/main/note_widget_showModelBottomSheet.dart';
import 'package:note/widgets/notelist/note_widget_list.dart';

class NoteMainPage extends StatefulWidget {
  NoteMainPage({super.key});
  final List<NoteGeneralContent> messages = [];
  final Map<String, Color> messageColors = {}; // Map keys should be String
  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
  final FirebaseService _firebaseService = FirebaseService(); // Initialize FirebaseService
  TextEditingController searchController = TextEditingController();
  List<NoteGeneralContent> filteredMessages = [];
  Color _listBackgroundColor = Colors.white; // Default background color

  // Title and content controllers
  TextEditingController notTitleController = TextEditingController();
  QuillController notContentController = QuillController.basic();

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Fetch notes when the page initializes
  }

  Future<void> _fetchNotes() async {
    try {
      List<NoteGeneralContent> notes = await _firebaseService.fetchNotes();
      print("Fetched notes: $notes"); // Debugging line
      setState(() {
        widget.messages.addAll(notes);
        for (var note in notes) {
          widget.messageColors[note.id] = note.noteColor ?? Colors.white;
        }
        filteredMessages = List.from(widget.messages);
      });
    } catch (e) {
      print('Error fetching notes: $e'); // Debugging line
    }
  }

  String _generateUniqueId() {
    // Firestore'un benzersiz ID'sini oluştur
    return _firebaseService.firestore.collection('notes').doc().id; // Getter kullanıldı
  }

  void _alertCreateNotPressed() {
    try {
      notTitleController.clear();

      // Safely reset the QuillController by reinitializing it with an empty document
      setState(() {
        notContentController = QuillController(
          document: Document(),
          selection: const TextSelection.collapsed(offset: 0),
        );
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteMessagePage(
            id: _generateUniqueId(),
            onSave: _saveText,
            notContentController: notContentController,
            notTitleController: notTitleController,
          ),
        ),
      ); // Burada .then bloğunu kaldırdık
    } catch (error) {
      print('Error occurred in _alertCreateNotPressed: $error');
    }
  }

  void _saveText(NoteGeneralContent noteContent, Color backgroundColor) {
    setState(() {
      final noteWithId = NoteGeneralContent(
        id: noteContent.id, // Zaten oluşturulmuş ID'yi kullanıyoruz
        messageTitle: noteContent.messageTitle,
        messageContent: noteContent.messageContent,
        noteColor: backgroundColor, // Set the background color
      );
      widget.messages.add(noteWithId);
      widget.messageColors[noteWithId.id] = backgroundColor;
      _listBackgroundColor = backgroundColor; // Set the list background color
      _filterMessages(searchController.text);
      _firebaseService.saveNote(noteWithId); // Save the note to Firebase
    });
  }

  void _onSave(String id, NoteGeneralContent editedContent, Color color) {
    setState(() {
      int index = widget.messages.indexWhere((element) => element.id == id);
      if (index != -1) {
        // Ensure that the title is updated correctly
        widget.messages[index] = NoteGeneralContent(
          id: id,
          messageTitle: editedContent.messageTitle,
          messageContent: editedContent.messageContent,
          noteColor: color,
        );
        widget.messageColors[id] = color;
        _firebaseService.saveNote(widget.messages[index]); // Update the note in Firebase
      }
    });
  }

  void _showListTileDetails(NoteGeneralContent noteContent) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NoteShowModelDetails(
          onPressed: () {
            Navigator.pop(context); // Close the details modal
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return NoteWidgetBeforeDelete(
                  onDelete: () {
                    setState(() {
                      int indexToDelete = widget.messages.indexOf(noteContent);
                      if (indexToDelete != -1) {
                        widget.messages.removeAt(indexToDelete);
                        widget.messageColors.remove(noteContent.id);
                        _filterMessages(searchController.text);
                        _firebaseService.deleteNote(noteContent.id); // Delete the note from Firebase
                      }
                      Navigator.pop(context);
                    });
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _filterMessages(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredMessages = List.from(widget.messages);
      });
    } else {
      setState(() {
        filteredMessages = widget.messages.where((message) {
          final titleMatches = message.messageTitle.toLowerCase().contains(query.toLowerCase());

          // Parse the Quill Delta JSON to a list of operations
          final document = Document.fromJson(jsonDecode(message.messageContent));
          final plainText = document.toPlainText();
          final contentMatches = plainText.toLowerCase().contains(query.toLowerCase());

          return titleMatches || contentMatches;
        }).toList();
      });
    }
  }

  bool isSearchExpanded = false;

  void toggleSearchBar() {
    setState(() {
      if (searchController.text.isNotEmpty) {
        searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSearchExpanded) {
          setState(() {
            isSearchExpanded = false;
            searchController.clear();
            _filterMessages('');
          });
        }
      },
      child: Scaffold(
        backgroundColor: NoteColors.darkBgColor,
        appBar: AppBar(
          title: isSearchExpanded
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: NoteColors.whiteColor),
                          controller: searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: NoteColors.whiteColor),
                            hintText: 'Search...',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 15),
                          ),
                          onSubmitted: (value) {
                            toggleSearchBar();
                          },
                          onChanged: (value) {
                            _filterMessages(value);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  NoteStrings.appTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: NoteColors.whiteColor,
                        fontSize: NoteFont.fontSizeThirtySix,
                      ),
                ),
          actions: isSearchExpanded
              ? [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    style: TextButton.styleFrom(
                      iconColor: NoteColors.whiteColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSearchExpanded = false;
                        searchController.clear();
                        _filterMessages('');
                      });
                    },
                  ),
                ]
              : [
                  NoteWidgetCustomIconButton(
                    iconButton: Icons.search,
                    onPressed: () {
                      setState(() {
                        isSearchExpanded = true;
                      });
                    },
                  ),
                  NoteWidgetCustomIconButton(
                    iconButton: Icons.info,
                    onPressed: () {},
                  ),
                ],
          backgroundColor: NoteColors.darkBgColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: NoteWidgetGridView(
            messages: filteredMessages,
            messageColors: widget.messageColors,
            onLongPress: _showListTileDetails,
          ),
        ),
        floatingActionButton: NoteWidgetFloatingAction(
          onPressed: _alertCreateNotPressed,
        ),
      ),
    );
  }
}
