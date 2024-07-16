import 'package:flutter/material.dart';

extension ContextExtension on double {
  SizedBox get height => SizedBox(height: this);
  SizedBox get width => SizedBox(width: this);
}
