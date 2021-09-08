import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:iteservice/config/currenciesJson.dart';
import 'package:iteservice/services/currencyApi.dart';
import 'package:iteservice/utilities/utls.dart';

class CurrencyController extends GetxController {
  var from = "NPR".obs;
  var to = "NPR".obs;

  var currSymbol = "\Rs".obs;

  var rate = 1.0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  void changeCurrency(String val) async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Utils.showSnackBar("Check Your Internet Connection!", "Try again later");
    } else {
      if(val == "NPR"){
        from.value = "NPR";
        to.value = "NPR";
        rate.value = 1.0;
        currSymbol.value = "\Rs";
        update();
      }else{
        rate.value = await CurrencyApi.getRate(from.value, val);
      if (rate.value == 0.0) {
        rate.value = 1.0;
        Utils.showSnackBar("Error!", "Something went wrong. Try again later.");
        update();
      } else {
        to.value = val;
        currSymbol.value =
            CurrenciesJson.currencies['${to.value}']!['currencySymbol']!;
        update();
      }
      }
      
    }
  }
}
