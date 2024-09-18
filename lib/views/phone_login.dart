import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  String countryCode = "+234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  "assets/chat.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to chat app 🖐",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text("Enter a valid phone number to continue"),
                    const SizedBox(height: 12),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value!.length != 10) {
                            return "Invalid phone number";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: CountryCodePicker(
                            flagWidth: 16,
                            initialSelection: "NG",
                            onChanged: (value) {
                              debugPrint(value.code);
                              countryCode = value.code!;
                            },
                          ),
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog.adaptive(
                                title: const Text("Verification Code"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "Enter the code that was sent to your phone"),
                                    const SizedBox(height: 12),
                                    Form(
                                      key: _formKey1,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.length != 6) {
                                            return "Invalid OTP";
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: _otpController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: "Verification Code",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey1.currentState!.validate()) {}
                                    },
                                    child: const Text("Submit"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text("Send OTP"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
