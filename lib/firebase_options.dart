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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBoGbrwtmMN3f7mSh25hUEwYRRKgiyFq4',
    appId: '1:255901731754:android:00f271cf2345744b7ff9d3',
    messagingSenderId: '255901731754',
    projectId: 'to-do-65936',
    storageBucket: 'to-do-65936.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjYBvZQrMA4SaQB8AI4wNAp-SP1i_XBdU',
    appId: '1:255901731754:ios:9fabc785140a97cf7ff9d3',
    messagingSenderId: '255901731754',
    projectId: 'to-do-65936',
    storageBucket: 'to-do-65936.appspot.com',
    androidClientId: '255901731754-af9mgsc00u4blniqvujrr1rbebv4ikuq.apps.googleusercontent.com',
    iosClientId: '255901731754-vf351vakcm6c701gj0u58n51v60g92q1.apps.googleusercontent.com',
    iosBundleId: 'com.denuwan.todo',
  );
}
