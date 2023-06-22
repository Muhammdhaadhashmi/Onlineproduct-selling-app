import 'package:flutter/material.dart';

class AllowScreen extends StatefulWidget {
  static const String id = '/allow';
  const AllowScreen({Key? key}) : super(key: key);

  @override
  _AllowScreenState createState() => _AllowScreenState();
}

class _AllowScreenState extends State<AllowScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("User"),
    );
  }
}
