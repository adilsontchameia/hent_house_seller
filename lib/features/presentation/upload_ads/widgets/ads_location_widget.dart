import 'package:hent_house_seller/features/presentation/register/widgets/location_text_input.dart';

import '../../home_screen/home.dart';

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
