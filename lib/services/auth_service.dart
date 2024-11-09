import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionAdmin = 'Admins';

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _firestore.collection(_collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }
}
