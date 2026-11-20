import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/utills/ui_tokens.dart';
import 'package:haider/utills/ui_helpers.dart';
import 'package:haider/views/screens/search_results.dart';

import '../../controllers/used/citycontroller.dart';
import '../../controllers/used/search_controller.dart';

/// Search screen where users choose a city and enter a location query.
///
/// Refreshed treatment:
/// - calmer search surface instead of a hard card with a hard elevation
/// - one honest accent for the primary action
/// - Arabic labels and hint text everywhere
/// - the search button now uses the refreshed [SearchButton] treatment
class PropertySearchPage extends StatefulWidget {
  const PropertySearchPage({super.key});

  @override
  State<PropertySearchPage> createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends State<PropertySearchPage> {
  String? city;
  final SearchControllerCustom searchControllerCustom = Get.find();
  final SearchController searchController = SearchController();

  List<PropertyModel> properties = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final cityController = Get.find<CityController>();
    final cityItems = cityController.cityList
        .map((city) => DropdownMenuItem(
              value: city.cityname,
              child: Text(city.cityname ?? ''),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('البحث'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: 'رجوع',
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(Space.sm),
        children: [
          const SizedBox(height: Space.sm),
          _SearchField(
            controller: searchController,
            hintText: 'ابحث باسم المنطقة',
          ),

          const SizedBox(height: Space.md),

          _FilterCard(
            city: city,
            cityItems: cityItems,
            onCityChanged: (value) {
              setState(() {
                city = value;
              });
            },
          ),

          const SizedBox(height: Space.md),

          SizedBox(
            width: double.infinity,
            child: Semantics(
              button: true,
              label: 'بحث عن عقارات',
              child: isSearching
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: Space.sm),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _performSearch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Accent.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Radius.chip),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: Space.sm),
                      ),
                      child: Text(
                        'بحث',
                        style: Type.metadataStyle(
                          size: 16,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performSearch() async {
    if (isSearching) return;

    setState(() {
      isSearching = true;
    });

    try {
      final results =
          await searchControllerCustom.performSearch(
        city: city,
        searchText: searchController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                SearchResultPage(propertyModelList: results),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSearching = false;
        });
      }
    }
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const _SearchField({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: hintText,
      leading: Icon(
        Icons.search,
        color: Accent.primary,
      ),
      trailing: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();
          },
        ),
      ],
      padding: const MaterialStatePropertyAll<EdgeInsetsDirectional>(
        EdgeInsetsDirectional.symmetric(horizontal: Space.sm),
      ),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.card),
        ),
      ),
      backgroundColor: const MaterialStatePropertyAll<Color>(
        Surface.surfaceVariant,
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  final String? city;
  final List<DropdownMenuItem<String>> cityItems;
  final ValueChanged<String?> onCityChanged;

  const _FilterCard({
    required this.city,
    required this.cityItems,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Space.md),
      decoration: BoxDecoration(
        color: Surface.card,
        borderRadius: BorderRadius.circular(Radius.card),
        border: Border.all(color: Accent.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الفلاتر',
            style: Type.sectionTitleStyle(),
          ),
          const SizedBox(height: Space.sm),
          DropdownButtonFormField<String>(
            value: city,
            decoration: InputDecoration(
              hintText: 'اختر المدينة',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Radius.chip),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Space.sm,
                vertical: Space.xs,
              ),
            ),
            items: cityItems,
            onChanged: onCityChanged,
          ),
        ],
      ),
    );
  }
}
