import 'package:flutter/material.dart';

import '../../data/locations.dart';
import 'listing_item_widget.dart';

class ListingsWidget extends StatefulWidget {
  const ListingsWidget({Key? key}) : super(key: key);

  @override
  ListingsWidgetState createState() => ListingsWidgetState();
}

class ListingsWidgetState extends State<ListingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final listing in listings)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                child: ListingWidget(
                  listing: listing,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
