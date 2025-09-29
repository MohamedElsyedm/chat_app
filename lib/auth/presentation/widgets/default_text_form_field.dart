import 'package:chat_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? prefixIconImageName;
  final String? Function(String?)? validator;
  final bool isPassword;
  final int? maxLines;

  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIconImageName,
    this.validator,
    this.isPassword = false,
    this.maxLines,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: Theme.of(context).textTheme.titleMedium,

        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppTheme.grey),
          prefixIcon: widget.prefixIconImageName == null
              ? null
              : SvgPicture.asset(
                  'assets/icons/${widget.prefixIconImageName}.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppTheme.grey,
                  ),
                )
              : null,
        ),
        validator: widget.validator,
        obscureText: isObscure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}
