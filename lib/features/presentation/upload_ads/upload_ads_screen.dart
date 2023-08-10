import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/core/validator_mixin.dart';
import 'package:hent_house_seller/features/presentation/providers/user_provider.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/widgets/ads_filed_widget.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/widgets/ads_location_widget.dart';
import 'package:hent_house_seller/features/presentation/upload_ads/widgets/custom_dropdown_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController monthlyCashController = TextEditingController();
  final TextEditingController currentLocationController =
      TextEditingController();
  bool waterValue = false;
  bool electricityValue = false;
  bool yardValue = false;
  final List<File> _image = [];
  ImagePicker picker = ImagePicker();
  final _controller = PageController();
  //Dropdown Values
  String toiletValue = '1';
  String bedRoomsValue = '1';
  String kitchenValue = '1';
  String livingRoomValue = '1';
  List<String> menuList = ['1', '2', '3', '4', '+4'];
  //
  String dropdownCategoryValue = 'Casa';
  List<String> menuCategoryList = ['Casa', 'Quarto', 'Apartamento', 'Vivenda'];
  //
  String dropdownProvinceValue = 'Cuando Cubango';
  List<String> menuProvinceList = ['Cuando Cubango', 'Huíla', 'Huambo', 'Uíge'];

  final UserAuthProvider _userAuthProvider = UserAuthProvider();
  publishAds() {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();
    final String monthlyCash = monthlyCashController.text.trim();
    final String currentLocation = currentLocationController.text.trim();
    final String categoryValue = dropdownCategoryValue;
    final String provinceValue = dropdownProvinceValue;
    log('tittle: $title');
    log('description: $description');
    log('monthlyCash: $monthlyCash');
    log('monthlyCash: $phoneNumber');
    log('currentLocation: $currentLocation');
    log('waterValue: $waterValue');
    log('electicityValue: $electricityValue');
    log('yardValue: $yardValue');
    log('roomValue: $toiletValue');
    log('bedRoomValue: $bedRoomsValue');
    log('kitchenValue: $kitchenValue');
    log('roomValue: $livingRoomValue');
    log('categoryValue: $categoryValue');
    log('provinceValue: $provinceValue');
    log('image: $_image');
  }

  @override
  void initState() {
    super.initState();
    _userAuthProvider.init();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  color: const Color.fromARGB(255, 246, 246, 246),
                  child: SizedBox(
                    height: height * 0.5,
                    width: width,
                    child: ListView.builder(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: _image.length,
                        itemBuilder: (context, index) {
                          return Visibility(
                            visible: index == 0,
                            replacement: Container(
                              height: height,
                              width: width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/person.png'),
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_image[index]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image.remove(_image[index]);
                                      });
                                    },
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
                                ),
                              ],
                            ),
                          );
                        }),
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
                ), //
              ],
            ),
            /*
            SmoothDotsIndicator(
              controller: _controller,
              itemCount: _image.length,
            ),
            */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await _showImageDialogBox();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      label: const Text(
                        'Carregar Imagem',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.circleInfo,
                    controller: titleController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Titulo do Anúncio',
                    fieldLabel: 'Titulo',
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.info,
                    controller: descriptionController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Descrição',
                    fieldLabel: 'Descrição',
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.phone,
                    controller: phoneNumberController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Número de Telefone',
                    fieldLabel: 'Contacto',
                  ),
                  AdsFieldWidget(
                    icon: FontAwesomeIcons.moneyBill,
                    controller: monthlyCashController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Valor Mensal',
                    fieldLabel: 'Valor',
                  ),
                  AdsLocationFieldWidget(
                    controller: currentLocationController,
                    validator: (value) => insNotEmpty(value),
                    textLabel: 'Localização',
                    fieldLabel: 'Localização',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SwitchWithTitleWidget(
                        label: 'Água',
                        value: waterValue,
                        onChanged: (bool newValue) {
                          setState(() {
                            waterValue = newValue;
                          });
                        },
                      ),
                      SwitchWithTitleWidget(
                          label: 'Eletricidade',
                          value: electricityValue,
                          onChanged: (bool newValue) {
                            setState(() {
                              electricityValue = newValue;
                            });
                          }),
                      SwitchWithTitleWidget(
                          label: 'Quintal',
                          value: yardValue,
                          onChanged: (bool newValue) {
                            setState(() {
                              yardValue = newValue;
                            });
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropdownMenu(
                        textLabel: 'WC',
                        dropdownValue: toiletValue,
                        menuList: menuList,
                        onChanged: (String? newValue) {
                          setState(() {
                            toiletValue = newValue!;
                          });
                        },
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Quartos',
                        dropdownValue: bedRoomsValue,
                        menuList: menuList,
                        onChanged: (String? newValue) {
                          setState(() {
                            bedRoomsValue = newValue!;
                          });
                        },
                      ),
                      CustomDropdownMenu(
                        textLabel: 'Cozinha',
                        dropdownValue: kitchenValue,
                        menuList: menuList,
                        onChanged: (String? newValue) {
                          setState(() {
                            kitchenValue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdownMenu(
                          textLabel: 'Sala',
                          dropdownValue: livingRoomValue,
                          menuList: menuList,
                          onChanged: (String? newValue) {
                            setState(() {
                              livingRoomValue = newValue!;
                            });
                          },
                        ),
                        CustomDropdownMenu(
                          textLabel: 'Categoria',
                          dropdownValue: dropdownCategoryValue,
                          menuList: menuCategoryList,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownCategoryValue = newValue!;
                            });
                          },
                        ),
                        CustomDropdownMenu(
                          textLabel: 'Província',
                          dropdownValue: dropdownProvinceValue,
                          menuList: menuProvinceList,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownProvinceValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: ElevatedButton.icon(
                      onPressed: () => publishAds(),
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
                        'Publicar',
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
    final authData = Provider.of<UserAuthProvider>(context, listen: false);
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
                    onPressed: () async {
                      await chooseImage(true);
                    },
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
                    onPressed: () async {
                      await chooseImage(false);
                    },
                    child: const Text(
                      'Câmera',
                      style: TextStyle(color: Colors.brown),
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

  Future<void> chooseImage(bool isFromGallery) async {
    final pickedFile = await picker.pickImage(
      source: isFromGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 20,
    );

    if (pickedFile != null) {
      print("Picked image path: ${pickedFile.path}");
      setState(() {
        _image.add(File(pickedFile.path));
      });
    } else {
      print("Image selection cancelled.");
    }
  }
}

class SwitchWithTitleWidget extends StatefulWidget {
  bool value;
  final String label;
  Function(bool)? onChanged;
  SwitchWithTitleWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SwitchWithTitleWidget> createState() => _SwitchWithTitleWidgetState();
}

class _SwitchWithTitleWidgetState extends State<SwitchWithTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Switch(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
