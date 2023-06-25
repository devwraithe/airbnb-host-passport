import 'package:airbnb_host_passport/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MockSearchBar extends StatelessWidget {
  const MockSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitleStyle = textTheme.bodyMedium?.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 22,
      ),
      child: Row(
        children: [
          const HeroIcon(
            HeroIcons.magnifyingGlass,
            size: 22,
            style: HeroIconStyle.solid,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Where to?",
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  Text("Anywhere", style: subtitleStyle),
                  const SizedBox(width: 4),
                  Text("-", style: subtitleStyle),
                  const SizedBox(width: 4),
                  Text("Any week", style: subtitleStyle),
                  const SizedBox(width: 4),
                  Text("-", style: subtitleStyle),
                  const SizedBox(width: 4),
                  Text("Add guests", style: subtitleStyle),
                ],
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(
            child: HeroIcon(
              HeroIcons.adjustmentsHorizontal,
              size: 22,
              style: HeroIconStyle.solid,
            ),
          ),
        ],
      ),
    );
  }
}
