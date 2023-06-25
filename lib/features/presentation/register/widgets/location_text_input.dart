import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LocationInputText extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  final double width;
  const LocationInputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.borderEnabled = true,
    this.fontSize = 15.0,
    this.onChanged,
    this.validator,
    this.width = 0,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  State<LocationInputText> createState() => _LocationInputTextState();
}

class _LocationInputTextState extends State<LocationInputText> {
  @override
  Widget build(BuildContext context) {
    final geolocatorProvider = Provider.of<UserAuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        //   width: widget.width == 0  ? MediaQuery.of(context).size.width * 0.85   : widget.width,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          validator: widget.validator,
          cursorColor: Colors.brown,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: const Color.fromARGB(255, 55, 55, 55)),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    )),
                width: 10.0,
                child: Icon(widget.icon, color: Colors.white),
              ),
            ),
            suffixIcon: InkWell(
                onTap: () async {
                  widget.controller.text = 'Procurando, Por Favor, Aguarde.';
                  try {
                    await geolocatorProvider.getCurrentLocation();
                    widget.controller.text = geolocatorProvider.userAddress;
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 4),
                      content: Text(
                        'Não foi possível determinar sua localização, por favor, tente novamente.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      backgroundColor: Colors.brown,
                    ));
                    widget.controller.text =
                        ''; // Reset the text field if location retrieval fails.
                  }
                },
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.brown,
                )),
            prefixIconColor: Colors.brown,
            filled: true,
            fillColor: Colors.white,
            hintText: widget.label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.brown,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.brown,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            labelStyle: const TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
