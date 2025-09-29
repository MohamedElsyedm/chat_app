import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const DefaultElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 45),
      ),
      child: Row(
        children: [
          Text(label, style: Theme.of(context).textTheme.titleLarge),
          Spacer(),
          Icon(Icons.arrow_forward, color: AppTheme.backgroundLight, size: 35),
        ],
      ),
    );
  }
}
