

import 'package:flutter/material.dart';


class FormContainerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final int? maxLines;
  final bool applyBoxShadow;

  const FormContainerWidget({super.key, 
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.maxLines,
    this.applyBoxShadow = false,
  });


  @override
  _FormContainerWidgetState createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {

  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 236, 208, 30), // Đặt màu nền theo yêu cầu
        borderRadius: BorderRadius.circular(10),
        boxShadow: widget.applyBoxShadow // Nếu applyBoxShadow là true thì áp dụng shadow
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
            : [], // Nếu không thì không có shadow
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: widget.controller,
        keyboardType: widget.inputType ?? TextInputType.text,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLines: widget.isPasswordField == true ? 1 : widget.maxLines ?? 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: false,
          contentPadding: const EdgeInsets.all(10),
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: const TextStyle(color: Colors.black45),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child:
            widget.isPasswordField==true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? const Color.fromRGBO(255, 57, 116, 1) : Colors.grey,) : const Text(""),
          ),
        ),
      ),
    );
  }
}