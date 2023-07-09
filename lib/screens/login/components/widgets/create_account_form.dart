import 'package:flutter/material.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({Key? key}) : super(key: key);

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  bool keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Crie a sua conta",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 16),
          const TextField(),
          const SizedBox(height: 16),
          const TextField(),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Realizar Login!", style: Theme.of(context).textTheme.titleLarge)
            ],
          )
        ],
      ),
    );
  }
}
