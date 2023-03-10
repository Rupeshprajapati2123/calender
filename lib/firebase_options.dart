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
        return macos;
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
    apiKey: 'AIzaSyAzC7NcH8-EfQ4TGosEv0zLNY52E1_w8Kc',
    appId: '1:689464504631:web:30e104dc04e8620f012ab2',
    messagingSenderId: '689464504631',
    projectId: 'testverification-89321',
    authDomain: 'testverification-89321.firebaseapp.com',
    storageBucket: 'testverification-89321.appspot.com',
    measurementId: 'G-5JY7EC3XKF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCH7KgRIcxWaEYVq5w9cd4r9w45TC8Ur50',
    appId: '1:689464504631:android:cf8709cb06189c18012ab2',
    messagingSenderId: '689464504631',
    projectId: 'testverification-89321',
    storageBucket: 'testverification-89321.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeP7jAhbqIVhp0JF9LElgZPncMZB47ATY',
    appId: '1:689464504631:ios:7bd54ad26bfead22012ab2',
    messagingSenderId: '689464504631',
    projectId: 'testverification-89321',
    storageBucket: 'testverification-89321.appspot.com',
    androidClientId: '689464504631-b1f29c8nlgvr8amc6lb8kr8qr0c264ja.apps.googleusercontent.com',
    iosClientId: '689464504631-m4ucmbvocpsacji2uttemm07rqn9o6dm.apps.googleusercontent.com',
    iosBundleId: 'com.example.calender',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeP7jAhbqIVhp0JF9LElgZPncMZB47ATY',
    appId: '1:689464504631:ios:7bd54ad26bfead22012ab2',
    messagingSenderId: '689464504631',
    projectId: 'testverification-89321',
    storageBucket: 'testverification-89321.appspot.com',
    androidClientId: '689464504631-b1f29c8nlgvr8amc6lb8kr8qr0c264ja.apps.googleusercontent.com',
    iosClientId: '689464504631-m4ucmbvocpsacji2uttemm07rqn9o6dm.apps.googleusercontent.com',
    iosBundleId: 'com.example.calender',
  );
}
