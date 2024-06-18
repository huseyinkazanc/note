// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDWuT2vkpAq_DlFI0o9SNKq3_sAWUXi6EM',
    appId: '1:669720645027:web:7824bc8addf543d9901e16',
    messagingSenderId: '669720645027',
    projectId: 'notlab-c09bb',
    authDomain: 'notlab-c09bb.firebaseapp.com',
    storageBucket: 'notlab-c09bb.appspot.com',
    measurementId: 'G-XZ1GBG9LR7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBu6oepHtj1WWblqrJUOGqLqQuCH56dRwA',
    appId: '1:669720645027:android:0e86ac11b4b67749901e16',
    messagingSenderId: '669720645027',
    projectId: 'notlab-c09bb',
    storageBucket: 'notlab-c09bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDO2uwRJKt5dwlalZUW3qVNtQNJtUn8gu8',
    appId: '1:669720645027:ios:18779c2b9c9c4aa6901e16',
    messagingSenderId: '669720645027',
    projectId: 'notlab-c09bb',
    storageBucket: 'notlab-c09bb.appspot.com',
    iosBundleId: 'com.example.note',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDO2uwRJKt5dwlalZUW3qVNtQNJtUn8gu8',
    appId: '1:669720645027:ios:18779c2b9c9c4aa6901e16',
    messagingSenderId: '669720645027',
    projectId: 'notlab-c09bb',
    storageBucket: 'notlab-c09bb.appspot.com',
    iosBundleId: 'com.example.note',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWuT2vkpAq_DlFI0o9SNKq3_sAWUXi6EM',
    appId: '1:669720645027:web:2593fd9f721b4055901e16',
    messagingSenderId: '669720645027',
    projectId: 'notlab-c09bb',
    authDomain: 'notlab-c09bb.firebaseapp.com',
    storageBucket: 'notlab-c09bb.appspot.com',
    measurementId: 'G-KZ31KNR15W',
  );
}
