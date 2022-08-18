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
    apiKey: 'AIzaSyAJJmzDHsPTbHqErZ96OU7Sg8vZVN7wDD8',
    appId: '1:32814496729:web:4dfb415779260cb51df7c8',
    messagingSenderId: '32814496729',
    projectId: 'test-a3ee1',
    authDomain: 'test-a3ee1.firebaseapp.com',
    storageBucket: 'test-a3ee1.appspot.com',
    measurementId: 'G-SJG6MPVQ0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHqmOk0cl0vq9AmRInKlQRz-otmBOuQag',
    appId: '1:32814496729:android:c325471f93379ca81df7c8',
    messagingSenderId: '32814496729',
    projectId: 'test-a3ee1',
    storageBucket: 'test-a3ee1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDskyasDukowPaNnVfhoDmvXRRJmtn-g84',
    appId: '1:32814496729:ios:8d4105135054fdc91df7c8',
    messagingSenderId: '32814496729',
    projectId: 'test-a3ee1',
    storageBucket: 'test-a3ee1.appspot.com',
    iosClientId:
        '32814496729-60qpjdt3t48tp8se42m2bvdpjdsb80j4.apps.googleusercontent.com',
    iosBundleId: 'com.example.api',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDskyasDukowPaNnVfhoDmvXRRJmtn-g84',
    appId: '1:32814496729:ios:8d4105135054fdc91df7c8',
    messagingSenderId: '32814496729',
    projectId: 'test-a3ee1',
    storageBucket: 'test-a3ee1.appspot.com',
    iosClientId:
        '32814496729-60qpjdt3t48tp8se42m2bvdpjdsb80j4.apps.googleusercontent.com',
    iosBundleId: 'com.example.api',
  );
}
