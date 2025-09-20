import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap({this.height, this.width, super.key});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
