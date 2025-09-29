import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/core/languages/view/custom_circle_avatar.dart';
import 'package:chat_app/core/languages/view_model/languages_view_model.dart';
import 'package:flutter/material.dart';

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget(this.languagesViewModel, {super.key});

  final LanguagesViewModel languagesViewModel;

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  final String arabicCode = 'ar';

  final String englishCode = 'en';

  late String selectedCode = widget.languagesViewModel.languageCode;

  void changeLanguage(String val) {
    if (val == selectedCode) return;

    selectedCode = val;
    widget.languagesViewModel.changeLanguage(selectedCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primary),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCircleAvatar(
              iconName: 'assets/icons/en_icon.png',
              tappedValue: englishCode == selectedCode,
              onTap: () => changeLanguage(englishCode),
            ),
            SizedBox(width: 20),
            CustomCircleAvatar(
              iconName: 'assets/icons/eg_icon.png',
              tappedValue: arabicCode == selectedCode,
              onTap: () => changeLanguage(arabicCode),
            ),
          ],
        ),
      ),
    );
  }
}
