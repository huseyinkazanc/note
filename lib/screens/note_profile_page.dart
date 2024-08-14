import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/screens/note_login_page.dart';
import 'package:note/services/note_auth_service.dart';
import 'package:note/widgets/common/note_widget_custom_button.dart';
import 'package:note/widgets/common/note_widget_custom_iconbutton.dart';
import 'package:note/widgets/common/note_widget_show_before_alert.dart';
import 'package:note/widgets/common/note_widget_table.dart';
import 'package:note/widgets/popup/note_widget_alerttext_buton.dart';

class NoteProfilePage extends StatefulWidget {
  NoteProfilePage({super.key});
  bool lightOfPages = true;

  @override
  State<NoteProfilePage> createState() => _NoteProfilePageState();
}

class _NoteProfilePageState extends State<NoteProfilePage> {
  final AuthService _authService = AuthService();
  String? _username;
  String? _email;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userDetails = await _authService.getUserDetails();
      setState(() {
        _username = userDetails?['username'];
        _email = userDetails?['email'];
      });
      print("User Details: $_username, $_email");
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _username = 'Error fetching username';
        _email = 'Error fetching email';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) => NoteWidgetBeforeAlert(
              onDelete: () async {
                await _authService.logOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NoteLoginPage()));
              },
              alertTitleText: 'Log Out',
              alertLeftText: 'Cancel',
              alertRightText: 'Log Out',
            ));
  }

  void _deletAccount() {
    showDialog(
        context: context,
        builder: (BuildContext context) => NoteWidgetBeforeAlert(
              onDelete: () async {
                await _authService.deleteUser();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NoteLoginPage()));
              },
              alertTitleText: 'Delete Account',
              alertLeftText: 'Cancel',
              alertRightText: 'Delete',
            ));
  }

  void _darkMode(bool value) {
    setState(() {
      if (widget.lightOfPages == true) {
        widget.lightOfPages = false;
        print('Light Mode');
      } else {
        widget.lightOfPages = true;
        print('Dark Mode');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          centerTitle: true,
          title: Text(
            NoteStrings.appPrflTxt,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: NoteColors.whiteColor,
                  fontSize: NoteFont.fontSizeThirtySix,
                ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                //add colors to colors array
                                colors: [
                                  Colors.red,
                                  Colors.black,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Text(
                              _username!.substring(0, 1),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: NoteFont.fontSizeFifty,
                                fontWeight: NoteFont.fontWeightBold,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          ' $_email',
                          style: TextStyle(fontSize: NoteFont.fontSizeTwentyFour),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.dark_mode,
                            color: NoteColors.redColor,
                          ),
                          title: Text(
                            NoteStrings.appPrfDrkMd,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: NoteColors.whiteColor,
                                  fontSize: NoteFont.fontSizeTwenty,
                                ),
                          ),
                          trailing: Switch(
                            // This bool value toggles the switch.
                            value: widget.lightOfPages,
                            activeColor: NoteColors.redColor,
                            onChanged: _darkMode,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NoteWidgetAlertTextButton(
                              onPressed: _deletAccount,
                              alertBgColor: NoteColors.redColor,
                              alertTxtColor: NoteColors.whiteColor,
                              alertText: NoteStrings.appPrfDlt,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NoteWidgetAlertTextButton(
                              onPressed: _logOut,
                              alertBgColor: NoteColors.whiteColor,
                              alertTxtColor: NoteColors.darkBgColor,
                              alertText: NoteStrings.appPrfLgot,
                              alertBrdrColor: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
