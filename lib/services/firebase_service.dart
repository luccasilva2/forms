import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Autenticação ---
  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erro no login: $e");
      return null;
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  // --- Formulários ---
  Future<void> createForm({
    required String title,
    required String description,
    required bool isPublic,
    required List<Map<String, dynamic>> questions,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Usuário não logado");

    await _firestore.collection('forms').add({
      'title': title,
      'description': description,
      'isPublic': isPublic,
      'questions': questions,
      'userId': user.uid,
      'createdAt': Timestamp.now(),
    });
  }

  // Busca formulários do usuário + públicos
  Stream<QuerySnapshot> getForms() {
    final user = _auth.currentUser;
    if (user == null) throw Exception("Usuário não logado");

    return _firestore
        .collection('forms')
        .where('isPublic', isEqualTo: true)
        .orWhere('userId', isEqualTo: user.uid)
        .snapshots();
  }
}