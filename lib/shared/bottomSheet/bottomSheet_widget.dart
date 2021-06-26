import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/setLabelButtons/setLabelButtons_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String primaryLabel;
  final String secundaryLabel;
  final VoidCallback primaryOnPressed;
  final VoidCallback secundaryOnPressed;
  final bool rotate;
  const BottomSheetWidget(
      {Key? key,
      required this.primaryLabel,
      required this.secundaryLabel,
      required this.primaryOnPressed,
      required this.secundaryOnPressed,
      required this.title,
      required this.subtitle,
      this.rotate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // top: true,
      // bottom: true,
      // left: true,
      // right: true,
      child: RotatedBox(
        quarterTurns: rotate ? 1 : 0,
        child: Material(
          child: Container(
            height: !rotate ? 200 : null,
            color: AppColors.shape,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  color: rotate
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                )),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text.rich(
                        TextSpan(
                          text: title,
                          style: TextStyles.buttonBoldHeading,
                          children: [
                            TextSpan(
                                text: "\n$subtitle",
                                style: TextStyles.buttonHeading)
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 1,
                      color: AppColors.stroke,
                    ),
                    SetLabelButtons(
                      enablePrimaryColor: true,
                      primaryLabel: primaryLabel,
                      primaryOnPressed: primaryOnPressed,
                      secundaryLabel: secundaryLabel,
                      secundaryOnPressed: secundaryOnPressed,
                    ),
                    SizedBox(
                      height: 2,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
