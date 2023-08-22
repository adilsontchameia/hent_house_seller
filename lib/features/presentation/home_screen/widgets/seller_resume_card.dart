import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/data/models/seller_model.dart';
import 'package:hent_house_seller/features/presentation/widgets/error_icon_on_fetching.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';

class SellerResumeCard extends StatelessWidget {
  const SellerResumeCard({
    super.key,
    required UserManager userManager,
    required this.totalOfAds,
  }) : _userManager = userManager;

  final UserManager _userManager;
  final int totalOfAds;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        height: 125.0,
        width: double.infinity,
        child: Card(
          elevation: 2.0,
          color: Colors.brown.withOpacity(0.8),
          child: StreamBuilder<SellerModel>(
            stream: _userManager.getUserById(_userManager.getUser().uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading indicator while waiting for the data
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.brown,
                  ),
                );
              } else if (snapshot.hasError) {
                // Show an error message if there's an error in fetching data
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData) {
                final SellerModel userModel = snapshot.data!;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: userModel.image!,
                            fit: BoxFit.fill,
                            height: 90.0,
                            width: 90.0,
                            placeholder: (context, str) => Center(
                              child: Container(
                                  color: Colors.white,
                                  height: height,
                                  width: width,
                                  child: Image.asset('assets/loading.gif')),
                            ),
                            errorWidget: (context, url, error) =>
                                const ErrorIconOnFetching(),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.fullName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                userModel.phone!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                userModel.email!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              /*
                              const SizedBox(height: 10.0),
                              Text(
                                'Total de Anúncios: $totalOfAds',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
