import 'package:get/get.dart';
import 'package:iteservice/bindings/bindings.dart';
import 'package:iteservice/bindings/contactBinding.dart';
import 'package:iteservice/views/views.dart';

part 'appRoutes.dart';

class AppPages {
  static const INITIAL = Routes.WRAPPER;

  static final routes = [
    GetPage(
      name: Routes.WRAPPER, 
      page:()=> Wrapper(),
      binding: WrapperBinding(),
    ),
    
    // GetPage(name: Routes.SERVICES, page:()=> ServicesView()),
    GetPage(name: Routes.CART, page:()=> CartView()),
    GetPage(name: Routes.CHECKOUT, page:()=> CheckoutView()),
    GetPage(name: Routes.PRIVACYPOLICY, page:()=> PrivacyPolicy()),
    GetPage(name: Routes.REFUNDPOLICY, page:()=> RefundPolicy()),
    GetPage(name: Routes.TERMSOFSERVICE, page:()=> TermsOfService()),
    GetPage(name: Routes.CONTACTUS, page:()=> ContactView(), binding: ContactBinding()),
  ];
}