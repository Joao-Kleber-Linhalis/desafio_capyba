import 'package:flutter/material.dart';

class RestrictedScreen extends StatefulWidget {
  const RestrictedScreen({super.key});

  @override
  State<RestrictedScreen> createState() => _RestrictedScreenState();
}

class _RestrictedScreenState extends State<RestrictedScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Restricted Screen"),
    );
  }
}
