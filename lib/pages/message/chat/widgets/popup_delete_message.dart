import 'package:flutter/material.dart';

void PopupDeleteMessage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure you want to delete this message?"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text("OK"),
            onPressed: () {
              // Perform the delete operation here
              // For demonstration purposes, we'll just navigate back
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pop(); // Close the message detail screen
            },
          ),
        ],
      );
    },
  );
}