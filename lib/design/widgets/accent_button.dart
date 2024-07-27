import 'package:flutter/material.dart';
import 'package:products_app/design/colors.dart';

import '../dimensions.dart';

class AccentButton extends StatelessWidget {
  final String title;
  final Function() onClick;

  const AccentButton({
    super.key,
    required this.title,
    required this.onClick
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(width300, height45),
        maximumSize: const Size.fromHeight(height45), 
        backgroundColor: primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius20)),
        padding: const EdgeInsets.only(left: padding16, right: padding16)
      ),
      child: Text(title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600
        )),
    );
  }
}