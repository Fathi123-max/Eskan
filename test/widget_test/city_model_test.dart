import 'package:flutter_test/flutter_test.dart';
import 'package:haider/models/used/cityModel.dart';

void main() {
  group('CityModel', () {
    test('fromMap creates valid model', () {
      final map = {'cityname': 'Cairo'};

      final city = CityModel.fromMap(map);

      expect(city.cityname, 'Cairo');
    });

    test('fromMap handles null cityname', () {
      final map = <String, dynamic>{};

      final city = CityModel.fromMap(map);

      expect(city.cityname, isNull);
    });

    test('toMap serializes correctly', () {
      final city = CityModel(cityname: 'Alexandria');

      final map = city.toMap();

      expect(map['cityname'], 'Alexandria');
    });

    test('copyWith creates modified copy', () {
      final original = CityModel(cityname: 'Cairo');

      final modified = original.copyWith(cityname: 'Giza');

      expect(modified.cityname, 'Giza');
    });

    test('copyWith preserves original values', () {
      final original = CityModel(cityname: 'Cairo');

      final modified = original.copyWith();

      expect(modified.cityname, 'Cairo');
    });

    test('equality works correctly', () {
      final c1 = CityModel(cityname: 'Cairo');
      final c2 = CityModel(cityname: 'Cairo');
      final c3 = CityModel(cityname: 'Alex');

      expect(c1, equals(c2));
      expect(c1, isNot(equals(c3)));
    });

    test('hashCode is consistent with equality', () {
      final c1 = CityModel(cityname: 'Cairo');
      final c2 = CityModel(cityname: 'Cairo');

      expect(c1.hashCode, equals(c2.hashCode));
    });

    test('JSON serialization round-trip', () {
      final original = CityModel(cityname: 'Cairo');

      final json = original.toJson();
      final decoded = CityModel.fromJson(json);

      expect(decoded.cityname, original.cityname);
    });

    test('toString includes city name', () {
      final city = CityModel(cityname: 'Cairo');

      expect(city.toString(), contains('Cairo'));
    });
  });
});
