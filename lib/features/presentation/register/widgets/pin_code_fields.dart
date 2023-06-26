import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatefulWidget {
  final TextEditingController textEditingController;
  const PinCodeFields({super.key, required this.textEditingController});

  @override
  State<PinCodeFields> createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  var onTapRecognizer = TapGestureRecognizer();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  bool isLoading = true;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          pastedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          enabled: isLoading,
          length: 4,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 4) {
              return 'Insira os 4 digitos';
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeColor: Colors.black,
            disabledColor: Colors.white,
            inactiveColor: Colors.black,
            selectedColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveFillColor: Colors.white30,
            activeFillColor:
                hasError ? Colors.white : Colors.white54.withOpacity(0.2),
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          textStyle: TextStyle(
            fontSize: 20,
            height: 1.6,
            color: isLoading ? Colors.white : Colors.black,
          ),
          //backgroundColor: Colors.blue.shade50,
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: widget.textEditingController,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) {
            setState(() {
              isCompleted = true;
              isLoading = false;
            });
          },

          onChanged: (value) {
            log(value);
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            log("Allowing to paste $text");
            /*
          if (data?.text?.isNotEmpty ?? false) {
                          if (widget.beforeTextPaste != null) {
                            if (widget.beforeTextPaste!(data!.text)) {
                              _showPasteDialog(data.text!);
                            }
                          } else {
                            _showPasteDialog(data!.text!);
                          }
                        }
                        */
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        Visibility(
          visible: !isCompleted,
          replacement: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: LinearProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (!isCompleted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
