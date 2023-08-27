import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/core/validator_mixin.dart';
import 'package:hent_house_seller/features/data/models/seller_model.dart';
import 'package:hent_house_seller/features/presentation/register/widgets/location_text_input.dart';
import 'package:hent_house_seller/features/presentation/widgets/custom_input_text.dart';
import 'package:hent_house_seller/features/presentation/widgets/error_icon_on_fetching.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';

class ProfileScreen extends StatelessWidget with ValidationMixins {
  static const routeName = '/profile-screen';

  // Constructor
  ProfileScreen({Key? key}) : super(key: key);

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentLocationController =
      TextEditingController();
  final UserManager _userManager = UserManager();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PROFILE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      letterSpacing: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _authService.signOut(),
                    child: Container(
                      height: 35.0,
                      width: 35.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.unlock,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder<SellerModel>(
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
                    firstNameController.text = userModel.firstName!;
                    surnNameController.text = userModel.surnName!;
                    emailController.text = userModel.email!;
                    phoneController.text = userModel.phone!;
                    currentLocationController.text = userModel.address!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: CachedNetworkImage(
                                  imageUrl: userModel.image!,
                                  fit: BoxFit.fill,
                                  height: 80.0,
                                  width: 80.0,
                                  placeholder: (context, str) => Center(
                                    child: Container(
                                        color: Colors.white,
                                        height: height,
                                        width: width,
                                        child:
                                            Image.asset('assets/loading.gif')),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const ErrorIconOnFetching(),
                                ),
                              ),
                              Text(
                                '${userModel.firstName} ${userModel.surnName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                userModel.phone!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                  letterSpacing: 2,
                                ),
                              ),
                              CustomInputText(
                                icon: Icons.person,
                                isPassword: false,
                                controller: firstNameController,
                                keyboardType: TextInputType.name,
                                label: 'Nome',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              CustomInputText(
                                icon: Icons.person_3,
                                isPassword: false,
                                keyboardType: TextInputType.name,
                                controller: surnNameController,
                                label: 'Sobrenome',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              CustomInputText(
                                icon: Icons.email,
                                isPassword: false,
                                keyboardType: TextInputType.name,
                                controller: emailController,
                                label: 'Email',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              CustomInputText(
                                icon: Icons.phone,
                                isPassword: false,
                                keyboardType: TextInputType.name,
                                controller: phoneController,
                                label: 'Telefone',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              CustomInputText(
                                icon: Icons.password,
                                isPassword: true,
                                keyboardType: TextInputType.name,
                                controller: passwordController,
                                label: 'Senha',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              LocationInputText(
                                icon: Icons.location_on,
                                controller: currentLocationController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Sua Localização Atual',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.brown),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  label: const Text(
                                    'Salvar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  icon: const Icon(
                                    FontAwesomeIcons.solidFloppyDisk,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
