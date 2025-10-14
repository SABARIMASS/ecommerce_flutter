import 'package:flutter/material.dart';

class ResponsiveRowWrapWidget extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  const ResponsiveRowWrapWidget({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacing, // Space between widgets in a row
      runSpacing: runSpacing, // Space between rows
      children: children,
    );
  }
}
