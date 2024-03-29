import 'package:delivery_app/data/models/food.dart';
import 'package:delivery_app/data/models/restaurant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

import '../../keys.dart' as keys;

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
    final places = GoogleMapsPlaces(apiKey: keys.googleApiKey);
    // get current location
    Position position = await getCurrentLocation();
    print(" ${position.latitude} , ${position.longitude}");
    // get result of nearby restaurants from Google Places API
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude), 10000,
        // Location(15.6564, 32.5454)
        type: "restaurant");
    print("${response.errorMessage}");
    return response.results;
  }

  List<Restaurant> toListOfRestaurant(List<PlacesSearchResult> placesData) {
    // convert result to list of restaurant object
    List<Restaurant> restaurantList = placesData
        .map((result) => Restaurant(
              name: result.name,
              rate: result.rating?.toInt() ?? 1,
              image: result.photos.isEmpty
                  ? getDefaultRestaurantImage
                  : getImageUrl(result.photos.first.photoReference),
              place: result.formattedAddress ?? result.vicinity ?? 'khartoum',
            ))
        .toList();
    restaurantList.add(Restaurant(
        name: 'Ozone Restaurant',
        image: getDefaultRestaurantImage,
        place: 'Airport Street',
        rate: 4));
    return restaurantList;
  }

  String getImageUrl(String photoReference) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=${keys.googleApiKey}';
  }

  String get getDefaultRestaurantImage =>
      'https://firebasestorage.googleapis.com/v0/b/delivery-app-61495.appspot.com/o/res-image.png?alt=media&token=8e41e997-24dc-438c-b95d-4fe1ca007165';

  List<Food> searchFood(String text, List<Food> list) {
    return list
        .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  List<Food> getCategoryItems(String category, List<Food> list) {
    if (category == "All") return list;
    return list.where((item) => item.type == category.toLowerCase()).toList();
  }
}
