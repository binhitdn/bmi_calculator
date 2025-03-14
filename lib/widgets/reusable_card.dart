import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function()? onTap;

  const ReusableCard({
    Key? key,
    required this.child,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: color,
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: child,
      ),
    );
  }
}
