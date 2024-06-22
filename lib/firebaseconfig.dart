import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const firebaseConfig = {
  "apiKey": "AIzaSyCb5YPki1fR9NuWoCxGV9orm2hGOOwRDko",
  "authDomain": "mobile-1381c.firebaseapp.com",
  "projectId": "mobile-1381c",
  "storageBucket": "mobile-1381c.appspot.com",
  "messagingSenderId": "429474342090",
  "appId": "1:429474342090:web:55a8849afce5d1ba73c033"
};

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig["apiKey"]!,
      authDomain: firebaseConfig["authDomain"]!,
      projectId: firebaseConfig["projectId"]!,
      storageBucket: firebaseConfig["storageBucket"]!,
      messagingSenderId: firebaseConfig["messagingSenderId"]!,
      appId: firebaseConfig["appId"]!,
    ),
  );
}
