import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/services/note_firebase_service.dart';
import 'package:note/widgets/popup/note_widget_alerttext_buton.dart';

class NoteMessagePage extends StatefulWidget {
  const NoteMessagePage({
    super.key,
    required this.onSave,
    required this.id,
    required this.notContentController,
    required this.notTitleController,
  });

  final void Function(NoteGeneralContent, Color) onSave;
  final String id; // `int` yerine `String`
  final QuillController notContentController;
  final TextEditingController notTitleController;

  @override
  State<NoteMessagePage> createState() => _NoteMessagePageState();
}

class _NoteMessagePageState extends State<NoteMessagePage> {
  Color? _listBackgroundColor;
  final FirebaseService _firebaseService = FirebaseService(); // FirebaseService instance

  @override
  void initState() {
    super.initState();
    _listBackgroundColor = Colors.white;
    widget.notContentController.addListener(_preserveTextColor);
    print('NoteMessagePage initialized with document: ${widget.notContentController.document.toPlainText()}');
  }

  @override
  void dispose() {
    widget.notContentController.removeListener(_preserveTextColor);
    super.dispose();
  }

  void _preserveTextColor() {
    final attrs = widget.notContentController.getSelectionStyle().attributes;
    if (!attrs.containsKey(Attribute.color.key) || attrs[Attribute.color.key]?.value != '#FFFFFF') {
      widget.notContentController.formatSelection(Attribute.fromKeyValue('color', '#FFFFFF'));
    }
  }

  void _toggleAttribute(Attribute attribute) {
    final isAttributeToggled = widget.notContentController.getSelectionStyle().containsKey(attribute.key);
    if (isAttributeToggled) {
      widget.notContentController.formatSelection(Attribute.clone(attribute, null));
    } else {
      widget.notContentController.formatSelection(attribute);
    }
  }

  void _toggleList() {
    final attrs = widget.notContentController.getSelectionStyle().attributes;
    if (attrs.containsKey(Attribute.list.key)) {
      widget.notContentController.formatSelection(Attribute.clone(Attribute.list, null));
    } else {
      widget.notContentController.formatSelection(Attribute.ul);
      final textColor =
          ThemeData.estimateBrightnessForColor(NoteColors.darkBgColor) == Brightness.light ? '#000000' : '#FFFFFF';
      widget.notContentController.formatSelection(Attribute.fromKeyValue('color', textColor));
    }
  }

