import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/item_details.dart';
import 'package:food_app/widgets/custom_button.dart';
import 'package:food_app/screens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import 'package:food_app/services/auth_firebase.dart';
import 'package:food_app/services/sign_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'SignUpScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider(), child: Screen());
  }
}

class Screen extends StatelessWidget {
  String email = '';
  String password = '';
  String username = '';
  String address = '';
  String phone = '';
  bool isLoading = false;
  AuthFirebaseMethods authFirebaseMethods = AuthFirebaseMethods();
  TextEditingController _userName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: Provider.of<SignUpProvider>(context).isLoading,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                      color: const Color(0xffD4361C), fontSize: 50, fontWeight: FontWeight.w700),
                ),
                Padding(
                    padding: const EdgeInsets.all(30),
                    child: Image.asset('assets/images/deliveryman.jpg')),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _userName,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          //TODO: custom validator for users
                        ]),
                        icon: Icons.person,
                        labelText: 'Username',
                        function: (value) {
                          username = value;
                        },
                      ),
                      CustomTextField(
                        controller: _address,
                        validator: RequiredValidator(errorText: "Required"),
                        icon: Icons.home,
                        labelText: 'Address',
                        function: (value) {
                          address = value;
                        },
                      ),
                      CustomTextField(
                        controller: _phone,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          MinLengthValidator(11, errorText: "enter a valid mobile number"),
                          MaxLengthValidator(11, errorText: "enter a valid mobile number"),
                        ]),
                        icon: Icons.phone,
                        labelText: 'Mobile number',
                        function: (value) {
                          phone = value;
                        },
                      ),
                      CustomTextField(
                        controller: _email,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          EmailValidator(errorText: "Please enter a valid email address"),
                        ]),
                        icon: Icons.email,
                        labelText: 'Email',
                        function: (value) {
                          email = value;
                        },
                      ),
                      CustomTextField(
                        controller: _password,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          MinLengthValidator(6,
                              errorText: "Password must contain at least 6 characters"),
                          MaxLengthValidator(15,
                              errorText: "Password cannot be more 15 characters"),
                          PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                              errorText: "Password must have at least one special character"),
                        ]),
                        icon: Icons.lock,
                        labelText: 'Password',
                        obscure: true,
                        function: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Consumer<SignUpProvider>(builder: (_, value, child) {
                  return CustomButton(
                      text: 'Sign Up',
                      function: () async {
                        if (_formKey.currentState.validate()) {
                          Provider.of<SignUpProvider>(context, listen: false).loading();
                          await AuthFirebaseMethods().signUpWithEmailAndPassword(email, password);
                          Navigator.pushNamed(context, HomeScreen.id);
                          Provider.of<SignUpProvider>(context, listen: false).signed();
                        }
                      });
                })
              ],
            ),
          ),
        )),
      ),
    );
  }
}
