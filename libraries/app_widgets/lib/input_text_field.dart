import 'package:design_system/export_app_res.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MyInputTextField extends StatefulWidget {
  final String? title;
  final String? helperText;
  final bool isSecure;
  final int maxLength;
  final String? hint;
  final TextInputType? inputType;
  final Color? backColor;
  final TextDirection? textDirection;
  final TextEditingController? textEditingController;
  final String? Function(String? value)? validator;
  final Function(String)? onTextChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;

  static const int _maxLength = 100;

  const MyInputTextField({
    this.title,
    this.hint,
    this.helperText,
    this.inputType,
    this.isSecure = false,
    this.textEditingController,
    this.validator,
    this.maxLength = _maxLength,
    this.onTextChanged,
    this.onTap,
    this.inputFormatters,
    this.backColor,
    this.textDirection,
    super.key,
  });

  @override
  _MyInputTextFieldState createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
  late bool _passwordVisibility;
  late ThemeData theme;

  final FocusNode _focusNode = FocusNode();

  bool? hasError;

  @override
  void initState() {
    super.initState();
    _passwordVisibility = !widget.isSecure;
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(widget.title ?? "", style: theme.textTheme.bodySmall),
          ),
        TextFormField(
          focusNode: _focusNode,
          controller: widget.textEditingController,
          autocorrect: false,
          textDirection: widget.textDirection,
          obscureText: !_passwordVisibility,
          keyboardType: widget.inputType,
          cursorColor: appColors().textBlack,
          textAlignVertical: TextAlignVertical.center,
          validator: widget.validator,
          style: theme.textTheme.bodyMedium,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          minLines: 1,
          maxLines: 1,
          onTap: () => widget.onTap?.call(),
          onChanged: (text) {
            widget.onTextChanged?.call(text);
          },
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodySmall?.copyWith(color: appColors().textHint),
            errorMaxLines: 1,

            helperMaxLines: 1,
            helperText: widget.helperText,
            helperStyle: theme.textTheme.bodySmall?.copyWith(color: appColors().textGrey, height: 0.7),

            suffixIcon: getSuffixIcon(),

            filled: true,
            fillColor: widget.backColor,

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: appColors().primary),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appColors().textInputBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: appColors().textInputBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget? getSuffixIcon() {
    return widget.isSecure ? getPasswordSuffixIcon() : null;
  }

  Widget? getPasswordSuffixIcon() {
    return IconButton(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: _passwordVisibility ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined),
      onPressed: () {
        setState(() {
          _passwordVisibility = !_passwordVisibility;
        });
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
