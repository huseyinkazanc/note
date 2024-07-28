import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/screens/note_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter  Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: NoteColors.darkBgColor,

        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: NoteColors.darkBgColor,
          titleTextStyle: const TextStyle(
            color: Colors.white, // Başlık rengini beyaz yapar
          ),
          iconTheme: const IconThemeData(
            color: Colors.white, // Geri tuşunu beyaz yapar
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white, // Metin rengini beyaz yapar
          ),
          bodyMedium: TextStyle(
            color: Colors.white, // Metin rengini beyaz yapar
          ),
          bodySmall: TextStyle(
            color: Colors.white, // Metin rengini beyaz yapar
          ),
        ),
      ),
      home: const NoteLoginPage(),
    );
  }
}
