import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/core/validator_mixin.dart';
import 'package:hent_house_seller/features/presentation/register/widgets/location_text_input.dart';
import 'package:hent_house_seller/features/presentation/widgets/custom_input_text.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';

class UploadAdsScreen extends StatefulWidget {
  static const routeName = '/upload-ads-screen';

  // Constructor
  const UploadAdsScreen({Key? key}) : super(key: key);

  @override
  State<UploadAdsScreen> createState() => _UploadAdsScreenState();
}

class _UploadAdsScreenState extends State<UploadAdsScreen>
    with ValidationMixins {
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

  String dropdownValue = '1';
  List<String> menuList = ['1', '2', '3', '4', '+4'];

  String dropdownBoolValue = 'SIM';
  List<String> menuBoolList = ['SIM', 'NÃO'];

  String dropdownCategoryValue = 'Casa';
  List<String> menuCategoryList = ['Casa', 'Quarto', 'Apartamento', 'Vivenda'];

  String dropdownProvinceValue = 'Cuando Cubango';
  List<String> menuProvinceList = ['Cuando Cubango', 'Huíla', 'Huambo', 'Uíge'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.amber,
                  child: Image.asset(
                    'assets/panorama.jpg',
                    height: 250.0,
                    width: width,
                    fit: BoxFit.fitHeight,

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
                ),
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
              ],
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Imagens Selecionadas: x',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.circleInfo,
                    controller: firstNameController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Titulo do Anúncio',
                    fieldLabel: 'Titulo',
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.info,
                    controller: firstNameController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Descrição',
                    fieldLabel: 'Descrição',
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.phone,
                    controller: firstNameController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Número de Telefone',
                    fieldLabel: 'Contacto',
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.moneyBill,
                    controller: firstNameController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Valor Mensal',
                    fieldLabel: 'Valor',
                  ),
                  AdsLocationFieldWidget(
                    controller: firstNameController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Localização',
                    fieldLabel: 'Localização',
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 15.0,
                    children: [
                      CustomDropdownMenu(
                        textLabel: 'WC',
                        dropdownValue: dropdownValue,
                        menuList: menuList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Água',
                        dropdownValue: dropdownBoolValue,
                        menuList: menuBoolList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Quartos',
                        dropdownValue: dropdownValue,
                        menuList: menuList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Cozinha',
                        dropdownValue: dropdownValue,
                        menuList: menuList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Quintal',
                        dropdownValue: dropdownBoolValue,
                        menuList: menuBoolList,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10.0,
                    children: [
                      CustomDropdownMenu(
                        textLabel: 'Eletricidade',
                        dropdownValue: dropdownBoolValue,
                        menuList: menuBoolList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Sala de Estar',
                        dropdownValue: dropdownValue,
                        menuList: menuList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Categoria',
                        dropdownValue: dropdownCategoryValue,
                        menuList: menuCategoryList,
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Província',
                        dropdownValue: dropdownProvinceValue,
                        menuList: menuProvinceList,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width,
                    child: ElevatedButton.icon(
                      onPressed: () => log('Uploading'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.brown.shade500,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      label: const Text(
                        'Carregar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.upload,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ))),
    );
  }
}

class AdsFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String textLabel;
  final String fieldLabel;
  final IconData icon;
  const AdsFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.textLabel,
    required this.fieldLabel,
    required this.icon,
  });

  @override
  State<AdsFieldWidget> createState() => _AdsFieldWidgetState();
}

class _AdsFieldWidgetState extends State<AdsFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textLabel,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomInputText(
          icon: widget.icon,
          isPassword: false,
          controller: widget.controller,
          keyboardType: TextInputType.name,
          label: widget.fieldLabel,
          fontSize: 15.0,
          validator: widget.validator,
        ),
      ],
    );
  }
}

class AdsLocationFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String textLabel;
  final String fieldLabel;
  const AdsLocationFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.textLabel,
    required this.fieldLabel,
  });

  @override
  State<AdsLocationFieldWidget> createState() => _AdsLocationFieldWidgetState();
}

class _AdsLocationFieldWidgetState extends State<AdsLocationFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textLabel,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        LocationInputText(
          icon: Icons.location_on,
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          label: widget.fieldLabel,
          fontSize: 15.0,
          validator: widget.validator,
        ),
      ],
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  String dropdownValue;
  final List<String> menuList;
  final String textLabel;
  CustomDropdownMenu({
    super.key,
    required this.dropdownValue,
    required this.menuList,
    required this.textLabel,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textLabel,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          alignment: Alignment.centerLeft,
          value: widget.dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              widget.dropdownValue = newValue!;
            });
          },
          items: widget.menuList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
