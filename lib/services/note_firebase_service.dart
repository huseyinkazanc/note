import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note/notecontent/note_general_content.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore get firestore => _firestore; // Getter tanımlandı

  Future<void> saveNote(NoteGeneralContent noteContent) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('notes').doc(noteContent.id).set({
          'userId': user.uid,
          'id': noteContent.id,
          'messageTitle': noteContent.messageTitle,
          'messageContent': noteContent.messageContent,
          'noteColor': noteContent.noteColor?.value,
        }, SetOptions(merge: true));
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Firebase note saving error: $e');
    }
  }

  Future<List<NoteGeneralContent>> fetchNotes() async {
    List<NoteGeneralContent> notes = [];
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore.collection('notes').where('userId', isEqualTo: user.uid).get();
        notes = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return NoteGeneralContent(
            id: data['id'],
            messageTitle: data['messageTitle'],
            messageContent: data['messageContent'],
            noteColor: data['noteColor'] != null ? Color(data['noteColor']) : null,
          );
        }).toList();
      }
    } catch (e) {
      print('Firebase note fetching error: $e');
    }
    return notes;
  }

  Future<void> deleteNote(String docId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('notes').doc(docId).delete();
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Firebase note deletion error: $e');
    }
  }
}
