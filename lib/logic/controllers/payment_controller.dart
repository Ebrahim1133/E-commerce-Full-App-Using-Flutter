import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

class PayMentController extends GetxController {
  var phoneNumber = ''.obs;
  var address = 'Your Address'.obs;
  var paymentItems = <PaymentItem>[].obs;

  //Location

  Future<void> updatePosition() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    address.value = "${place.country},${place.street}";
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

//Google Pay

  void makeGooglePay({required String amount, required String label}) {
    paymentItems.add(
      PaymentItem(
        label: label,
        amount: amount,
        status: PaymentItemStatus.final_price,
      ),
    );

    update();
  }

  void removeGooglePay() {
    paymentItems.clear();
    update();
  }
}
