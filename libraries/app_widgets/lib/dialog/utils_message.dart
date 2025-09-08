import 'package:app_widgets/buttons/text_button_widget.dart';
import 'package:app_widgets/dialog/alert_dialog.dart';
import 'package:design_system/app_dimen.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilsMessage {
  static final UtilsMessage _instance = UtilsMessage._internal();

  factory UtilsMessage() {
    return _instance;
  }

  UtilsMessage._internal();

  void showAlertDialog(BuildContext context, String message, Function() yesOnPressed, {String? yes}) {
    var baseDialog = MyAlertDialog(content: message, yesOnPressed: () => yesOnPressed(), yes: yes ?? AppText.accept);
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  void showError(BuildContext context, String? errorMessage, Function() onButtonPressed) {
    showAlertDialog(context, (errorMessage?.isNotEmpty == true && errorMessage != null) ? errorMessage : AppText.errorUnknown, () {
      onButtonPressed();
    });
  }
}

void showFlushbar({required BuildContext context, required String title, Color? color, Function? action, String? actionTitle}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50, // Adjust for status bar
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing, vertical: AppDimen.spacingSmall),
          decoration: BoxDecoration(
            color: color ?? appColors().greenMessageBack,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: AppDimen.spacingNormal),
              Row(
                children: [
                  Icon(Icons.info, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ],
              ),
              SizedBox(height: AppDimen.spacingNormal),
              if (actionTitle != null) MyTextButton(actionTitle, () => action?.call()),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Automatically remove the flush bar after 4 seconds
  Future.delayed(Duration(seconds: 4)).then((_) => overlayEntry.remove());
}
