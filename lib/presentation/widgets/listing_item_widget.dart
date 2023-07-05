import 'package:airbnb_host_passport/core/app_colors.dart';
import 'package:airbnb_host_passport/core/constants.dart';
import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:airbnb_host_passport/presentation/widgets/listing_info_widget.dart';
import 'package:airbnb_host_passport/presentation/widgets/roaa/book_flip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../screens/listing_page.dart';

class ListingWidget extends StatefulWidget {
  final Listing listing;

  const ListingWidget({
    super.key,
    required this.listing,
  });

  @override
  ListingWidgetState createState() => ListingWidgetState();
}

class ListingWidgetState extends State<ListingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Constants.listingHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: Constants.listingRadius,
                  child: CachedNetworkImage(
                    imageUrl: widget.listing.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                top: 20,
                right: 20,
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
              VisibilityDetector(
                onVisibilityChanged: (visibilityInfo) {
                  if (visibilityInfo.visibleFraction == 1) {
                    // _animationController.animateTo(0.33);
                    // animation makes sense but it's moving and animating
                    _animationController.animateTo(
                      0.33,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    );
                  } else if (visibilityInfo.visibleFraction == 0) {
                    _animationController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 0),
                      curve: Curves.elasticIn,
                    );
                  }
                },
                key: Key(widget.listing.id.toString()),
                child: GestureDetector(
                  onTap: () => _animationController.animateTo(0).then((value) {
                    _openListingPage(context);
                  }),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(
                      bottom: 25,
                      left: 25,
                    ),
                    child: Hero(
                      tag: "listing_hero_${widget.listing.id}",
                      flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                      ) {
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        );
                        final scaleAnimation = Tween<double>(
                          begin: Constants.bookInitialScale,
                          end: 1,
                        ).animate(curvedAnimation);

                        return ScaleTransition(
                          scale: scaleAnimation,
                          alignment: Alignment.bottomLeft,
                          filterQuality: FilterQuality.high,
                          child: PassportFlip(
                            listing: widget.listing,
                            animationController: curvedAnimation,
                          ),
                        );
                      },
                      child: Transform.scale(
                        scale: Constants.bookInitialScale,
                        alignment: Alignment.bottomLeft,
                        filterQuality: FilterQuality.high,
                        child: PassportFlip(
                          listing: widget.listing,
                          animationController: _curvedAnimation,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListingInfoWidget(
          listing: widget.listing,
        ),
      ],
    );
  }

  // open listing page
  void _openListingPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        reverseTransitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (BuildContext context, Animation<double> animation, _) {
          return ListingPage(widget.listing);
        },
        transitionsBuilder: (context, animation, _, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          );
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
