import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:okejek_flutter/models/auth/food/bussiness_hour_model.dart';
import 'package:okejek_flutter/models/auth/food/food_vendor_model.dart';

class StoreController extends GetxController {
  var storeOpenHour = 0.obs;
  var storeOpenMinutes = 0.obs;
  var storeCloseHour = 0.obs;
  var storeCloseMinutes = 0.obs;
  var store24Hours = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void delete() {
    super.onDelete();
  }

  bool isStoreOpen(FoodVendor foodVendor) {
    late bool isStoreOpen;

    // FOR TESTING PURPOSE ONLY
    // foodVendor.closed = false;
    // foodVendor.isOpen24Hours = false;
    // foodVendor.businessHours[1].isOpen = true;
    // foodVendor.businessHours[1].openHour = 10;
    // foodVendor.businessHours[1].openMinute = 0;
    // foodVendor.businessHours[1].closeHour = 14;
    // foodVendor.businessHours[1].closeMinute = 50;

    if (foodVendor.closed) {
      isStoreOpen = false;
    } else {
      if (foodVendor.isOpen24Hours) {
        isStoreOpen = true;
        store24Hours.value = true;
      } else {
        store24Hours.value = false;

        // bussiness hour is not valid
        if (foodVendor.businessHours.length < 7) {
          return isStoreOpen = false;
        } else {
          DateTime dateTime = DateTime.now();
          // DateTime oclock10 = dateTime.add(Duration(hours: 5));

          String currentHour = DateFormat('kk').format(dateTime);
          String currentMinutes = DateFormat('mm').format(dateTime);

          BusinessHour businessHourToday = foodVendor.businessHours[whatIsToday()];
          if (businessHourToday.isOpen) {
            storeOpenHour.value = foodVendor.businessHours[whatIsToday()].openHour;
            storeOpenMinutes.value = foodVendor.businessHours[whatIsToday()].openMinute;
            storeCloseHour.value = foodVendor.businessHours[whatIsToday()].closeHour;
            storeCloseMinutes.value = foodVendor.businessHours[whatIsToday()].closeMinute;

            print(
                'open hour : ' + businessHourToday.openHour.toString() + ':' + businessHourToday.openMinute.toString());
            print('close hour : ' +
                businessHourToday.closeHour.toString() +
                ':' +
                businessHourToday.closeMinute.toString());

            var openingTotal = businessHourToday.openHour * 60 + businessHourToday.openMinute;

            // handle close hour more than 0:00
            var closingTotal = businessHourToday.closeHour * 60 +
                businessHourToday.closeMinute +
                (businessHourToday.closeHour < businessHourToday.openHour ? 24 * 60 : 0);

            print('openingTotal = ' + openingTotal.toString());
            print('closingTotal = ' + closingTotal.toString());

            var currentTimeTotal = int.parse(currentHour) * 60 +
                int.parse(currentMinutes) +
                (businessHourToday.closeHour < businessHourToday.openHour &&
                        int.parse(currentHour) < businessHourToday.openHour
                    ? 24 * 60
                    : 0);

            print('currenttimetotal : ' + currentTimeTotal.toString());

            if (openingTotal + 1 <= currentTimeTotal && currentTimeTotal <= closingTotal - 1) {
              isStoreOpen = true;
            } else {
              isStoreOpen = false;
            }
          } else {
            isStoreOpen = false;
          }
        }
      }
    }

    return isStoreOpen;
  }

  int whatIsToday() {
    late int dayInt;

    DateTime dateTime = DateTime.now();
    String day = DateFormat('EEEE').format(dateTime);

    switch (day) {
      case 'Sunday':
        dayInt = 0;
        break;
      case 'Monday':
        dayInt = 1;
        break;
      case 'Tuesday':
        dayInt = 2;
        break;
      case 'Wednesday':
        dayInt = 3;
        break;
      case 'Thursday':
        dayInt = 4;
        break;
      case 'Friday':
        dayInt = 5;
        break;
      case 'Saturday':
        dayInt = 6;
        break;
    }

    return dayInt;
  }
}
