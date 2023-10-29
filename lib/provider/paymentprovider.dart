import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Paymentprovider extends ChangeNotifier {
  handlePaymentSuccess(BuildContext context, PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("payment ---- success");
    notifyListeners();
  }

  handlePaymentError(BuildContext context, PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment ---- error");
    notifyListeners();
  }

  handleExternalWallet(BuildContext context, ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("payment ---- wallet");
    notifyListeners();
  }
}
