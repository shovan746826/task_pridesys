import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchases{
  final InAppPurchase _iap = InAppPurchase.instance;
  // final Set<String> _productIds = {'100_coin'};
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  Future<bool> Function(PurchaseDetails purchaseDetails) purchaseCompleteFunction;


 InAppPurchases({required this.purchaseCompleteFunction}) {
    _subscription = _iap.purchaseStream.listen(_handlePurchaseUpdates);
  }

  void dispose() {
    _subscription.cancel();
  }

  Future<void> initializeInAppPurchases({required Set<String> productIds}) async {// TODO call it when click item
    final bool available = await _iap.isAvailable();
    if (!available) {
      Fluttertoast.showToast(msg: "In-App Purchase not available.");
      return;
    }

    final ProductDetailsResponse response =
    await _iap.queryProductDetails(productIds);
    // 🔍 Print the full response for debugging
    debugPrint("🧾 ProductDetailsResponse: ${response.productDetails.first.id}");
    debugPrint("🛍️ Products loaded: ${response.productDetails.map((p) => p.title).toList()}");
    debugPrint("❌ Not found IDs: ${response.notFoundIDs}");
    debugPrint("⚠️ Error: ${response.error?.message}");

    if (response.error != null || response.notFoundIDs.isNotEmpty) {
      Fluttertoast.showToast(msg: "Failed to load products.");
      debugPrint("⚠️ Error: Failed to load products.");
      return;
    }

    await buyProduct(response.productDetails.first);
  }

  Future buyProduct(ProductDetails product) async{
    debugPrint("⚠️ ProductDetails: ${product.title}");
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam); // or .buyNonConsumable
    if (product.id.contains("sub")) {
      // subscription
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      // consumable item
      await _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    }
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    debugPrint("⚠️ _handlePurchaseUpdates: ${purchases.first.status}");
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        Fluttertoast.showToast(msg: "Purchase successful!");

        purchase.productID;//product ID
        purchase.purchaseID;//purchase ID
        purchase.verificationData.serverVerificationData;//purchase token
        // Call your backend API
        var result = await purchaseCompleteFunction(purchase);

        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }

        if(result){
          dispose();
        }
      } else if (purchases.first.status == PurchaseStatus.canceled) {
        dispose();
      }else if (purchases.first.status == PurchaseStatus.error) {
        Fluttertoast.showToast(
          msg: "Purchase failed: ${purchases.first.error?.message ?? "Unknown error"}",
        );
      }else{
        dispose();
      }
    }
  }


}