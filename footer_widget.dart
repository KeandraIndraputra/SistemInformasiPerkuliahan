import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        "© 2026 Student Portal • Keandra Indraputra",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}