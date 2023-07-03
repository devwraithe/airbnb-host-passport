import 'package:flutter/material.dart';

import '../../data/locations.dart';
import 'listing_item_widget.dart';

class Listings extends StatefulWidget {
  const Listings({Key? key}) : super(key: key);
  @override
  ListingsState createState() => ListingsState();
}

class ListingsState extends State<Listings> {
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
                child: ListingItemWidget(
                  listing: listing,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
