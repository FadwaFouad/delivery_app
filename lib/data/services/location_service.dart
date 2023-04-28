import 'package:delivery_app/data/models/restaurant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

import '../../constants.dart' as cons;

class LocationService {
  // get current location of user
  Future<Position> getCurrentLocation() async {
    bool serviceEnable;
    LocationPermission permission;
    // check permission of location
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) return Future.error('Location service are disable');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied,
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Restaurant>> retrieveNearbyRestaurants() async {
    // get places from google maps
    final places = GoogleMapsPlaces(apiKey: cons.googleApiKey);
    // get current location
    Position position = await getCurrentLocation();
    // get result of nearby restaurants from Google Places API
    PlacesSearchResponse _response = await places.searchNearbyWithRadius(
        Location(position.latitude, position.longitude), 10000,
        type: "restaurant");

    // convert result to list of restaurant object
    List<Restaurant> _restaurantList = _response.results
        .map((result) => Restaurant(
              name: result.name,
              image: result.image,
              rate: result.rating ?? 1,
              place: result.place,
            ))
        .toList();

    return _restaurantList;
  }
}
