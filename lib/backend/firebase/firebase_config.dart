import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBFbXyw8lDstqNz5CQ_Cn-xnC7w49J32GE",
            authDomain: "eventistan-s7yh0u.firebaseapp.com",
            projectId: "eventistan-s7yh0u",
            storageBucket: "eventistan-s7yh0u.appspot.com",
            messagingSenderId: "104874177373",
            appId: "1:104874177373:web:e9313c7bd65a5b1efeaeb4"));
  } else {
    await Firebase.initializeApp();
  }
}
