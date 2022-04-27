import 'package:flutter/material.dart';

bool isDesktop(BuildContext context, int breakpoint) {
  if (MediaQuery.of(context).size.width < breakpoint) {
    return false;
  } else {
    return true;
  }
}
