import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hent_house_seller/features/data/models/seller_model.dart';

class SellerServiceManager {
  //? Firebase
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('sellers');

  //? Get all sallers
  Stream<List<SellerModel>> getAllSellers() {
    return _ref.snapshots().map((querySnapshot) {
      List<SellerModel> sellers = [];
      for (var document in querySnapshot.docs) {
        SellerModel seller = SellerModel.fromJson(
          document.data() as Map<String, dynamic>,
        );
        sellers.add(seller);
      }
      return sellers;
    });
  }

  //? Get Seller By ID
  Stream<SellerModel> getByIdAsStream(String id) {
    return _ref.doc(id).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return SellerModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        // Return null if the document doesn't exist
        return SellerModel();
      }
    });
  }

  //? Update user device token
  Future<void> updateData(Map<String, dynamic> data, String id) async {
    return _ref.doc(id).update(data);
  }
}
