import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:flutter/material.dart';

class ListingInfoWidget extends StatelessWidget {
  final Listing listing;
  const ListingInfoWidget({
    super.key,
    required this.listing,
  });

  @override
  Widget build(BuildContext context) {
    return const Text("Listing info here");
  }
}
