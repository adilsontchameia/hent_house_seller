import 'widgets.dart';

class CustomInputText extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  const CustomInputText({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.borderEnabled = true,
    this.fontSize = 15.0,
    this.onChanged,
    this.validator,
    required this.controller,
    required this.icon,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  bool? isVisible;
  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.85,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? !isVisible! : false,
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
              onTap: () {
                setState(() {
                  isVisible = !isVisible!;
                });
              },
              child: Visibility(
                  visible: widget.isPassword ? true : false,
                  child: !isVisible!
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.brown,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.brown,
                        )),
            ),
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
            labelStyle: TextStyle(
              color: Colors.brown.shade300,
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
