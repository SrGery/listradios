import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget route, {bool willPop = false}) {
  if (willPop) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return route;
      },
    ), (_) => false);
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return route;
        },
      ),
    );
  }
}
