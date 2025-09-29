import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String iconName;
  final void Function()? onTap;
  final bool tappedValue;

  const CustomCircleAvatar({
    required this.iconName,
    required this.tappedValue,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppTheme.primary,
        radius: tappedValue == true ? 18 : 15,
        child: CircleAvatar(radius: 15, backgroundImage: AssetImage(iconName)),
      ),
    );
  }
}
