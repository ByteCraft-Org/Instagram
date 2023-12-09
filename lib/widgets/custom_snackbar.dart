import 'package:flutter/material.dart';

void customSnackbar({
  required BuildContext context,
  required String type,
  required String message,
}) {
  IconData icon;
  Color color;

  switch (type) {
    case "Info":
      icon = Icons.info_outline;
      color = Colors.blue;
      break;
    case "Error":
      icon = Icons.error_outline;
      color = Colors.red;
      break;
    case "Warning":
      icon = Icons.warning;
      color = Colors.orange;
      break;
    case "Success":
      icon = Icons.done;
      color = Colors.green;
      break;
    default:
      icon = Icons.adjust;
      color = Colors.white;
  }

  final snackBar = SnackBar(
    content: Wrap(
      alignment: WrapAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 10),
            Text(
              type,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.grey.shade900,
    duration: const Duration(milliseconds: 1500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

