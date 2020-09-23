import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AppAds {
  String appId() {
    if (Platform.isAndroid) {
      print('it is Android');
      return 'ca-app-pub-4269370288480107~2560917951';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4269370288480107~3710348094';
    } else {
      return 'ca-app-pub-4269370288480107~2560917951';
    }
  }

  static String banerId() {
    if (Platform.isAndroid) {
      print('it is Android');
      return 'ca-app-pub-4269370288480107/2800687530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4269370288480107/6926978263';
    } else {
      return 'ca-app-pub-4269370288480107/2800687530';
    }
  }

  static final targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['plascic', 'recycling', 'green mind'],
    testDevices: <String>[],
  );

  BannerAd myBanner = BannerAd(
    adUnitId: banerId(),
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );
}
