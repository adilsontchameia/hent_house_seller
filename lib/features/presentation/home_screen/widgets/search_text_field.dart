import '../home.dart';

class SearchField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final bool borderEnabled;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData icon;
  final bool isVisible;
  const SearchField({
    Key? key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.borderEnabled = true,
    this.fontSize = 15.0,
    this.onChanged,
    this.validator,
    required this.controller,
    required this.icon,
    required this.isVisible,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        height: 40.0,
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
            suffixIcon: Visibility(
              visible: widget.isVisible,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    widget.controller.text = '';
                  });
                },
                icon: const Icon(
                  FontAwesomeIcons.xmark,
                  color: Colors.brown,
                ),
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    )),
                width: 10.0,
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 15.0,
                ),
              ),
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
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.brown,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            labelStyle: TextStyle(
              color: Colors.brown.shade200,
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
