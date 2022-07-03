import 'package:flutter/material.dart';

class BottomSheetWidget {
  static ShapeBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  static Future<dynamic> showBottomSheetCountry({
    required BuildContext context,
  }) async {
    return showModalBottomSheet(
        context: context,
        shape: shape,
        builder: (_) {
          return Container();
        });
  }
}
