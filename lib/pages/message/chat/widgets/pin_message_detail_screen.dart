import 'package:flutter/material.dart';

class PinMessageDetailScreen extends StatelessWidget {
  final String message;

  PinMessageDetailScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
