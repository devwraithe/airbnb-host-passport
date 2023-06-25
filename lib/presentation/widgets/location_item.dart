import 'package:airbnb_host_passport/data/location_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LocationItem extends StatefulWidget {
  final Location location;

  const LocationItem({
    super.key,
    required this.location,
  });

  @override
  LocationItemState createState() => LocationItemState();
}

class LocationItemState extends State<LocationItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imgHeight = 330.0;

    final location = widget.location;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: location.image,
                fit: BoxFit.cover,
                height: imgHeight,
                width: double.infinity,
              ),
            ),

            // heart icon
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(
                top: 18,
                right: 18,
              ),
              child: const HeroIcon(
                HeroIcons.heart,
                color: Colors.grey,
                style: HeroIconStyle.solid,
                size: 26,
              ),
            ),

            // host component
            VisibilityDetector(
              key: Key(location.id.toString()),
              onVisibilityChanged: (visibilityInfo) {
                if (visibilityInfo.visibleFraction == 1) {
                  _animationController.forward();
                } else if (visibilityInfo.visibleFraction == 0) {
                  _animationController.reverse();
                }
              },
              child: GestureDetector(
                onTap: () {
                  passportSheet(context, location);
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: imgHeight,
                  child: Stack(
                    children: [
                      // bottom cover
                      Container(
                        height: 100,
                        width: 88,
                        margin: const EdgeInsets.only(
                          bottom: 18,
                          left: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[200],
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                      ),

                      // top cover
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          final value = _animation.value;
                          final angle = value * -0.56;

                          return Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, -0.001)
                              ..rotateY(angle),
                            child: Container(
                              height: 100,
                              width: 88,
                              margin: const EdgeInsets.only(
                                bottom: 18,
                                left: 18,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 26,
                                  foregroundImage: CachedNetworkImageProvider(
                                    location.hostImage,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${location.city}, ${location.country}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                const HeroIcon(
                  HeroIcons.star,
                  color: Colors.black,
                  size: 18,
                  style: HeroIconStyle.solid,
                ),
                const SizedBox(width: 6),
                Text(
                  location.rating,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          "Stay with ${location.hostName} - Business Owner",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${location.timeFrom} till ${location.timeTo}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              location.amount,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              " per night",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // bottom sheet
  passportSheet(context, Location location) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          minChildSize: 0.6,
          initialChildSize: 0.6,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      // the passport
                      Card(
                        elevation: 13,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // host visuals
                              Column(
                                children: [
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            imageUrl: location.hostImage,
                                            width: 110,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0XFFD90A63),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.shield_moon_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    location.hostName,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      HeroIcon(
                                        HeroIcons.checkBadge,
                                        style: HeroIconStyle.solid,
                                        size: 18,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Superhost",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 52),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  passportBrief("Reviews", location.reviews),
                                  passportBriefSeparator(),
                                  passportBrief("Rating", location.rating),
                                  passportBriefSeparator(),
                                  passportBrief(
                                      "Years Hosting", location.yearsHosting),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // host information
                      const SizedBox(height: 36),
                      hostInfoItem(
                        HeroIcons.briefcase,
                        "My work: Business owner",
                      ),
                      hostInfoItem(
                        HeroIcons.musicalNote,
                        "Favorite song in high school: One U2",
                      ),
                      hostInfoItem(
                        HeroIcons.lightBulb,
                        "Fun fact: Unintentional menhir demolator",
                      ),
                      hostInfoItem(
                        HeroIcons.language,
                        "Speaks English, French, German",
                      ),
                      hostInfoItem(
                        HeroIcons.globeAlt,
                        "Lives in Nantes, France",
                      ),
                      hostInfoItem(
                        HeroIcons.heart,
                        "I'm obsessed with: Meet new people",
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // widgets - move to separate file later on
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
}
