// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBMbOgerW1Lk2-fyDraK3K0MqRArt0_a3g',
    appId: '1:331684255595:web:4f01fbb13ee8588cc49e2e',
    messagingSenderId: '331684255595',
    projectId: 'cw-6-acddb',
    authDomain: 'cw-6-acddb.firebaseapp.com',
    storageBucket: 'cw-6-acddb.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGI1_PvtLQweE77C3hZyc-vyjS_EVK0VY',
    appId: '1:331684255595:android:adf57220834a08e6c49e2e',
    messagingSenderId: '331684255595',
    projectId: 'cw-6-acddb',
    storageBucket: 'cw-6-acddb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjiHIjeMcdLK3C3HS14wq0Nkf8m-1IrvY',
    appId: '1:331684255595:ios:508175928ef06a23c49e2e',
    messagingSenderId: '331684255595',
    projectId: 'cw-6-acddb',
    storageBucket: 'cw-6-acddb.firebasestorage.app',
    iosBundleId: 'com.example.task',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjiHIjeMcdLK3C3HS14wq0Nkf8m-1IrvY',
    appId: '1:331684255595:ios:508175928ef06a23c49e2e',
    messagingSenderId: '331684255595',
    projectId: 'cw-6-acddb',
    storageBucket: 'cw-6-acddb.firebasestorage.app',
    iosBundleId: 'com.example.task',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBMbOgerW1Lk2-fyDraK3K0MqRArt0_a3g',
    appId: '1:331684255595:web:1141ae88ada9624bc49e2e',
    messagingSenderId: '331684255595',
    projectId: 'cw-6-acddb',
    authDomain: 'cw-6-acddb.firebaseapp.com',
    storageBucket: 'cw-6-acddb.firebasestorage.app',
  );
}
