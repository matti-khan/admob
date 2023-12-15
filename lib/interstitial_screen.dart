import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_manager.dart';

class InterstitialScreen extends StatefulWidget {
  const InterstitialScreen({super.key});

  @override
  State<InterstitialScreen> createState() => _InterstitialScreenState();
}

class _InterstitialScreenState extends State<InterstitialScreen> {
  late InterstitialAd interstitialAd;
  bool isInterstitialAdLoaded = false;
  double height_interstitial = 50;

  //Create Function
  initBannerAd() {
    InterstitialAd.load(
        adUnitId: AdmobManager.interstitial_id,
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded = true;

          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
            interstitialAd.dispose();
          }, onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
            interstitialAd.dispose();
            print("LoadAdError ${error.code}");
            print("LoadAdError ${error.message}");
          });
        }, onAdFailedToLoad: (LoadAdError error) {
          print("LoadAdError ${error.code}");
          print("LoadAdError ${error.message}");
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBannerAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _bannerAd.dispose(); //when screen is destroy than also ads is destroy
  }

  // Widget GetBanner(){
  //   return isInterstitialAdLoaded ? Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 5),
  //     color: Colors.amberAccent,
  //     width: interstitialAd.size.width.toDouble(),
  //     height: interstitialAd.size.height.toDouble(),
  //
  //   )
  //       : SizedBox(height: heightinterstitialAd,);
  // }

  @override
  Widget build(BuildContext context) {
    //PopScope is used for back the screen
    // return PopScope(
    //     canPop: true,
    //     onPopInvoked: (bool onpopInvoked){
    //       //Today mobile are back to swipe so it can use for swipe
    //       if(isInterstitialAdLoaded){
    //         interstitialAd.show();
    //       }
    //       Navigator.pop(context);
    //     },
    //     child: Scaffold(
    //       appBar: AppBar(
    //         backgroundColor: Colors.amber,
    //         title: const Center(child: Text('Interstitial')),
    //         leading: InkWell(
    //           onTap: (){
    //             if(isInterstitialAdLoaded){
    //               interstitialAd.show();
    //             }
    //             Navigator.pop(context);
    //
    //           },
    //           child: Icon(Icons.arrow_back),
    //         ),
    //       ),
    //       //bottomNavigationBar: GetBanner(),
    //     ),
    //     );

    return WillPopScope(
        onWillPop: () {
          //Today mobile are back to swipe so it can use for swipe
          if (isInterstitialAdLoaded) {
            interstitialAd.show();
          }
          Navigator.pop(context);
          return true as Future<bool>;
        },
        child: Scaffold(
            appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Center(child: Text('Interstitial')),
          leading: InkWell(
            onTap: () {
              if (isInterstitialAdLoaded) {
                interstitialAd.show();
              }
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        )));
  }
}
