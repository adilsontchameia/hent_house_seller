import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/core/validator_mixin.dart';
import 'package:hent_house_seller/features/presentation/register/widgets/location_text_input.dart';
import 'package:hent_house_seller/features/presentation/widgets/custom_input_text.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';

class UploadAdsScreen extends StatelessWidget with ValidationMixins {
  static const routeName = '/upload-ads-screen';

  // Constructor
  UploadAdsScreen({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                      FontAwesomeIcons.x,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.asset(
                              'assets/loading.gif',
                              height: 100.0,
                              width: 100.0,
                            ),
                            /*
                            CachedNetworkImage(
                              imageUrl: userModel.image!,
                              fit: BoxFit.fill,
                              height: 80.0,
                              width: 80.0,
                              placeholder: (context, str) => Center(
                                child: Container(
                                  color: Colors.white,
                                  height: height,
                                  width: width,
                                  child: Image.asset(
                                    'assets/loading.gif',
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const ErrorIconOnFetching(),
                            ),
                            */
                          ),
                          CustomInputText(
                            icon: Icons.person,
                            isPassword: false,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            label: 'Titulo',
                            fontSize: 15.0,
                            validator: (value) => insNotEmpty(value),
                          ),
                          LocationInputText(
                            icon: Icons.location_on,
                            controller: currentLocationController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Localização',
                            fontSize: 15.0,
                            validator: (value) => insNotEmpty(value),
                          ),
                          CustomInputText(
                            icon: Icons.person_3,
                            isPassword: false,
                            keyboardType: TextInputType.name,
                            controller: surnNameController,
                            label: 'Descrição',
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.brown),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
