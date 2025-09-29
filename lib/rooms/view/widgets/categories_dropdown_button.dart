import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class CategoriesDropdownButton extends StatefulWidget {
  final void Function(String? category) onCategorySelected;
  const CategoriesDropdownButton({super.key, required this.onCategorySelected});

  @override
  State<CategoriesDropdownButton> createState() =>
      _CategoriesDropdownButtonState();
}

class _CategoriesDropdownButtonState extends State<CategoriesDropdownButton> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final titleSmallStyle = Theme.of(context).textTheme.titleMedium;

    return DropdownButtonFormField(
      isExpanded: true,
      hint: Text(
        'Select Category',
        style: titleSmallStyle!.copyWith(color: AppTheme.grey),
      ),
      initialValue: selectedItem,
      items: ['sports', 'music', 'movies']
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item, style: titleSmallStyle),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          selectedItem = val;
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
