import 'package:design_system/export_app_res.dart';
import 'package:app_utils/constants.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String? image;
  final String? message;
  const MyErrorWidget({super.key, this.image, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimen.spacingLarge),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppDimen.verticalSpacing),
            Image.asset(image ?? AppAssets.iconWifi, height: 50, width: 50, package: Constants.designSystem),
            SizedBox(height: AppDimen.spacingNormal),
            Text(message ?? AppText.transactionScreenItemNotFound, style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: AppDimen.verticalSpacing),
          ],
        ),
      ),
    );
  }
}
