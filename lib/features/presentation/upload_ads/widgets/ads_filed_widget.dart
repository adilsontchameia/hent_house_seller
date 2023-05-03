import 'package:hent_house_seller/features/presentation/widgets/custom_input_text.dart';

import '../../home_screen/home.dart';

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
