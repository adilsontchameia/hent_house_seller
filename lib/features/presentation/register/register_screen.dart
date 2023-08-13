import 'dart:async';
import 'dart:io';

import 'package:hent_house_seller/core/validator_mixin.dart';
import 'package:hent_house_seller/features/presentation/login/login_screen.dart';
import 'package:hent_house_seller/features/presentation/providers/user_provider.dart';
import 'package:hent_house_seller/features/presentation/widgets/custom_input_text.dart';
import 'package:hent_house_seller/features/presentation/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'widgets/location_text_input.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixins {
  //? Global key for validation purpose
  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserAuthProvider _userAuthProvider = UserAuthProvider();
  //? Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _userAuthProvider.init();
  }

  Future<void> _submit() async {
    final validationPassed = _formKey.currentState!.validate();
    final String firstName = firstNameController.text.trim();
    final String surnName = surnNameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String phone = phoneController.text.trim();
    final String address = addressController.text.trim();

    if (validationPassed && _image != null) {
      setState(() {
        _userAuthProvider.isReady = true;
        _userAuthProvider.signUp(
          firstName: firstName,
          surnName: surnName,
          email: email,
          phone: phone,
          password: password,
          address: address,
          image: _image,
        );
      });
    } else {
      _showDialogBox();
    }
  }

  Future<void> _showDialogBox() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Info',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          content: const Text(
            'Por favor, carregue uma foto de perfil.',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 0,
          left: -65,
          child: Transform.rotate(
            angle: 180.0,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90.0),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -65,
          child: Transform.rotate(
            angle: 180.0,
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(90.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SafeArea(
                child: GestureDetector(
                  onTap: () async {
                    await _showImageDialogBox();
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 90.0,
                          width: 90.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Center(
                              child: _image == null
                                  ? Image.asset('assets/person.png',
                                      fit: BoxFit.cover)
                                  : Image.file(File(_image!.path),
                                      fit: BoxFit.cover), //After pick image
                            ),
                          )),
                      const SizedBox(height: 25.0),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
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
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                label: 'Email',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              CustomInputText(
                                icon: Icons.phone,
                                isPassword: false,
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                label: 'Telefone',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              CustomInputText(
                                icon: Icons.password,
                                isPassword: true,
                                keyboardType: TextInputType.number,
                                controller: passwordController,
                                label: 'Senha',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  'OBS: Aperte no ícone de GPS para buscar sua localização atual.',
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              LocationInputText(
                                icon: Icons.location_on,
                                controller: addressController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Sua Localização Atual',
                                fontSize: 15.0,
                                validator: (value) => insNotEmpty(value),
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                  onPressed: _submit,
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
                                  child: const Text(
                                    'Cadastrar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  //color: Colors.pinkAccent,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, LoginScreen.routeName),
                                  child: const Text(
                                    'Já tenho uma conta.',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                      wordSpacing: 2,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Future<void> _showImageDialogBox() async {
    final authData = Provider.of<UserAuthProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
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
                    onPressed: () => authData.getGalleryImage().then((image) {
                      setState(() {
                        _image = image;
                      });
                    }),
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
                        color: Colors.black,
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
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => authData.getCameraImage().then((image) {
                      setState(() {
                        _image = image;
                      });
                    }),
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
