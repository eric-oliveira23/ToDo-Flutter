import 'package:flutter/material.dart';

class ButtonAdd extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const ButtonAdd({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClick,
      color: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
