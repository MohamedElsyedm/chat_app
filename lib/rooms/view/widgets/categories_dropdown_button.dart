import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/rooms/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesDropdownButton extends StatefulWidget {
  final void Function(String? category) onCategorySelected;
  const CategoriesDropdownButton({super.key, required this.onCategorySelected});

  @override
  State<CategoriesDropdownButton> createState() =>
      _CategoriesDropdownButtonState();
}

class _CategoriesDropdownButtonState extends State<CategoriesDropdownButton> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final titleSmallStyle = Theme.of(context).textTheme.titleMedium;

    return DropdownButtonFormField(
      isExpanded: true,
      hint: Text(
        'Select Category',
        style: titleSmallStyle!.copyWith(color: AppTheme.grey),
      ),
      initialValue: selectedCategoryId,
      items: CategoryModel.categories
          .map(
            (item) => DropdownMenuItem(
              value: item.id,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/${item.imageName}.png',
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  Text(item.name, style: titleSmallStyle),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          selectedCategoryId = val;
          widget.onCategorySelected(val);
        });
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select category';
        }
        return null;
      },
    );
  }
}
