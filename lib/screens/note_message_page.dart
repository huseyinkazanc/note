import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/notecontent/note_general_content.dart';
import 'package:note/widgets/popup/note_widget_alerttext_buton.dart';

class NoteMessagePage extends StatefulWidget {
  const NoteMessagePage({super.key, required this.onSave, required this.id});

  final void Function(NoteGeneralContent, Color) onSave;
  final int id;

  @override
  State<NoteMessagePage> createState() => _NoteMessagePageState();
}

final TextEditingController notTitleController = TextEditingController();
final QuillController notContentController = QuillController.basic();

class _NoteMessagePageState extends State<NoteMessagePage> {
  final Color _backGroundColor = NoteColors.darkBgColor;

  @override
  void initState() {
    super.initState();
    notContentController.addListener(_preserveTextColor);
  }

  @override
  void dispose() {
    notContentController.removeListener(_preserveTextColor);
    notContentController.dispose();
    super.dispose();
  }

  void _preserveTextColor() {
    final attrs = notContentController.getSelectionStyle().attributes;
    if (!attrs.containsKey(Attribute.color.key) || attrs[Attribute.color.key]?.value != '#FFFFFF') {
      notContentController.formatSelection(Attribute.fromKeyValue('color', '#FFFFFF'));
    }
  }

  void _toggleAttribute(Attribute attribute) {
    final isAttributeToggled = notContentController.getSelectionStyle().containsKey(attribute.key);
    if (isAttributeToggled) {
      notContentController.formatSelection(Attribute.clone(attribute, null));
    } else {
      notContentController.formatSelection(attribute);
    }
  }

  void _toggleList() {
    final attrs = notContentController.getSelectionStyle().attributes;
    if (attrs.containsKey(Attribute.list.key)) {
      notContentController.formatSelection(Attribute.clone(Attribute.list, null));
    } else {
      notContentController.formatSelection(Attribute.ul);
      final textColor =
          ThemeData.estimateBrightnessForColor(_backGroundColor) == Brightness.light ? '#000000' : '#FFFFFF';
      notContentController.formatSelection(Attribute.fromKeyValue('color', textColor)); // Set text color
      // Custom bullet point style
    }
  }

  void saveButton() {
    final noteContent = NoteGeneralContent(
      id: widget.id,
      messageTitle: notTitleController.text,
      messageContent: notContentController.document.toPlainText(),
    );
    print('Pop id: ${widget.id}');
    widget.onSave(noteContent, Colors.white);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: _backGroundColor,
      appBar: AppBar(
        backgroundColor: NoteColors.darkBgColor,
        foregroundColor: NoteColors.whiteColor,
        title: const Text(NoteStrings.appCreateAlrDtlTxt),
      ),
      body: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 32.0),
        child: Column(
          children: [
            TextField(
              controller: notTitleController,
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
                  color: ThemeData.estimateBrightnessForColor(_backGroundColor) == Brightness.light
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
                        // Set the bullet color to red
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
                    controller: notContentController,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomQuillToolbar(
              controller: notContentController,
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
