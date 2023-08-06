import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hent_house_seller/core/currency_formart.dart';
import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/presentation/home_screen/widgets/verified_seller_name.dart';
import 'package:hent_house_seller/features/presentation/sale_detail/sale_detail_screen.dart';
import 'package:hent_house_seller/features/presentation/widgets/error_icon_on_fetching.dart';

class LatestSalesCard extends StatelessWidget {
  const LatestSalesCard({
    super.key,
    required this.advertisement,
  });

  final AdvertisementModel advertisement;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        SaleDetailsScreen.routeName,
        arguments: advertisement,
      ),
      child: BounceInDown(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: advertisement.image!.first,
                  fit: BoxFit.fill,
                  height: 150.0,
                  width: double.infinity,
                  placeholder: (context, str) => Center(
                    child: Container(
                        color: Colors.white,
                        width: width,
                        child: Image.asset('assets/loading.gif')),
                  ),
                  errorWidget: (context, url, error) =>
                      const ErrorIconOnFetching(),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 60,
                    width: width,
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElasticInLeft(
                                delay: const Duration(milliseconds: 200),
                                child: Text(
                                  advertisement.title!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              ElasticInRight(
                                delay: const Duration(milliseconds: 200),
                                child: Text(
                                  KwanzaFormatter.formatKwanza(
                                    double.parse(
                                      advertisement.monthlyPrice!.toString(),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: VerifiedSellerName(
                              sellerName: advertisement.sellerName!,
                              publishedDate:
                                  advertisement.publishedDate!.toString(),
                              sellerId: advertisement.sellerId!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
