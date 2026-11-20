import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/used/propertyModel.dart';
import '../utills/ui_tokens.dart';

/// Displays a single rounded image with tap-to-zoom functionality.
/// Used in property detail screens to show property images in a PageView.
///
/// Refreshed treatment:
/// - calmer border/shadow so the photo is the focus
/// - consistent token-driven radius
/// - a clearer broken-image state instead of a bare grey box
/// - tappable image uses a real hit area instead of raw GestureDetector
class PropertyImageView extends StatelessWidget {
  final String imageUrl;
  final PropertyModel property;

  const PropertyImageView({
    super.key,
    required this.imageUrl,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radius.card),
        child: _ImagePage(
          imageUrl: imageUrl,
          property: property,
        ),
      ),
    );
  }
}

class _ImagePage extends StatelessWidget {
  final String imageUrl;
  final PropertyModel property;

  const _ImagePage({
    required this.imageUrl,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(() => FullScreenImageView(
                imageUrl: imageUrl,
                property: property,
              ));
        },
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 420,
          placeholder: (context, url) => Container(
            decoration: const BoxDecoration(
              color: Surface.surfaceVariant,
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: const BoxDecoration(
              color: Surface.surfaceVariant,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image,
                  size: 36,
                  color: Accent.hairline,
                ),
                const SizedBox(height: Space.xs),
                Text(
                  'صورة غير متاحة',
                  style: Type.metadataStyle(color: Accent.hairline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a preview version of this widget for widget previews.
  static Widget preview({String imageUrl = 'https://picsum.photos/800/600'}) {
    return const PropertyImageView(
      imageUrl: imageUrl,
      property: PropertyModel(
        address: 'Test Address',
        city: 'Cairo',
      ),
    );
  }
}

/// Full-screen photo viewer with zoom and pan support.
///
/// Refreshed treatment:
/// - black chrome stays out of the photo where possible
/// - clearer loading and error states
/// - safer back-button semantics
class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  final PropertyModel property;

  const FullScreenImageView({
    super.key,
    required this.imageUrl,
    required this.property,
  });

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
          tooltip: 'إغلاق',
        ),
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(imageUrl),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
        loadingBuilder: (context, event) => Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.broken_image,
                size: 64,
                color: Accent.hairline,
              ),
              const SizedBox(height: Space.md),
              Text(
                'تعذر تحميل الصورة',
                style: Type.sectionTitleStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
