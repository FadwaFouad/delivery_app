import 'package:delivery_app/data/models/restaurant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

import '../../constants.dart' as cons;

class NearbyRestaurantService {
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

  Future<List<PlacesSearchResult>> retrieveNearbyRestaurants() async {
    // get places from google maps
    final places = GoogleMapsPlaces(apiKey: cons.googleApiKey);
    // get current location
    Position position = await getCurrentLocation();
    // get result of nearby restaurants from Google Places API
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(position.latitude, position.longitude), 10000,
        // Location(15.6564, 32.5454)
        type: "restaurant");
    return response.results;
  }

  List<Restaurant> toListOfRestaurant(List<PlacesSearchResult> placesData) {
    // convert result to list of restaurant object
    List<Restaurant> restaurantList = placesData
        .map((result) => Restaurant(
              name: result.name ?? '',
              image: result.photos == null
                  ? result.icon
                  : getImageUrl(result.photos.first.photoReference),
              rate: result.rating == null ? 1 : result.rating.toInt(),
              place: result.formattedAddress ?? result.vicinity ?? 'khartoum',
            ))
        .toList();
    return restaurantList;
  }

  String getImageUrl(String photoReference) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${cons.googleApiKey}';
  }
}