  void saveButton() {
    final noteContent = NoteGeneralContent(
      id: widget.id,
      messageTitle: widget.notTitleController.text,
      messageContent: jsonEncode(widget.notContentController.document.toDelta().toJson()),
      noteColor: _listBackgroundColor,
    );
    print('Pop id: ${widget.id}');

    // Save note to Firebase using FirebaseService instance
    _firebaseService.saveNote(noteContent);

    widget.onSave(noteContent, _listBackgroundColor ?? Colors.white);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: NoteColors.darkBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NoteColors.darkBgColor,
        foregroundColor: NoteColors.whiteColor,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(NoteStrings.appCreateAlrDtlTxt),
            const SizedBox(width: 10),
            DropdownButton<Color>(
              icon: Icon(Icons.color_lens, color: NoteColors.whiteColor),
              underline: Container(),
              items: NoteColors.rainbowColors.map((color) {
                return DropdownMenuItem<Color>(
                  value: color,
                  child: Container(
                    width: 24,
                    height: 24,
                    color: color,
                  ),
                );
              }).toList(),
              onChanged: (Color? newColor) {
                if (newColor != null) {
                  setState(() {
                    _listBackgroundColor = newColor;
                  });
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 32.0),
        child: Column(
          children: [
            TextField(
              controller: widget.notTitleController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: NoteStrings.appAlrtDlgTitlHnt,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(50, 83, 81, 81), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(50, 83, 81, 81), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: (0.299 * NoteColors.darkBgColor.red +
                              0.587 * NoteColors.darkBgColor.green +
                              0.114 * NoteColors.darkBgColor.blue) >
                          128
                      ? Colors.black
                      : Colors.white30,
                ),
              ),
              style: TextStyle(
                color: (0.299 * NoteColors.darkBgColor.red +
                            0.587 * NoteColors.darkBgColor.green +
                            0.114 * NoteColors.darkBgColor.blue) >
                        128
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            SizedBox(
              height: isSmallScreen ? 10.0 : 16.0,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: ThemeData.estimateBrightnessForColor(NoteColors.darkBgColor) == Brightness.light
                      ? NoteColors.whiteColor
                      : NoteColors.darkBgColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    customStyles: DefaultStyles(
                      color: (0.299 * NoteColors.darkBgColor.red +
                                  0.587 * NoteColors.darkBgColor.green +
                                  0.114 * NoteColors.darkBgColor.blue) >
                              128
                          ? Colors.black
                          : Colors.white,
                      paragraph: DefaultTextBlockStyle(
                        TextStyle(
                            color: (0.299 * NoteColors.darkBgColor.red +
                                        0.587 * NoteColors.darkBgColor.green +
                                        0.114 * NoteColors.darkBgColor.blue) >
                                    128
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20),
                        const VerticalSpacing(5, 5),
                        const VerticalSpacing(5, 5),
                        null,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    placeholder: NoteStrings.appAlrtDlgSbjHnt,
                    scrollable: true,
                    autoFocus: true,
                    expands: false,
                    elementOptions: const QuillEditorElementOptions(
                      unorderedList: QuillEditorUnOrderedListElementOptions(
                        useTextColorForDot: false,
                        customWidget: Text(
                          '•',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    textSelectionThemeData: const TextSelectionThemeData(),
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('de'),
                    ),
                    controller: widget.notContentController,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomQuillToolbar(
              controller: widget.notContentController,
              toggleAttribute: _toggleAttribute,
              toggleList: _toggleList,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: NoteWidgetAlertTextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    alertBgColor: NoteColors.redColor,
                    alertTxtColor: NoteColors.whiteColor,
                    alertText: NoteStrings.appAlrtBtnDcTxt,
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8.0 : 32.0),
                Expanded(
                  child: NoteWidgetAlertTextButton(
                    onPressed: saveButton,
                    alertBgColor: NoteColors.greenColor,
                    alertTxtColor: NoteColors.whiteColor,
                    alertText: NoteStrings.appAlrtBtnSvTxt,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomQuillToolbar extends StatelessWidget {
  final QuillController controller;
  final void Function(Attribute attribute) toggleAttribute;
  final VoidCallback toggleList;

  const CustomQuillToolbar({
    super.key,
    required this.controller,
    required this.toggleAttribute,
    required this.toggleList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NoteColors.darkBgColor,
      child: QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
          controller: controller,
          showBoldButton: false,
          showItalicButton: false,
          showStrikeThrough: false,
          showListBullets: false,
          showListNumbers: false,
          showCodeBlock: false,
          showQuote: false,
          showLink: false,
          showClearFormat: false,
          showColorButton: false,
          showBackgroundColorButton: false,
          showUnderLineButton: false,
          showHeaderStyle: false,
          showIndent: false,
          showListCheck: false,
          showFontSize: false,
          showFontFamily: false,
          showSubscript: false,
          showSuperscript: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showLeftAlignment: false,
          showCenterAlignment: false,
          showRightAlignment: false,
          showJustifyAlignment: false,
          showDirection: false,
          showSearchButton: false,
          showRedo: false,
          showUndo: false,
          showSmallButton: false,
          showDividers: false,
          showClipboardCopy: false,
          showClipboardCut: false,
          showClipboardPaste: false,
          customButtons: [
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_bold,
                  fillColor: NoteColors.darkBgColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: () {
                    toggleAttribute(Attribute.bold);
                  },
                );
              },
            ),
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_italic,
                  fillColor: NoteColors.darkBgColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: () {
                    toggleAttribute(Attribute.italic);
                  },
                );
              },
            ),
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_underline,
                  fillColor: NoteColors.darkBgColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: () {
                    toggleAttribute(Attribute.underline);
                  },
                );
              },
            ),
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_list_bulleted,
                  fillColor: NoteColors.whiteColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: toggleList,
                );
              },
            ),
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_align_left,
                  fillColor: NoteColors.whiteColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: () {
                    toggleAttribute(Attribute.leftAlignment);
                  },
                );
              },
            ),
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_align_center,
                  fillColor: NoteColors.whiteColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: () {
                    toggleAttribute(Attribute.centerAlignment);
                  },
                );
              },
            ),
            QuillToolbarCustomButtonOptions(
              childBuilder: (options, extraOptions) {
                return QuillCustomButton(
                  icon: Icons.format_align_right,
                  fillColor: NoteColors.whiteColor,
                  iconColor: NoteColors.whiteColor,
                  onPressed: () {
                    toggleAttribute(Attribute.rightAlignment);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuillCustomButton extends StatelessWidget {
  final IconData icon;
  final Color fillColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const QuillCustomButton({
    super.key,
    required this.icon,
    required this.fillColor,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      style: const ButtonStyle(),
      color: iconColor,
      onPressed: onPressed,
      tooltip: '',
      padding: const EdgeInsets.all(8.0),
      splashRadius: 24.0,
      iconSize: 24.0,
    );
  }
}
