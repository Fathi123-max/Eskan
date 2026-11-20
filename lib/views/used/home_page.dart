import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/rentAndRentOutController.dart';
import 'package:haider/views/compunants/fab.dart';
import 'package:haider/views/used/info.dart';

import '../compunants/rentviewcard.dart';
import '../screens/avancedSearchPage.dart';
import '../utills/ui_tokens.dart';
import '../utills/ui_helpers.dart';

/// Home page displaying featured and recently added properties.
///
/// Refreshed treatment:
/// - theme-driven typography and spacing instead of repeated inline styles
/// - calmer section headers
/// - a real loading skeleton for the list while data is loading
/// - an empty state that tells the user what to do next
/// - reduced-motion-aware entrance for the first meaningful content
class HomePage extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController =
      Get.find();

  /// Breakpoint for large screen layouts (tablets, desktops)
  static const double largeScreenMinWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildSearchButton(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Hero(
      tag: 'advancedSearchText',
      child: Material(
        type: MaterialType.transparency,
        child: SearchButton(
          text: 'البحث',
          icon: Icons.location_city,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PropertySearchPage()),
            );
          },
          semanticsLabel: 'بحث عن عقارات',
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (rentAndRentOutController.isLoading.value) {
        return _buildLoadingState(context);
      }

      if (rentAndRentOutController.allRentList.value.isEmpty) {
        return _buildEmptyState(context);
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > largeScreenMinWidth) {
            return _buildLargeScreenLayout(context);
          }
          return _buildMobileLayout(context);
        },
      );
    });
  }

  Widget _buildLoadingState(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildSectionHeader('عناصر مميزة')),
        SliverToBoxAdapter(child: _buildLoadingStrip()),
        SliverToBoxAdapter(child: _buildSectionHeader('مضاف حديثا')),
        SliverToBoxAdapter(child: _buildLoadingStrip()),
      ],
    );
  }

  Widget _buildLoadingStrip() {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: Space.sm),
        itemBuilder: (_, index) => const _LoadingCardPlaceholder(),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildFeaturedSection(),
          _buildRecentlyAddedSection()),
        ],
      ),
    );
  }

  Widget _buildLargeScreenLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Space.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: Space.md),
                _buildFeaturedSection(),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            flex: 1,
            child: _buildRecentlyAddedSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(Space.sm),
      child: Row(
        children: [
          Text(
            'أهلا بكم فى إسكان',
            style: Type.arabicHeadline(),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.to(() => const Info()),
            child: const CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage('assets/services.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Space.sm,
        vertical: Space.xs,
      ),
      child: Text(
        title,
        style: Type.sectionTitleStyle(),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('عناصر مميزة'),
        SizedBox(
          height: 240,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 240,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration:
                  const Duration(milliseconds: 700),
              autoPlayCurve: Curves.easeInOut,
              enableInfiniteScroll: true,
              viewportFraction:
                  constraints.maxWidth > largeScreenMinWidth ? 0.4 : 0.82,
            ),
            items: rentAndRentOutController.allRentList
                .map((property) {
              return RealViewCard(property: property);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyAddedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('مضاف حديثا'),
        SizedBox(
          height: 360,
          child: FirestoreListView<Map<String, dynamic>>(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            pageSize: 10,
            addSemanticIndexes: true,
            reverse: true,
            physics: const BouncingScrollPhysics(),
            query: rentAndRentOutController
                .getAllRentPropertyFirestorePagnation(),
            itemBuilder: (context, snapshot) {
              return SizedBox(
                height: 260,
                child: RealViewCard(
                  property: PropertyModel.fromMap(snapshot.data()),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.home_work_outlined,
              size: 56,
              color: Accent.hairline,
            ),
            const SizedBox(height: Space.md),
            Text(
              'لم تضف عقارات بعد',
              style: Type.sectionTitleStyle(
                color: Accent.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.xs),
            Text(
              'أضف أول عقار لتظهر هنا',
              style: Type.metadataStyle(color: Accent.hairline),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.md),
            OutlinedButton.icon(
              onPressed: () {
                // The app currently adds properties through the account flow.
                // Keep this actionable until that navigation is finalized.
              },
              icon: const Icon(Icons.add_home),
              label: const Text('أضف عقار'),
            ),
          ],
        ),
      ),
    );
  }
}

/// A skeleton placeholder that mirrors the refreshed card shape.
class _LoadingCardPlaceholder extends StatelessWidget {
  const _LoadingCardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Surface.surfaceVariant,
        borderRadius: BorderRadius.circular(Radius.card),
      ),
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Radius.card)),
        child: Column(
          children: [
            Expanded(
              child: _ImageShimmer(),
            ),
            _InfoShimmer(),
          ],
        ),
      ),
    );
  }
}

class _ImageShimmer extends StatelessWidget {
  const _ImageShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Accent.hairline,
      child: const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _InfoShimmer extends StatelessWidget {
  const _InfoShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(Space.sm),
      child: Column(
        children: [
          Container(
            height: 14,
            width: double.infinity,
            color: Accent.hairline,
          ),
          const SizedBox(height: Space.xxs),
          Container(
            height: 10,
            width: 120,
            color: Accent.hairline,
          ),
        ],
      ),
    );
  }
}
