import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DeatalsScreen extends StatefulWidget {
  const DeatalsScreen({super.key});

  @override
  State<DeatalsScreen> createState() => _DeatalsScreenState();
}

class _DeatalsScreenState extends State<DeatalsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Expanded(
          flex: 1,
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
