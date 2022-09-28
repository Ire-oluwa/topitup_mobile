import 'package:flutter/material.dart';

import '../../components/custom_text.dart';

class HelpScreenMenu extends StatelessWidget {
  const HelpScreenMenu({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
        text: label,
        textColor: const Color(0xff605A5A),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_sharp),
      onTap: onPressed,
    );
  }
}
