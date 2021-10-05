import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {@required this.icon,
      @required this.labelText,
      @required this.function,
      this.errorText,
      this.obscure = false});
  final IconData icon;
  final String labelText;
  final String errorText;
  final Function(String) function;
  final bool obscure;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        obscureText: widget.obscure,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                widget.icon,
                size: 30,
                color: const Color(0xffF54749),
              ),
            ),
            label: Text(widget.labelText),
            border: OutlineInputBorder(),
            errorText: widget.errorText),
        onSaved: widget.function,
      ),
    );
  }
}
