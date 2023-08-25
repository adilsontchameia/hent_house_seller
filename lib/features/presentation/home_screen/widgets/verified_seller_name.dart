import 'dart:developer';

import 'package:hent_house_seller/features/data/models/seller_model.dart';
import 'package:hent_house_seller/features/presentation/widgets/seller_bages.dart';
import 'package:hent_house_seller/features/services/seller_service.dart';

import '../home.dart';

class VerifiedSellerName extends StatelessWidget {
  VerifiedSellerName({
    super.key,
    required this.sellerName,
    required this.publishedDate,
    required this.sellerId,
  });

  final String sellerName;
  final String sellerId;
  final String publishedDate;
  final SellerServiceManager _sellerServiceManager = SellerServiceManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SellerModel>(
        stream: _sellerServiceManager.getByIdAsStream(sellerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // Loading state
          } else if (snapshot.hasError) {
            log('${snapshot.error}');
            return Container(); // Error state
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("Seller not found"); // Seller not found state
          } else {
            SellerModel sellerModel = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FadeInLeft(
                      child: Text(
                        sellerName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    FadeInRight(
                      child: Row(
                        children: [
                          SellerBages(
                            state: sellerModel.isVerified!,
                            icon: FontAwesomeIcons.check,
                            containerColor: Colors.blue,
                          ),
                          const SizedBox(width: 5.0),
                          SellerBages(
                            state: sellerModel.isTopSeller!,
                            icon: FontAwesomeIcons.trophy,
                            containerColor: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FadeInLeft(
                  child: Text(
                    publishedDate,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: Colors.white),
                  ),
                ),
              ],
            );
          }
        });
  }
}
