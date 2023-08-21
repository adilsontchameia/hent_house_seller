import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/presentation/home_screen/widgets/latest_sales_card.dart';
import 'package:hent_house_seller/features/presentation/home_screen/widgets/seller_resume_card.dart';
import 'package:hent_house_seller/features/presentation/providers/advertisement_provider.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/upload_ads_screen.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';

import 'home.dart';

class HomeResumeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  HomeResumeScreen({super.key});

  final HomeAdsServiceProvider advertisementManager = HomeAdsServiceProvider();

  final UserManager _userManager = UserManager();

  @override
  Widget build(BuildContext context) {
    int totalOfAds = 0;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mô Cúbico',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0,
                        letterSpacing: 3,
                        color: Colors.brown,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        UploadAdsScreen.routeName,
                      ),
                      child: Container(
                        height: 35.0,
                        width: 35.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SellerResumeCard(
                  userManager: _userManager,
                  totalOfAds: totalOfAds,
                ),
                const Text(
                  'Minhas Publicações',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 2,
                      color: Colors.brown),
                ),
                StreamBuilder<List<AdvertisementModel>>(
                  stream: advertisementManager.getAllAds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.brown,
                      ));
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Column(
                        children: [
                          Image.asset(
                            'assets/not_found.jpg',
                            height: 120.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            'No sales found',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ));
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          AdvertisementModel advertisement =
                              snapshot.data![index];

                          return LatestSalesCard(
                            advertisement: advertisement,
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
