// widgets - move to separate file later on
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

passportBrief(String key, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        key,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

passportBriefSeparator() {
  return const Column(
    children: [
      SizedBox(height: 10),
      // Divider(
      //   thickness: 10.4,
      //   color: Colors.red,
      // ),
      SizedBox(height: 10),
    ],
  );
}

hostInfoItem(HeroIcons icon, String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        HeroIcon(
          icon,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    ),
  );
}
