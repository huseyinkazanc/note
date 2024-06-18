import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/services/note_auth_service.dart';
import 'package:note/widgets/common/note_widget_custom_button.dart';
import 'package:note/widgets/common/note_widget_custom_textfield.dart';
import 'package:note/screens/note_main_page.dart';

class NoteSignUpPage extends StatefulWidget {
  const NoteSignUpPage({super.key});

  @override
  _NoteSignUpPageState createState() => _NoteSignUpPageState();
}

class _NoteSignUpPageState extends State<NoteSignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signUpRegister() async {
    final authService = AuthService();
    final userCredential = await authService.signUp(
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );
    if (userCredential != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteMainPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NoteColors.darkBgColor,
      appBar: AppBar(
        backgroundColor: NoteColors.darkBgColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Column(
                children: [
                  Text(NoteStrings.appTitle,
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                      )),
                  SizedBox(height: 20),
                  Text(NoteStrings.appLginSgnTxt, style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 80),
              Column(
                children: [
                  NotWidgetCustomTextField(
                    text: NoteStrings.appLginUsrNmHnt,
                    controller: _usernameController,
                    autofocus: true,
                  ),
                  const SizedBox(height: 20),
                  NotWidgetCustomTextField(
                    text: NoteStrings.appLginUsrEml,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  NotWidgetCustomTextField(
                    text: NoteStrings.appLginUsrPsw,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // NotWidgetCustomTextField(text: NoteStrings.appLginUsrCnfrPsw),
                  const SizedBox(height: 0),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                children: [
                  Expanded(
                    child: NoteWidgetCustomButton(
                      onPressed: signUpRegister,
                      text: NoteStrings.appLginSgnUp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(NoteStrings.appLginOr, style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: NoteWidgetCustomButton(
                      icon: Icons.g_mobiledata_sharp,
                      text: 'Login with Google',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
