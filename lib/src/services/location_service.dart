import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class Location {
  String address;
  double latitude;
  double longitude;

  Location({required this.address, required this.latitude, required this.longitude});
  
  static Location fromGeoJson(Map<String, dynamic> geoJson) {
    final addr = geoJson['properties']['address'];
    final fullAddress = [
      addr['road'],
      addr['suburb'],
      addr['city'],
      addr['state'],
      addr['country']
    ].where((e) => e != null).join(', ');
    return Location(
      address: fullAddress,
      latitude: double.parse(geoJson['geometry']['coordinates'][1].toString()),
      longitude: double.parse(geoJson['geometry']['coordinates'][0].toString()),
    );
  }

  @override
  String toString() {
    return address; // ou qualquer string que queira mostrar
  }
}

class LocationService {
  // We use the OpenStreetMap API for geocoding and reverse geocoding
  Future<dynamic> makeOpenStreetMapRequest({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      // Imperatively convert all query params to strings to avoid type errors
      if (queryParams != null) {
        queryParams =
            queryParams.map((key, value) => MapEntry(key, value.toString()))
                as Map<String, dynamic>;
      }

      // Pass the user's locale to the API to get the results in the correct language
      final language = Intl.getCurrentLocale().split('_').first;

      // Create a request object with the OpenStreetMap API URL and parameters
      final request = http.Request(
          'GET',
          Uri.https('nominatim.openstreetmap.org', path, {
            if (queryParams != null) ...queryParams,
            'format': 'geojson',
            'addressdetails': '1',
            'accept-language': language,
          }))
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'MyApp/1.0 (https://my.app)',
        })
        ..followRedirects = false
        ..persistentConnection = false;
      // print('Requesting: ${request.url}');

      // Send the request and get the StreamedResponse with a timeout
      final streamedResponse =
          await request.send().timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('Request timed out');
      });

      // Convert the StreamedResponse into a complete response
      final http.Response response = await http.Response.fromStream(streamedResponse);

      // Check the response status and handle accordingly
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final ContentType? contentType = response.headers['content-type'] != null
            ? ContentType.parse(response.headers['content-type']!)
            : null;
        // Check if the response is JSON
        if (contentType?.mimeType == 'application/json') {
          // Expect the response to have a JSON body
          final data = jsonDecode(response.body);
          // Check if the JSON body has an error field
          if (data is Map && data.containsKey('error')) {
            throw Exception('Server error: ${data['error']}');
          } else {
            return data;
          }
        }
      } else {
        throw HttpException('Server error: ${response.statusCode}');
      }
      // Catch possible specific exceptions
    } on TimeoutException {
      throw Exception('Request timed out');
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException catch (error) {
      throw Exception('Request error: $error');
    } on FormatException {
      throw Exception('Bad response format');
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Call the OpenStreetMap search endpoint with a free-form query
  // https://nominatim.org/release-docs/latest/api/Search/#free-form-query
  Future<List<Location>> searchLocation(String query) async {
    try {
      final data = await makeOpenStreetMapRequest(
        path: 'search',
        queryParams: {
          'q': query,
          'limit': 10,
        },
      );
      // Convert the JSON data into a list of Location objects
      if (data is Map && data.containsKey('features')) {
        final results = List<Map<String, dynamic>>.from(data['features'] as List)
            .map<Location>((result) => Location.fromGeoJson(result))
            .toList();
        return results;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception('Error searching for location: $error');
    }
  }
}