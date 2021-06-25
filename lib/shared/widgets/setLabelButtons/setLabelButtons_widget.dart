import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/divider/divider_vertical_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final String secundaryLabel;
  final VoidCallback primaryOnPressed;
  final VoidCallback secundaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecundaryColor;

  const SetLabelButtons({
    Key? key,
    required this.primaryLabel,
    required this.secundaryLabel,
    required this.primaryOnPressed,
    required this.secundaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecundaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: AppColors.stroke,
            thickness: 1,
            height: 1,
          ),
          Container(
            height: 54,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style: enablePrimaryColor ? TextStyles.buttonPrimary : null,
                  ),
                ),
                DividerVerticalWidget(),
                Expanded(
                  child: LabelButton(
                      label: secundaryLabel,
                      onPressed: secundaryOnPressed,
                      style: enableSecundaryColor
                          ? TextStyles.buttonPrimary
                          : null),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
