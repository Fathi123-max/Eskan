import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/utills/ui_tokens.dart';
import 'package:haider/utills/ui_helpers.dart';
import 'package:haider/views/compunants/rentviewcard.dart';

/// Search results screen.
///
/// Refreshed treatment:
/// - themed app bar with a real back affordance
/// - a no-results state that keeps the context and nudges the user to adjust
/// - a result count above the list so users understand the current set
class SearchResultPage extends GetView {
  SearchResultPage({required this.propertyModelList});

  List<PropertyModel> propertyModelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('نتائج البحث'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: 'رجوع',
        ),
        elevation: 0,
      ),
      body: propertyModelList.isEmpty
          ? _buildNoResultsState()
          : _buildResultsList(),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off,
              size: 56,
              color: Accent.hairline,
            ),
            const SizedBox(height: Space.md),
            Text(
              'لا توجد نتائج بحث',
              style: Type.sectionTitleStyle(color: Accent.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.xs),
            Text(
              'جرّب تعديل البحث أو اختيار مدينة أخرى',
              style: Type.metadataStyle(color: Accent.hairline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(Space.sm),
            child: Text(
              '${propertyModelList.length} نتيجة',
              style: Type.metadataStyle(color: Accent.secondary),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: Space.sm,
                ),
                child: RealViewCard(
                  property: propertyModelList[index],
                ),
              );
            },
            childCount: propertyModelList.length,
          ),
        ),
      ],
    );
  }
}
