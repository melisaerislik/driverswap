import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_swap/Model/randevu_model.dart';

class RandevuService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'Calismazamani';

  Future<void> randevuEkle(RandevuModel randevu) async {
    try {
      await _firestore.collection(_collectionName).add(randevu.toJson());
    } catch (e) {
      print('Hata: $e');
    }
  }
  Stream<List<RandevuModel>> randevuListele() {
    try {
      return _firestore.collection(_collectionName).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => RandevuModel(
          hatNo: doc['hatNo'],
          zaman: (doc['zaman'] as Timestamp?)?.toDate(), guzergah: '',
        )
        ).toList();
      });
    } catch (e) {
      print('Hata: $e');
      return Stream.value([]);
    }
  }

}