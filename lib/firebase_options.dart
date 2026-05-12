import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAUFMo-_0ZJ-H4aN2g3XkK4gQ5heHN6wjo',
    appId: '1:688271650798:web:01418ba580481742bde8ff',
    messagingSenderId: '688271650798',
    projectId: 'ecom-c3009',
    authDomain: 'ecom-c3009.firebaseapp.com',
    storageBucket: 'ecom-c3009.firebasestorage.app',
    measurementId: 'G-VE66DL9JM8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtA-QO8Wo6cBEGV2kW0BI3joHJ1UHUMss',
    appId: '1:688271650798:android:ae054b5744d41388bde8ff',
    messagingSenderId: '688271650798',
    projectId: 'ecom-c3009',
    storageBucket: 'ecom-c3009.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHXP1qoGVL2WAahxFPZiDlkhaMGOH2iGI',
    appId: '1:688271650798:ios:b0b1c35fb2ef4f2cbde8ff',
    messagingSenderId: '688271650798',
    projectId: 'ecom-c3009',
    storageBucket: 'ecom-c3009.firebasestorage.app',
    iosClientId: '688271650798-l0q5aig5tl85pu5ucos70trfn1h666gj.apps.googleusercontent.com',
    iosBundleId: 'com.ecom.app',
  );

}