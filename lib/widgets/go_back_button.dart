import 'dart:io';

import 'package:flutter/material.dart';

///  Created by mac on 19/12/22.
class GoBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  Icon icon;

  GoBackButton({super.key, required this.onPressed, icon})
      : icon = Platform.isIOS
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_back);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
