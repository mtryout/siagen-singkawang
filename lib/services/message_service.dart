// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMessage(
    {
      // UserModel user,
    bool? isFromUser,
    String? message,
    }) async {
      try {
        firestore.collection('messages').add({
          'userId': 1,
          // 'userId': user.id,
          'userName': 'Iqbal',
          // 'userName': user.name, 
          // 'userImage': user.profilePhotoUrl,
          'isFromUser': true,
          'message': message,
          'createdAt': DateTime.now().toString(),
          'updatedAt': DateTime.now().toString(),
        }).then(
          (value) => print('Pesan Berhasil Dikirim!')
        );
      } catch (e) {
        throw Exception('Pesan Gagal Dikirim!');
      }
    }
}