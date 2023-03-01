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
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
