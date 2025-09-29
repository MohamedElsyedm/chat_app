import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/rooms/data/models/category_model.dart';
import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  final RoomModel room;
  const RoomItem({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final categoryItemImage = CategoryModel.categories
        .firstWhere((element) => element.id == room.categoryId)
        .imageName;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppTheme.white),
        child: Column(
          children: [
            Image.asset('assets/images/$categoryItemImage.png', height: 85),
            const SizedBox(height: 8),
            Text(room.name, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Text(
              room.description,
              style: textTheme.titleSmall!.copyWith(
                fontSize: 12,
                color: AppTheme.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
