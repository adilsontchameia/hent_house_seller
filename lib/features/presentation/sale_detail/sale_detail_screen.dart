import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hent_house_seller/features/data/models/advertisement_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/validator_mixin.dart';
import '../home_screen/home.dart';
import '../providers/advertisement_provider.dart';
import '../providers/user_data_provider.dart';
import '../providers/user_provider.dart';
import '../upload_ads/widgets/ads_filed_widget.dart';
import '../upload_ads/widgets/ads_location_widget.dart';
import '../upload_ads/widgets/cstom_int_dropdown.dart';
import '../upload_ads/widgets/custom_dropdown_widget.dart';
import '../upload_ads/widgets/switch_with_title.dart';

class SaleDetailsScreen extends StatefulWidget {
  static const routeName = '/sale-details-screen';
  final AdvertisementModel advertisement;
  const SaleDetailsScreen({
    Key? key,
    required this.advertisement,
  }) : super(key: key);

  @override
  State<SaleDetailsScreen> createState() => _SaleDetailsScreenState();
}

class _SaleDetailsScreenState extends State<SaleDetailsScreen>
    with ValidationMixins {
  // Controllers

  final GlobalKey<FormState> _formKey = GlobalKey();
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
  List<String> _imageUrls = [];
  ImagePicker picker = ImagePicker();
  final _controller = PageController();
  final HomeAdsServiceProvider _homeAds = HomeAdsServiceProvider();
  //Dropdown Values
  int bathRoomValue = 1;
  int bedRoomsValue = 1;
  int kitchenValue = 1;
  int livingRoomValue = 1;
  List<int> menuList = [1, 2, 3, 4, 5];
  //
  String dropdownCategoryValue = 'Casa';
  List<String> menuCategoryList = ['Casa', 'Quarto', 'Apartamento', 'Vivenda'];
  //
  String dropdownProvinceValue = 'Cuando Cubango';
  List<String> menuProvinceList = ['Cuando Cubango', 'Huíla', 'Huambo', 'Uíge'];

  final UserAuthProvider _userAuthProvider = UserAuthProvider();
  final UserDataProvider _dataProvider = UserDataProvider();

  setInitialValues() {
    titleController.text = widget.advertisement.title!;
    descriptionController.text = widget.advertisement.additionalDescription!;
    phoneNumberController.text = widget.advertisement.contact!;
    monthlyCashController.text = widget.advertisement.monthlyPrice!.toString();
    currentLocationController.text = widget.advertisement.address!;
    waterValue = widget.advertisement.water!;
    electricityValue = widget.advertisement.electricity!;
    yardValue = widget.advertisement.yard!;
    bathRoomValue = widget.advertisement.bathRoom!;
    bedRoomsValue = widget.advertisement.bedRooms!;
    kitchenValue = widget.advertisement.kitchen!;
    livingRoomValue = widget.advertisement.livingRoom!;
    dropdownCategoryValue = widget.advertisement.type!;
    dropdownProvinceValue = widget.advertisement.province!;
  }

  Future<void> _loadImageUrlsFromFirestore() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('ads')
          .doc(widget.advertisement.id)
          .get();

      final data = snapshot.data() as Map<String, dynamic>;
      final List<dynamic> imageUrls = data['image'];

      setState(() {
        _imageUrls = List<String>.from(imageUrls);
      });
    } catch (e) {
      // Handle error as needed
    }
  }

  updateAds() {
    final validationPassed = _formKey.currentState!.validate();
    if (validationPassed && _image.isNotEmpty) {
      final String title = titleController.text.trim();
      final String additionalDescription = descriptionController.text.trim();
      final String contact = phoneNumberController.text.trim();
      final double monthlyPrice =
          double.parse(monthlyCashController.text.trim());
      final String address = currentLocationController.text.trim();
      final String categoryValue = dropdownCategoryValue;
      final String provinceValue = dropdownProvinceValue;

      _homeAds.createAds(
        title,
        address,
        additionalDescription,
        bathRoomValue,
        bedRoomsValue,
        kitchenValue,
        livingRoomValue,
        electricityValue,
        yardValue,
        waterValue,
        categoryValue,
        contact,
        monthlyPrice,
        _dataProvider.currentUser.fullName!,
        provinceValue,
        _userAuthProvider.userAddressLatitude!,
        _userAuthProvider.userAddressLongitude!,
        _image,
      );
    } else {
      log('Fill all fields.');
    }
  }

  @override
  void initState() {
    super.initState();
    _userAuthProvider.init();
    _dataProvider.getCurrentUserData();
    setInitialValues();
    scheduleMicrotask(() {
      _loadImageUrlsFromFirestore();
    });
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
                        itemCount: _imageUrls.length,
                        itemBuilder: (context, index) {
                          if (index < _imageUrls.length) {
                            return Image.network(_imageUrls[index]);
                          } else {
                            final imageIndex = index - _imageUrls.length;

                            return Stack(
                              children: [
                                Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_image[imageIndex]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image.removeAt(imageIndex);
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
                            );
                          }
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
            Form(
              key: _formKey,
              child: Padding(
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
                        CustomIntDropdownMenu(
                          textLabel: 'WC',
                          dropdownValue: bathRoomValue,
                          menuList: menuList,
                          onChanged: (int? newValue) {
                            setState(() {
                              bathRoomValue = newValue!;
                            });
                          },
                        ),
                        CustomIntDropdownMenu(
                          textLabel: 'Quartos',
                          dropdownValue: bedRoomsValue,
                          menuList: menuList,
                          onChanged: (int? newValue) {
                            setState(() {
                              bedRoomsValue = newValue!;
                            });
                          },
                        ),
                        CustomIntDropdownMenu(
                          textLabel: 'Cozinha',
                          dropdownValue: kitchenValue,
                          menuList: menuList,
                          onChanged: (int? newValue) {
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
                          CustomIntDropdownMenu(
                            textLabel: 'Sala',
                            dropdownValue: livingRoomValue,
                            menuList: menuList,
                            onChanged: (int? newValue) {
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
                        onPressed: () => updateAds(),
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
                          'Guardar',
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
            ),
          ],
        ),
      ))),
    );
  }

  Future<void> _showImageDialogBox() async {
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
      log("Picked image path: ${pickedFile.path}");
      setState(() {
        _image.add(File(pickedFile.path));
      });
    } else {
      log("Image selection cancelled.");
    }
  }
}
