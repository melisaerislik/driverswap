import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Hata'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Kapat'),
            onPressed: () {
              Navigator.of(context).pop(); // AlertDialog'ı kapat
            },
          ),
        ],
      );
    },
  );
}