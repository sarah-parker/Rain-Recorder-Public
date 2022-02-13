import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rain_recorder/models/rain.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);
  // collection reference
  final FirebaseFirestore rainCollection = FirebaseFirestore.instance;

  Future updateRainData(double rainAmount, DateTime date) async {
    return await rainCollection.collection(uid).doc(date.toString()).set({
      'RainAmount': rainAmount,
      'Date': date,
    });
  }

  Future deleteRainDataForDay(DateTime date) async {
    await rainCollection.collection(uid).doc(date.toString()).delete();
  }

  List<Rain> rainfallFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp ts = doc.get('Date');
      return Rain(amount: doc.get('RainAmount'), date: ts.toDate());
    }).toList();
  }

  Stream<List<Rain>> get rainfall {
    return rainCollection.collection(uid).snapshots().map(rainfallFromSnapshot);
  }
}
