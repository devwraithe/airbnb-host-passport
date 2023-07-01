import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCoverFront extends StatelessWidget {
  const BookCoverFront(
    this.listing, {
    super.key,
  });

  final Location listing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(8, 0),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(3, 0),
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade200,
                  Colors.grey.shade50,
                  Colors.grey.shade200,
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: listing.hostImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
