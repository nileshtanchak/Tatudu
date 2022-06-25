import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  const CustomTextButton({
    Key? key,
    this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 5),
              color: AppColor.primarySwatch.shade200,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: AppColor.primarySwatch.shade700,
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
