import 'package:app_widgets/input_text_field.dart';
import 'package:design_system/app_dimen.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onTextChanged;
  const SearchBarWidget({required this.onTextChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppDimen.horizontalSpacing),
        Flexible(
          child: MyInputTextField(
            hint: "serach",
            onTextChanged: (value) {
              onTextChanged(value);
            },
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_rounded)),
      ],
    );
  }
}
