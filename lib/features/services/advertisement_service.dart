import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';

class HomeAdvertisementManager {
  //? Firebase
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('sales');

  //? Get all sales
  Stream<List<AdvertisementModel>> getAllSales() {
    return _ref
        .where(
          'id',
          isEqualTo: AuthService().getUser().uid,
        )
        .snapshots()
        .map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }
      return sales;
    });
  }

  Stream<List<AdvertisementModel>> searchAdvertisements(String query) {
    return _ref
        .where('title', isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }
      return sales;
    });
  }

  //? Get all top picked sales
  Stream<List<AdvertisementModel>> getTopPickedSales() {
    return _ref
        .where(
          'topPicked',
          isEqualTo: true,
        )
        .snapshots()
        .map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }
      return sales;
    });
  }

  Stream<List<AdvertisementModel>> getFilteredSales({
    bool? topPicked,
    String? category,
    int? minPrice,
    int? maxPrice,
  }) {
    // Start with the reference to the collection
    Query query = _ref;

    // Apply filters based on the provided parameters
    if (topPicked != null) {
      query = query.where('topPicked', isEqualTo: topPicked);
    }

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    if (minPrice != null) {
      query = query.where('price', isGreaterThanOrEqualTo: minPrice);
    }

    if (maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice);
    }

    //? Get the snapshots and map the results
    return query.snapshots().map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }
      return sales;
    });
  }

  Stream<List<AdvertisementModel>> getSlideSales() {
    return _ref
        .where(
          'isPromo',
          isEqualTo: true,
        )
        .snapshots()
        .map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }
      return sales;
    });
  }

  Future<AdvertisementModel> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      AdvertisementModel advertisementModel =
          AdvertisementModel.fromJson(document.data() as Map<String, dynamic>);
      return advertisementModel;
    }

    return AdvertisementModel();
  }

  Future<void> updateData(Map<String, dynamic> data, String id) async {
    return _ref.doc(id).update(data);
  }
}
