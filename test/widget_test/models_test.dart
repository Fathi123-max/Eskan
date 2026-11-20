import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haider/models/used/propertyModel.dart';

void main() {
  group('PropertyModel', () {
    test('fromMap creates valid model', () {
      final map = {
        'username': 'Test User',
        'usernumber': '+20123456789',
        'date': '2024-01-01',
        'action': 'active',
        'docId': 'test123',
        'currentUserId': 'user123',
        'propertyType': 'Apartment',
        'propertyFor': 'rent',
        'city': 'Cairo',
        'area': 'Maadi',
        'address': '123 Street',
        'size': '150',
        'bedrooms': '3',
        'bathrooms': '2',
        'kitchen': '1',
        'descr': 'Nice apartment',
        'price': '5000',
        'images': ['https://example.com/image.jpg'],
      };

      final property = PropertyModel.fromMap(map);

      expect(property.username, 'Test User');
      expect(property.city, 'Cairo');
      expect(property.price, '5000');
      expect(property.firstImageUrl, 'https://example.com/image.jpg');
    });

    test('firstImageUrl returns null for empty images', () {
      final property = PropertyModel(
        images: [],
        address: 'Test',
      );

      expect(property.firstImageUrl, isNull);
    });

    test('firstImageUrl returns null for null images', () {
      final property = PropertyModel(
        images: null,
        address: 'Test',
      );

      expect(property.firstImageUrl, isNull);
    });

    test('toMap serializes correctly', () {
      final property = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      final map = property.toMap();

      expect(map['username'], 'User');
      expect(map['city'], 'Cairo');
      expect(map['price'], '5000');
    });

    test('copyWith creates modified copy', () {
      final original = PropertyModel(
        username: 'Original',
        city: 'Cairo',
        price: '5000',
      );

      final modified = original.copyWith(price: '6000');

      expect(modified.username, 'Original');
      expect(modified.city, 'Cairo');
      expect(modified.price, '6000');
    });

    test('copyWith preserves original values when not specified', () {
      final original = PropertyModel(
        username: 'Original',
        city: 'Cairo',
        price: '5000',
      );

      final modified = original.copyWith();

      expect(modified.username, 'Original');
      expect(modified.city, 'Cairo');
      expect(modified.price, '5000');
    });

    test('equality works correctly', () {
      final p1 = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      final p2 = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      final p3 = PropertyModel(
        username: 'Different',
        city: 'Cairo',
        price: '5000',
      );

      expect(p1, equals(p2));
      expect(p1, isNot(equals(p3)));
    });

    test('hashCode is consistent with equality', () {
      final p1 = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      final p2 = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      expect(p1.hashCode, equals(p2.hashCode));
    });

    test('PropertyFor enum serialization', () {
      expect(PropertyForExtension.value(PropertyFor.sale), 'sale');
      expect(PropertyForExtension.value(PropertyFor.rent), 'rent');
      expect(PropertyForExtension.fromString('sale'), PropertyFor.sale);
      expect(PropertyForExtension.fromString('rent'), PropertyFor.rent);
      expect(PropertyForExtension.fromString('unknown'), PropertyFor.rent);
    });

    test('JSON serialization round-trip', () {
      final original = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      final json = original.toJson();
      final decoded = PropertyModel.fromJson(json);

      expect(decoded.username, original.username);
      expect(decoded.city, original.city);
      expect(decoded.price, original.price);
    });

    test('list JSON serialization', () {
      final list = [
        PropertyModel(username: 'User1', city: 'Cairo', price: '5000'),
        PropertyModel(username: 'User2', city: 'Alex', price: '6000'),
      ];

      final json = PropertyModel.toListJson(list);
      final decoded = PropertyModel.fromListJson(json);

      expect(decoded.length, 2);
      expect(decoded[0].username, 'User1');
      expect(decoded[1].username, 'User2');
    });

    test('toString includes key properties', () {
      final property = PropertyModel(
        username: 'User',
        city: 'Cairo',
        price: '5000',
      );

      final str = property.toString();

      expect(str, contains('User'));
      expect(str, contains('Cairo'));
      expect(str, contains('5000'));
    });
  });
});
