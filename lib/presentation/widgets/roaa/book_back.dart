import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:flutter/material.dart';

import 'host_info.dart';

class BookBack extends StatelessWidget {
  const BookBack(
    this.listing, {
    super.key,
  });

  final Location listing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
          ),
        ],
      ),
      child: HostInfo(location: listing),
    );
  }
}
