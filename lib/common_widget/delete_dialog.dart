import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const DeleteDialog({
    super.key,
    required this.onCancel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Student',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          wordSpacing: 4,
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this student?',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Comfortaa',
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
                fontFamily: 'Comfortaa',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: onDelete,
          child: const Text(
            'Delete',
            style: TextStyle(
                fontFamily: 'Comfortaa',
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
    );
  }
}
