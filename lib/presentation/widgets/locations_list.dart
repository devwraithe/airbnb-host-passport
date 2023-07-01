import 'package:flutter/material.dart';

import '../../data/locations.dart';
import 'location_item.dart';

class LocationsList extends StatefulWidget {
  const LocationsList({Key? key}) : super(key: key);
  @override
  LocationsListState createState() => LocationsListState();
}

class LocationsListState extends State<LocationsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final location in locations)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),

                // equivalent to listing_item
                child: LocationItem(
                  location: location,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
