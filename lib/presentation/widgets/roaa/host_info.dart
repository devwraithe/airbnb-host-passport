import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class HostInfo extends StatelessWidget {
  const HostInfo({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Listing location; // or listing

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        passportBrief("Reviews", location.reviews),
        passportBriefSeparator(),
        passportBrief("Rating", location.rating),
        passportBriefSeparator(),
        passportBrief("Years Hosting", location.yearsHosting),
      ],
    );
  }
}
