import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/clinic_model.dart';


abstract class HomeRemoteDatasource {
  Future<List<ClinicModel>> getClinics();
}

class HomeRemoteDatasourceImp extends HomeRemoteDatasource {
  final FirebaseFirestore fireStore;
  HomeRemoteDatasourceImp(this.fireStore);

  @override
  Future<List<ClinicModel>> getClinics() async {
    final snap = await fireStore.collection('clinics').get();
    return snap.docs.map(ClinicModel.fromDoc).toList();
  }
}