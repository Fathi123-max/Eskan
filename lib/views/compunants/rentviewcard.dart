import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/used/propertyModel.dart';

import '../../controllers/used/favourateController.dart';
import '../../utills/ui_tokens.dart';
import '../../utills/ui_helpers.dart';
import '../screens/propertyDetailScreen.dart';

/// Property card widget displaying property image, details, and price.
///
/// Refreshed card treatment:
/// - calmer surface with one honest accent rather than a decorative shadow on
///   every card
/// - clearer reading order for RTL: photo, price, address, city, specs
/// - accessible favorite hit target with a real minimum touch size
/// - null-safe badges and labels that do not collapse into empty strings
class RealViewCard extends GetView {
  final FavoritesController favoritesController = Get.find();

  /// The property to display.
  final PropertyModel property;

  /// Creates a [RealViewCard] for the given property.
  const RealViewCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PropertyDetailScreen(property: property)),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Space.sm),
      decoration: BoxDecoration(
        color: Surface.card,
        borderRadius: BorderRadius.circular(Radius.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radius.card),
        child: Stack(
          children: [
            _buildImage(),
            _buildTypeBadge(),
            _buildAreaBadge(),
            _buildFavoriteChip(),
            _buildInfoOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Keep the photo large enough to judge the home, but not taller than
        // the card needs to be on narrow screens.
        final imageHeight = constraints.maxWidth > 360
            ? constraints.maxWidth * 0.62
            : constraints.maxWidth * 0.7;

        return CachedNetworkImage(
          imageUrl: property.firstImageUrl ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
          height: imageHeight,
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
        );
      },
    );
  }

  Widget _buildInfoOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsetsDirectional.all(Space.sm),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.62),
            ],
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(Radius.card),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPriceRow(),
            const SizedBox(height: Space.xxs),
            Text(
              property.address ?? 'عنوان غير متوفر',
              style: Type.arabicHeadline(
                size: Type.cardTitle,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Space.xxs),
            _buildCityChip(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        Expanded(
          child: _buildSpecsRow(),
        ),
        const SizedBox(width: Space.xs),
        Text(
          formatPrice(property.price),
          style: Type.priceStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecsRow() {
    return Wrap(
      spacing: Space.xxs,
      runSpacing: Space.xxs,
      children: [
        if (property.propertyFor != null && property.propertyFor!.isNotEmpty)
          specChip(
            icon: Icons.home_max,
            label: property.propertyFor!,
          ),
        if (property.bedrooms != null && property.bedrooms!.isNotEmpty)
          specChip(
            icon: Icons.king_bed,
            label: '${property.bedrooms} غرف نوم',
          ),
        if (property.bathrooms != null && property.bathrooms!.isNotEmpty)
          specChip(
            icon: Icons.bathtub,
            label: '${property.bathrooms} حمام',
          ),
        if (property.size != null && property.size!.isNotEmpty)
          specChip(
            icon: Icons.aspect_ratio,
            label: '${property.size} متر',
          ),
      ],
    );
  }

  Widget _buildCityChip() {
    final city = property.city;
    if (city == null || city.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on,
          color: Accent.warm,
          size: 12,
        ),
        const SizedBox(width: Space.xxs),
        Text(
          city,
          style: Type.metadataStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildTypeBadge() {
    final type = property.propertyType;
    if (type == null || type.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: Space.sm,
      start: Space.sm,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.xs,
          vertical: Space.xxs,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.86),
          borderRadius: BorderRadius.circular(Radius.chip),
        ),
        child: Text(
          type,
          style: Type.metadataStyle(
            color: Accent.primary,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAreaBadge() {
    final area = property.area;
    if (area == null || area.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 58,
      start: Space.sm,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.xs,
          vertical: Space.xxs,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.86),
          borderRadius: BorderRadius.circular(Radius.chip),
        ),
        child: Text(
          area,
          style: Type.metadataStyle(
            color: Accent.primary,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteChip() {
    return Positioned(
      top: Space.sm,
      end: Space.sm,
      child: Semantics(
        button: true,
        label: property.currentUserId != null && property.currentUserId!.isNotEmpty
            ? (favoritesController.isFavorite(property.currentUserId!)
                ? 'إزالة من المفضلة'
                : 'أضف للمفضلة')
            : 'المفضلة',
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: Touch.minTarget,
            minHeight: Touch.minTarget,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _toggleFavorite(),
              child: Obx(() {
                final isFav = property.currentUserId != null &&
                    property.currentUserId!.isNotEmpty &&
                    favoritesController.isFavorite(property.currentUserId!);
                return Container(
                  padding: const EdgeInsets.all(Space.xs),
                  decoration: BoxDecoration(
                    color: isFav
                        ? Accent.warm.withOpacity(0.14)
                        : Colors.white.withOpacity(0.86),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_outline,
                    color: isFav ? Accent.warm : Accent.primary,
                    size: 20,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleFavorite() {
    final userId = property.currentUserId;
    if (userId == null || userId.isEmpty) return;

    final isFav = favoritesController.isFavorite(userId);
    if (isFav) {
      favoritesController.removeFromFavorites(property);
    } else {
      favoritesController.addToFavorites(property);
    }
  }
}
