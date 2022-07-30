// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCBVKr4xL7ZuvKvccP7ac7KmHdJuUImRjk',
    appId: '1:1055495345593:web:3d1d7ae5cb79033f059268',
    messagingSenderId: '1055495345593',
    projectId: 'gym-system-d9131',
    authDomain: 'gym-system-d9131.firebaseapp.com',
    databaseURL: 'https://gym-system-d9131-default-rtdb.firebaseio.com',
    storageBucket: 'gym-system-d9131.appspot.com',
    measurementId: 'G-HSCHGT2NB1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7H3aE01H56-AgLMriVkoj8eBEPREHbHw',
    appId: '1:1055495345593:android:134f046443326c2f059268',
    messagingSenderId: '1055495345593',
    projectId: 'gym-system-d9131',
    databaseURL: 'https://gym-system-d9131-default-rtdb.firebaseio.com',
    storageBucket: 'gym-system-d9131.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-5LbbF8CaBytGbSkhvXZGPQfpkEt_gXI',
    appId: '1:1055495345593:ios:4bf3a3fa2cb064b1059268',
    messagingSenderId: '1055495345593',
    projectId: 'gym-system-d9131',
    databaseURL: 'https://gym-system-d9131-default-rtdb.firebaseio.com',
    storageBucket: 'gym-system-d9131.appspot.com',
    iosClientId: '1055495345593-cupsjme8o2v8cnapra819askvl0pk93p.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymSystem',
  );
}
