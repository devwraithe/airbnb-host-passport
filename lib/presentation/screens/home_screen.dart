import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../widgets/listings_widget.dart';
import '../widgets/mock_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  // base url for the icons
  static String baseUrl = "https://a0.muscache.com/pictures";

  final _tabs = [
    thisTab(
      '$baseUrl/50861fca-582c-4bcc-89d3-857fb7ca6528.jpg',
      "Design",
    ),
    thisTab(
      '$baseUrl/7630c83f-96a8-4232-9a10-0398661e2e6f.jpg',
      "Rooms",
    ),
    thisTab(
      '$baseUrl/ee9e2a40-ffac-4db9-9080-b351efc3cfc4.jpg',
      "Tropical",
    ),
    thisTab(
      '$baseUrl/4221e293-4770-4ea8-a4fa-9972158d4004.jpg',
      "Caves",
    ),
    thisTab(
      '$baseUrl/c5a4f6fc-c92c-4ae8-87dd-57f1ff1b89a6.jpg',
      "OMG!",
    ),
    thisTab(
      '$baseUrl/c0fa9598-4e37-40f3-b734-4bd0e2377add.jpg',
      "New",
    ),
    thisTab(
      '$baseUrl/c8e2ed05-c666-47b6-99fc-4cb6edcde6b4.jpg',
      "Luxe",
    ),
    thisTab(
      '$baseUrl/8e507f16-4943-4be9-b707-59bd38d56309.jpg',
      "Islands",
    ),
    thisTab(
      '$baseUrl/677a041d-7264-4c45-bb72-52bff21eb6e8.jpg',
      "Lake",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey,
                  blurRadius: 4,
                ),
              ],
              color: Colors.white,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: MockSearchBar(),
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: _tabs,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      fontFamily: "Circular Std",
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 21),
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const ListingsWidget(),
        ],
      ),
    );
  }

  // tab item - move to sep file later
  static Widget thisTab(String icon, String label) {
    return Tab(
      icon: CachedNetworkImage(
        imageUrl: icon,
        width: 26,
        height: 26,
      ),
      iconMargin: const EdgeInsets.only(bottom: 8),
      text: label,
    );
  }
}
