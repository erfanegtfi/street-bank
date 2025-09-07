import 'package:app_utils/constants.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';

class ItemNotFoundWidget extends StatelessWidget {
  final String? image;
  final String? message;
  const ItemNotFoundWidget({super.key, this.image, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppDimen.verticalSpacing),
          Image.asset(image ?? AppAssets.iconPaper, height: 40, width: 40, package: Constants.designSystem),
          SizedBox(height: AppDimen.spacingNormal),
          Text(message ?? AppText.transactionScreenItemNotFound, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: AppDimen.verticalSpacing),
        ],
      ),
    );
  }
}
