import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final String loginType;
  const LoginForm({Key? key, required this.loginType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Realize seu Login", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 25
                    )),
                  ),
                  SizedBox(height: size.height * .05),
                  CustomTextField(size: size, labelText: "Email", obscureText: false, icon: Icons.mail),
                  SizedBox(height: size.height * .05),
                  CustomTextField(size: size, labelText: "Senha", obscureText: true, icon: Icons.lock),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Size size;
  final String labelText;
  final bool obscureText;
  final IconData icon;

  const CustomTextField({
    super.key,
    required this.size,
    required this.labelText,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .07,
      width: size.width * .8,
      child: Row(
        children: [
          Flexible(
            child: TextField(
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 18,
                ),
                suffixIcon: Icon(
                  icon, color: Colors.grey.shade400
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
