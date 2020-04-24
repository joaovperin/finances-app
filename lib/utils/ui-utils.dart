import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void popPage(BuildContext context, {data}) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context, data);
  } else {
    SystemNavigator.pop();
  }
}
