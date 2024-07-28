import 'package:flutter/material.dart';
import 'package:note/features/note_colors.dart';
import 'package:note/features/note_font.dart';
import 'package:note/features/note_strings.dart';
import 'package:note/services/note_auth_service.dart';

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
      final userDetails = await _authService.getUserData();
      print('Fetched user details: $userDetails'); // Debug print statement
      if (userDetails != null) {
        setState(() {
          _username = userDetails['username'] ?? 'No username found';
          _email = userDetails['email'] ?? 'No email found';
        });
      } else {
        setState(() {
          _username = 'No user data found';
          _email = 'No user data found';
        });
      }
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Username: $_username',
                    style: TextStyle(fontSize: NoteFont.fontSizeTwentyFour),
                  ),
                  Text(
                    'Email: $_email',
                    style: TextStyle(fontSize: NoteFont.fontSizeTwentyFour),
                  ),
                ],
              ),
      ),
    );
  }
}
