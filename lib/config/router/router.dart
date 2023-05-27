import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:hent_house_seller/features/presentation/chat_messages/chat_messages_screen.dart';
import 'package:hent_house_seller/features/presentation/list_chat_messages/list_chat_messages_screen.dart';
import 'package:hent_house_seller/features/presentation/check_auth/check_auth_screen.dart';
import 'package:hent_house_seller/features/presentation/filtered_advertisiment/filtered_advertisiment_screen.dart';
import 'package:hent_house_seller/features/presentation/home_screen/home_screen.dart';
import 'package:hent_house_seller/features/presentation/login/login_screen.dart';
import 'package:hent_house_seller/features/presentation/profile/profile_screen.dart';
import 'package:hent_house_seller/features/presentation/register/register_screen.dart';
import 'package:hent_house_seller/features/presentation/route_error/route_error.dart';
import 'package:hent_house_seller/features/presentation/sale_detail/sale_detail_screen.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/upload_ads_screen.dart';
import 'package:hent_house_seller/features/presentation/widgets/widgets.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SaleDetailsScreen.routeName:
      final advertisement = settings.arguments as AdvertisementModel;
      return MaterialPageRoute(
          builder: (context) => SaleDetailsScreen(
                advertisement: advertisement,
              ));
    case HomeResumeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => HomeResumeScreen(),
      );
    //UploadAdsScreen
    case ListChatMessagesScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ListChatMessagesScreen(),
      );
    case ChatMessagesScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => ChatMessagesScreen(
          name: name,
          uid: uid,
        ),
      );
    case CheckAuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CheckAuthScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );
    case ProfileScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      );
    case FilteredAdvertisimentScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const FilteredAdvertisimentScreen(),
      );
    case UploadAdsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UploadAdsScreen(),
      );
    default:
      return MaterialPageRoute(
          builder: (context) => const RouteErrorScreen(
              title: 'Sorry, we could not found the requested page'));
  }
}
