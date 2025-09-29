import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppTheme.white),
        child: Column(
          children: [
            Image.asset('assets/images/chat_movie.png', height: 85),
            const SizedBox(height: 12),
            Text("The Movies Zone", style: textTheme.titleSmall),
            const SizedBox(height: 12),
            Text(
              "20 Members",
              style: textTheme.titleSmall!.copyWith(
                fontSize: 12,
                color: AppTheme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
