import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> registerNewUser({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithGoogle();
  Future<UserModel> getCurrentUser();
  Future<void> logout();
  Future<void> updateProfile({required String name, String? phone});
  Future<void> changePassword({required String currentPassword, required String newPassword});
  Future<String> uploadProfilePhoto(File file);
}

class AuthRemoteDatasourceImp extends AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  final FirebaseStorage storage;
  AuthRemoteDatasourceImp(this.auth, this.fireStore, this.storage);

  @override
  Future<UserModel> login(String email, String password) async {
    final creds = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final doc = await fireStore.collection('users').doc(creds.user!.uid).get();
    final jsonData = {...?doc.data(), 'id': doc.id};
    return UserModel.fromJson(jsonData);
  }

  @override
  Future<UserModel> registerNewUser({
    required String name,
    required String email,
    required String password,
  })
  async {
    final trimmedName = name.trim();
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(trimmedName);
    await userCredential.user!.reload();
    await fireStore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({'name': trimmedName, 'email': email});
    return UserModel(
      id: userCredential.user!.uid,
      name: trimmedName,
      email: userCredential.user!.email ?? '',
    );
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception('تم إلغاء تسجيل الدخول بجوجل');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await auth.signInWithCredential(credential);
    final user = userCredential.user!;

    final doc = await fireStore.collection('users').doc(user.uid).get();
    if (!doc.exists) {
      await fireStore.collection('users').doc(user.uid).set({
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
      });
    }
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception('لا يوجد مستخدم مسجل دخول حاليًا');
    }

    final docRef = fireStore.collection('users').doc(currentUser.uid);
    final doc = await docRef.get();

    final firestoreName = doc.data()?['name'] as String?;
    final firestoreEmail = doc.data()?['email'] as String?;
    final firestorePhone = doc.data()?['phone'] as String?;
    final firestorePhotoUrl = doc.data()?['photoUrl'] as String?;

    final resolvedName = (firestoreName != null && firestoreName.trim().isNotEmpty)
        ? firestoreName.trim()
        : (currentUser.displayName ?? '');
    final resolvedEmail = (firestoreEmail != null && firestoreEmail.isNotEmpty)
        ? firestoreEmail
        : (currentUser.email ?? '');
    final resolvedPhotoUrl = (firestorePhotoUrl != null && firestorePhotoUrl.isNotEmpty)
        ? firestorePhotoUrl
        : (currentUser.photoURL ?? '');

    if (!doc.exists || firestoreName == null || firestoreEmail == null) {
      await docRef.set({
        'name': resolvedName,
        'email': resolvedEmail,
      }, SetOptions(merge: true));
    }

    return UserModel(
      id: currentUser.uid,
      name: resolvedName,
      email: resolvedEmail,
      phone: firestorePhone ?? '',
      photoUrl: resolvedPhotoUrl,
    );
  }




  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }

  @override
  Future<void> updateProfile({required String name, String? phone}) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception('لا يوجد مستخدم مسجل دخول حاليًا');
    }
    final trimmedName = name.trim();
    await currentUser.updateDisplayName(trimmedName);
    await currentUser.reload();

    final data = <String, dynamic>{'name': trimmedName};
    if (phone != null) data['phone'] = phone.trim();

    await fireStore.collection('users').doc(currentUser.uid).set(data, SetOptions(merge: true));
  }

  @override
  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    final currentUser = auth.currentUser;
    if (currentUser == null || currentUser.email == null) {
      throw Exception('لا يوجد مستخدم مسجل دخول حاليًا');
    }
    final credential = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: currentPassword,
    );
    await currentUser.reauthenticateWithCredential(credential);
    await currentUser.updatePassword(newPassword);
  }

  @override
  Future<String> uploadProfilePhoto(File file) async {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception('لا يوجد مستخدم مسجل دخول حاليًا');
    }
    final ref = storage.ref().child('users/${currentUser.uid}/profile.jpg');

    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();

    await currentUser.updatePhotoURL(downloadUrl);
    await currentUser.reload();

    await fireStore.collection('users').doc(currentUser.uid).set(
      {'photoUrl': downloadUrl},
      SetOptions(merge: true),
    );

    return downloadUrl;
  }
}