import 'package:flutter_test/flutter_test.dart';
import 'package:haider/models/used/catogrymodel.dart';

void main() {
  group('Category', () {
    test('fromMap creates valid model', () {
      final map = {
        'catogryname': 'Apartment',
        'catogryimage': 'https://example.com/apartment.jpg',
      };

      final category = Category.fromMap(map);

      expect(category.catogryname, 'Apartment');
      expect(category.catogryimage, 'https://example.com/apartment.jpg');
    });

    test('fromMap handles null fields', () {
      final map = <String, dynamic>{};

      final category = Category.fromMap(map);

      expect(category.catogryname, isNull);
      expect(category.catogryimage, isNull);
    });

    test('toMap serializes correctly', () {
      final category = Category(
        catogryname: 'Villa',
        catogryimage: ' villa.jpg',
      );

      final map = category.toMap();

      expect(map['catogryname'], 'Villa');
      expect(map['catogryimage'], ' villa.jpg');
    });

    test('copyWith creates modified copy', () {
      final original = Category(
        catogryname: 'Apartment',
        catogryimage: 'old.jpg',
      );

      final modified = original.copyWith(catogryimage: 'new.jpg');

      expect(modified.catogryname, 'Apartment');
      expect(modified.catogryimage, 'new.jpg');
    });

    test('copyWith preserves original values', () {
      final original = Category(
        catogryname: 'Apartment',
        catogryimage: 'image.jpg',
      );

      final modified = original.copyWith();

      expect(modified.catogryname, 'Apartment');
      expect(modified.catogryimage, 'image.jpg');
    });

    test('equality works correctly', () {
      final c1 = Category(catogryname: 'Apartment', catogryimage: 'img.jpg');
      final c2 = Category(catogryname: 'Apartment', catogryimage: 'img.jpg');
      final c3 = Category(catogryname: 'Villa', catogryimage: 'img.jpg');

      expect(c1, equals(c2));
      expect(c1, isNot(equals(c3)));
    });

    test('equality considers both fields', () {
      final c1 = Category(catogryname: 'Apartment', catogryimage: 'img1.jpg');
      final c2 = Category(catogryname: 'Apartment', catogryimage: 'img2.jpg');

      expect(c1, isNot(equals(c2)));
    });

    test('hashCode is consistent with equality', () {
      final c1 = Category(catogryname: 'Apartment', catogryimage: 'img.jpg');
      final c2 = Category(catogryname: 'Apartment', catogryimage: 'img.jpg');

      expect(c1.hashCode, equals(c2.hashCode));
    });

    test('JSON serialization round-trip', () {
      final original = Category(
        catogryname: 'Office',
        catogryimage: 'office.jpg',
      );

      final json = original.toJson();
      final decoded = Category.fromJson(json);

      expect(decoded.catogryname, original.catogryname);
      expect(decoded.catogryimage, original.catogryimage);
    });

    test('toString includes category info', () {
      final category = Category(
        catogryname: 'Shop',
        catogryimage: 'shop.jpg',
      );

      final str = category.toString();

      expect(str, contains('Shop'));
      expect(str, contains('shop.jpg'));
    });
  });
});
