import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/views/compunants/fab.dart';
import 'package:haider/views/compunants/image_components.dart';
import 'package:haider/views/compunants/rentviewcard.dart';
import 'package:haider/utills/themes.dart';

/// Creates light and dark mode previews automatically.
final class MultiBrightnessPreview extends MultiPreview {
  const MultiBrightnessPreview({required this.name});

  final String name;

  @override
  List<Preview> get previews => const [
        Preview(brightness: Brightness.light),
        Preview(brightness: Brightness.dark),
      ];

  @override
  List<Preview> transform() {
    final previews = super.transform();
    return previews.map((preview) {
      final builder = preview.toBuilder()
        ..group = 'Brightness'
        ..name = '$name - ${preview.brightness!.name}';
      return builder.toPreview();
    }).toList();
  }
}

@MultiBrightnessPreview(name: 'Search Button')
Widget searchButtonPreview() => const Scaffold(
      body: Center(
        child: SearchButton(
          text: 'البحث',
          icon: Icons.location_city_sharp,
          onTap: null,
        ),
      ),
    );

@Preview(name: 'Search Button - English', group: 'Search Button')
Widget searchButtonEnglishPreview() => const Scaffold(
      body: Center(
        child: SearchButton(
          text: 'Search',
          icon: Icons.search,
          onTap: null,
        ),
      ),
    );

@MultiBrightnessPreview(name: 'Property Card')
Widget propertyCardPreview() => const Scaffold(
      body: SizedBox(
        width: 350,
        height: 400,
        child: RealViewCard(
          property: PropertyModel(
            address: 'شارع_collect 123، القاهرة',
            city: 'القاهرة',
            area: 'المعادى',
            size: '150',
            bedrooms: '3',
            bathrooms: '2',
            price: '5000',
            propertyFor: 'rent',
            propertyType: 'شقة',
            currentUserId: 'user123',
            images: ['https://example.com/test.jpg'],
          ),
        ),
      ),
    );

@MultiBrightnessPreview(name: 'Property Image View')
Widget propertyImageViewPreview() => const Scaffold(
      body: SizedBox(
        width: 300,
        height: 300,
        child: PropertyImageView(
          imageUrl: 'https://picsum.photos/800/600',
          property: PropertyModel(
            address: 'Test Address',
            city: 'Cairo',
          ),
        ),
      ),
    );

@Preview(name: 'Full Screen Image View', group: 'Image Components')
Widget fullScreenImageViewPreview() => const FullScreenImageView(
      imageUrl: 'https://picsum.photos/800/600',
      property: PropertyModel(
        address: 'Test Address',
        city: 'Cairo',
      ),
    );

@MultiBrightnessPreview(name: 'Light Theme Preview')
Widget lightThemePreview() => Theme(
      data: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home_rounded, size: 64),
              SizedBox(height: 16),
              Text(
                'إسكان',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'أهلا بكم فى اسكان',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );

@MultiBrightnessPreview(name: 'Dark Theme Preview')
Widget darkThemePreview() => Theme(
      data: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home_rounded, size: 64),
              SizedBox(height: 16),
              Text(
                'إسكان',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'أهلا بكم فى اسكان',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );

/// Preview group for form fields used in property creation
@Preview(name: 'Form Field Style', group: 'Form Components')
Widget formFieldStylePreview() => const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اسم العقار',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'أدخل اسم العقار',
                prefixIcon: Icon(Icons.work),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'المنطقة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'المساحه بالمتر',
                prefixIcon: Icon(Icons.photo_size_select_small_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
