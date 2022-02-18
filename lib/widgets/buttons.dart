import 'package:adaptive_app_demos/global/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../global/device_size.dart';

class StyledTextButton extends StatelessWidget {
  const StyledTextButton(
      {Key? key, required this.onPressed, required this.child})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(Insets.small)),
            textStyle: MaterialStateProperty.all(TextStyles.buttonText2)),
        onPressed: onPressed,
        child: child);
  }
}

class SecondaryMenuButton extends StatelessWidget {
  const SecondaryMenuButton({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return StyledTextButton(
      onPressed: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Text(label),
      ),
    );
  }
}

class SelectedPageButton extends StatelessWidget {
  const SelectedPageButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.isSelected,
    required this.iconPath,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String label;
  final bool isSelected;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    bool useTabs = MediaQuery.of(context).size.width < FormFactor.tablet;
    return useTabs
        ? Container(
            color: Colors.white,
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 82,
                    padding: EdgeInsets.all(Insets.large),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.asset(
                        iconPath,
                        color: isSelected ? keyColor : inactiveBackgroundColor,
                      ),
                    ),
                  ),
                  onTap: onPressed,
                )
              ],
            ),
          )
        : Container(
            color: isSelected ? Colors.grey.shade200 : null,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset(
                    //     iconPath,
                    //   ),
                    // ),
                    Expanded(
                      child: TextButton(
                        onPressed: onPressed,
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          padding: EdgeInsets.all(Insets.large),
                          child: Text(label,
                              style: TextStyles.buttonText1, maxLines: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
