import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/screens/note_login_page.dart';
import 'package:note/services/note_auth_service.dart';
import 'package:note/widgets/common/note_widget_show_before_alert.dart';
import 'package:note/widgets/popup/note_widget_alerttext_buton.dart';

class NoteProfilePage extends StatefulWidget {
  const NoteProfilePage({super.key});

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
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Column(
                    children: [
                      Text(
                        ' $_username',
                        style: TextStyle(fontSize: NoteFont.fontSizeTwentyFour),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        ' $_email',
                        style: TextStyle(fontSize: NoteFont.fontSizeTwentyFour),
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
    );
  }
}
