import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../common/services/index.dart';
import 'models/location.dart';

class LocationApi {
  final apiUrl = 'https://api.camping-lavandes.com/api/location';

  Future<List<Location>> getAll() async {
    var res = await get(
      Uri.parse(apiUrl),
      headers: getHeaders(),
    );

    if (res.statusCode != 200) {
      throw json.decode(res.body)['message'].toString();
    }

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['locations'];

    return data
        .map<Location>((location) => Location.fromJson(location))
        .toList();
  }

  Future<Location> getById(int locationId) async {
    var res = await get(
      Uri.parse('$apiUrl/$locationId'),
      headers: getHeaders(),
    );

    if (res.statusCode != 200) {
      throw json.decode(res.body)['message'].toString();
    }

    var jsonResponse = json.decode(res.body);
    var data = jsonResponse['location'];

    return Location.fromJson(data);
  }

  Future<StreamedResponse> create(Map<String, dynamic> location, PlatformFile file) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    );

    request.headers.addAll({
      ...getHeaders(),
      'Content-Type': 'multipart/form-data',
    });

    request.fields['name'] = location['name'];
    request.fields['stripeProductId'] = location['stripeProductId'];
    request.fields['description'] = location['description'];
    request.fields['surface'] = location['surface'];
    request.fields['max_persons'] = location['max_persons'];
    request.fields['price_per_night'] = location['price_per_night'];
    request.fields['bedrooms'] = location['bedrooms'];
    request.fields['slot_remaining'] = location['slot_remaining'];
    request.fields['parking'] = location['parking'];
    request.fields['kitchen'] = location['kitchen'];
    request.fields['wifi'] = location['wifi'];
    request.fields['sanitary'] = location['sanitary'];
    request.fields['heater'] = location['heater'];
    request.fields['air_conditioner'] = location['air_conditioner'];
    request.fields['terrace'] = location['terrace'];
    request.fields['barbecue'] = location['barbecue'];

    request.files.add(MultipartFile.fromBytes('image', file.bytes!,
        filename: file.name,
        contentType: MediaType.parse(lookupMimeType(file.name)!)));

    var res = await request.send();

    return res;
  }

  Future<StreamedResponse> edit(int id, Map<String, dynamic> location) async {
    var request = MultipartRequest(
      'PATCH',
      Uri.parse('$apiUrl/$id'),
    );

    request.headers.addAll({
      ...getHeaders(),
      'Content-Type': 'multipart/form-data',
    });

    request.fields['name'] = location['name'];
    request.fields['stripeProductId'] = location['stripeProductId'];
    request.fields['description'] = location['description'];
    request.fields['surface'] = location['surface'];
    request.fields['max_persons'] = location['max_persons'];
    request.fields['price_per_night'] = location['price_per_night'];
    request.fields['bedrooms'] = location['bedrooms'];
    request.fields['slot_remaining'] = location['slot_remaining'];
    request.fields['parking'] = location['parking'];
    request.fields['kitchen'] = location['kitchen'];
    request.fields['wifi'] = location['wifi'];
    request.fields['sanitary'] = location['sanitary'];
    request.fields['heater'] = location['heater'];
    request.fields['air_conditioner'] = location['air_conditioner'];
    request.fields['terrace'] = location['terrace'];
    request.fields['barbecue'] = location['barbecue'];

    if (location['image'] != null) {
      request.files.add(MultipartFile.fromBytes('image', location['image'].bytes!,
          filename: location['image'].name,
          contentType: MediaType.parse(lookupMimeType(location['image'].name)!)));
    }

    var res = await request.send();

    return res;
  }

  Future<Response> deleteById(int id) async {
    var res = await delete(
      Uri.parse('$apiUrl/$id'),
      headers: getHeaders(),
    );

    return res;
  }
}
