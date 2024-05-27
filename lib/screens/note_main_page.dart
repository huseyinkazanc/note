import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/screens/note_message_page.dart';
import 'package:note/widgets/createNot/note_widget_create.dart';
import 'package:note/widgets/main/note_widget_floataction.dart';
import 'package:note/widgets/main/note_widget_show_before_delete.dart';
import 'package:note/widgets/notelist/note_widget_list.dart';
import 'package:note/widgets/common/note_widget_custom_iconbutton.dart';
import 'package:note/widgets/popup/note_widget_popUp.dart';
import 'package:note/widgets/main/note_widget_showModelBottomSheet.dart';

class NoteMainPage extends StatefulWidget {
  NoteMainPage({super.key});
  final List<NoteGeneralContent> messages = [];
  final Map<int, Color> messageColors = {};
  @override
  State<NoteMainPage> createState() => _NoteMainPageState();
}

class _NoteMainPageState extends State<NoteMainPage> {
  TextEditingController searchController = TextEditingController();
  List<NoteGeneralContent> filteredMessages = [];
  int _listId = 0;

  void _alertCreateNotPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context); // Close the dialog when tapped outside
          },
          child: NoteWidgetCreateNot(
            alertDialogQuckNotePressed: _alertDialogPressed,
            alertDialogDtlkNotePressed: alertDialogDtlkNotePressed,
          ),
        );
      },
    );
  }

  void alertDialogDtlkNotePressed() async {
    notTitleController.clear();
    notContentController.clear();

    Navigator.pop(context);

    final result = await showDialog<NoteGeneralContent>(
      context: context,
      builder: (context) => NoteMessagePage(
        id: _listId,
        onSave: _saveText,
      ),
    );
    if (result != null) {
      _saveText(result);
    }
  }

  void _alertDialogPressed() async {
    popTitleController.clear();
    popExplainController.clear();
    Navigator.pop(context);

    final result = await showDialog<NoteGeneralContent>(
      context: context,
      builder: (context) => NoteWidgetPopUp(
        id: _listId,
        onSave: _saveText,
      ),
    );
    if (result != null) {
      _saveText(result);
    }
  }

  void _saveText(NoteGeneralContent noteContent, [Color? backgroundColor]) {
    setState(() {
      //final randomColor = NoteColors.rainbowColors[widget.messages.length % NoteColors.rainbowColors.length];
      final id = _listId++;
      final noteWithId = NoteGeneralContent(
        id: id,
        messageTitle: noteContent.messageTitle,
        messageContent: noteContent.messageContent,
      );
      widget.messages.add(noteWithId);
      widget.messageColors[noteContent.id] = backgroundColor!;
      // Update filtered messages based on search query
      _filterMessages(searchController.text);
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
                      // Find the index of the note to be deleted
                      int indexToDelete = widget.messages.indexOf(noteContent);
                      if (indexToDelete != -1) {
                        // Remove the note at the found index
                        widget.messages.removeAt(indexToDelete);

                        // Remove the message's color from the map
                        widget.messageColors.remove(noteContent.messageTitle);

                        // Update filtered messages based on search query
                        _filterMessages(searchController.text);
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

    print('After deleting note: $noteContent');
  }

  // Filter messages based on search query
  void _filterMessages(String query) {
    if (query.isEmpty) {
      // If query is empty, display all messages
      setState(() {
        filteredMessages = List.from(widget.messages);
      });
    } else {
      // Filter messages based on search query
      setState(() {
        filteredMessages = widget.messages
            .where((message) => message.messageTitle.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }

    print('Filtered Messages: $filteredMessages');
  }

  bool isSearchExpanded = false;
  // Toggle search bar
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
        // Collapse search bar when tapping anywhere on the page
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
                            toggleSearchBar(); // Collapse the search bar after search
                          },
                          onChanged: (value) {
                            _filterMessages(value); // Filter messages as user types
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
                        isSearchExpanded = true; // Open search field
                      });
                    },
                  ),
                  NoteWidgetCustomIconButton(iconButton: Icons.info, onPressed: () {}),
                ],
          backgroundColor: NoteColors.darkBgColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: NoteWidgetGridView(
            messages: filteredMessages, // Display filtered messages
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
