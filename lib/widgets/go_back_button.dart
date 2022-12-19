import 'package:flutter/material.dart';

///  Created by mac on 19/12/22.
class GoBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  late Icon icon;

  GoBackButton(this.onPressed, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    final _icon = icon;
    return IconButton(
      onPressed: onPressed,
      icon: _icon == null
          ? const Icon(
              Icons.arrow_back_ios,
            )
          : const Icon(Icons.arrow_back),
    );
  }
}
