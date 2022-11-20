import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;

Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();  

  
  //Email-şifre ile giriş
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //Email-şifre ile kayıt
 Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    
  }) async {
     var user =await  _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password, 
    );
     await _firestore.collection("person_message").doc(user.user?.uid).set({    

      'email':email,
      'password':password,
      'name':name


  });
  }

  //Hesaptan çıkış
  Future<Future> signOut(context,Widget widget) async {
    await _firebaseAuth.signOut();
    return Navigator.of(context).push(MaterialPageRoute(builder: (context)=> widget ));
  }
}