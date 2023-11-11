import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? isShowpassword;
  final String? hintText;
  final String? labelText;
  final String? errorMessage;
  final Color? themColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? rePasswordText;
  final String? Function(String?)? validator;

  const TextInput(
      {super.key,
        required this.controller,
        this.textInputType,
        this.isShowpassword,
        this.hintText,
        this.labelText,
        this.errorMessage,
        this.themColor,
        this.prefixIcon,
        this.suffixIcon,
        this.validator,
        this.rePasswordText = ""});

  @override
  State<TextInput> createState() => _customTextInputState();
}

class _customTextInputState extends State<TextInput> {
  bool _isValidate = true;
  String messageError = "";
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.isShowpassword == true ? _obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorText: _isValidate ? null : messageError,
          prefixIcon: widget.prefixIcon,
          suffixIcon: new GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isShowpassword == true
                  ? Icon(_obscureText ? Icons.visibility_off : Icons.visibility)
                  : Icon(null)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black26, width: 1))),
    );
  }
}