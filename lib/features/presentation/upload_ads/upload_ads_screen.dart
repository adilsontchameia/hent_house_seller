import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/core/utils.dart';
import 'package:hent_house_seller/core/validator_mixin.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/widgets/ads_filed_widget.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/widgets/ads_location_widget.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/widgets/custom_dropdown_widget.dart';
import 'package:image_picker/image_picker.dart';

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
  final List<File> _image = [];
  ImagePicker picker = ImagePicker();
  //Dropdown Values
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
                  color: const Color.fromARGB(255, 246, 246, 246),
                  child: SizedBox(
                    height: height * 0.5,
                    width: width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _image.length,
                        itemBuilder: (context, index) {
                          if (_image.isEmpty) {
                            return Image.asset(
                              'assets/person.png',
                              fit: BoxFit.fitHeight,
                            );
                          } else {
                            return Container(
                              height: 250.0,
                              width: width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_image[index]),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
                //
                Positioned(
                  right: 0.0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _showImageDialogBox();
                        },
                        child: Container(
                          height: 35.0,
                          width: 35.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.image,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => print('Remove'),
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
                            FontAwesomeIcons.trash,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: GestureDetector(
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
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

  Future<void> _showImageDialogBox() async {
    //final authData = Provider.of<UserAuthProvider>(context, listen: false);
    AppUtilsProvider appUtils = AppUtilsProvider();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Carregar imagem de perfil.',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () => appUtils.chooseImage(
                      picker,
                      _image,
                      true,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Galeria',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    //color: Colors.pinkAccent,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Câmera',
                      style: TextStyle(color: Colors.brown),
                    ),
                    onPressed: () => appUtils.chooseImage(
                      picker,
                      _image,
                      false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
