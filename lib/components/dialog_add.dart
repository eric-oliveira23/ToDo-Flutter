import 'package:flutter/material.dart';
import 'package:todo/components/button_add.dart';

class DialogAdd extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogAdd({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira a tarefa...',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
      ),
    );
  }
}
