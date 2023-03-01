import 'package:flutter/material.dart';

import 'button_add.dart';

class AddSheetContent extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddSheetContent(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Insira a tarefa...',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Salvar
                    ButtonAdd(text: 'Sair', onClick: onCancel),

                    const SizedBox(width: 10),

                    //Sair
                    ButtonAdd(text: 'Salvar', onClick: onSave),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
