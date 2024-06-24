import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/screens/note_signup_page.dart';
import 'package:note/services/note_auth_service.dart';
import 'package:note/widgets/common/note_widget_custom_button.dart';
import 'package:note/widgets/common/note_widget_custom_textfield.dart';
import 'package:note/screens/note_main_page.dart';

class NoteLoginPage extends StatefulWidget {
  const NoteLoginPage({super.key});

  @override
  _NoteLoginPageState createState() => _NoteLoginPageState();
}

class _NoteLoginPageState extends State<NoteLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = AuthService();
    final userCredential = await authService.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    if (userCredential != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteMainPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Kullanıcı adı ve parola yanlış'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        ),
      );
    }
  }

  void getSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteSignUpPage(),
      ),
    );
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
                  Text(NoteStrings.appLginTxt, style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 80),
              Column(
                children: [
                  NotWidgetCustomTextField(
                    text: NoteStrings.appLginHntMail,
                    controller: emailController,
                    autofocus: true,
                  ),
                  const SizedBox(height: 20),
                  NotWidgetCustomTextField(
                    text: NoteStrings.appLginHntPsw,
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(NoteStrings.appLginFrgtPsw, style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: NoteWidgetCustomButton(
                      onPressed: signIn,
                      text: NoteStrings.appLginBtnTxt,
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
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(NoteStrings.appLginDntAcnt, style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: getSignUp,
                    child: const Text(NoteStrings.appLginSgnUp),
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
