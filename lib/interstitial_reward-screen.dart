// import 'package:admob_ads_flutter/data_admob/admob_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_manager.dart';
import 'interstitial_screen.dart';

class InterstitialRewardScreen extends StatefulWidget {
  const InterstitialRewardScreen({super.key});

  @override
  State<InterstitialRewardScreen> createState() => _InterstitialRewardScreenState();
}

class _InterstitialRewardScreenState extends State<InterstitialRewardScreen> {

  // 1st step create the instance.
  late RewardedInterstitialAd rewardedInterstitialAd;
  bool isrewardedInterstitialAdLoad = false;

  //2nd step create the function for loading.
  initRewardedInterstitialAds(){
    RewardedInterstitialAd.load(
        adUnitId: AdmobManager.rewarded_Interstitial_id,
        request: AdRequest(),                 //3rd strep to create RewardInterstitial.....
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(

          // 4th step add extra things/objects.
            onAdLoaded: (RewardedInterstitialAd rewardInterAd){
              print("Ads Loaded........");
              // 9th Step.....
              setState(() {
                rewardedInterstitialAd = rewardInterAd;

                isrewardedInterstitialAdLoad= true;
              });

              // 6th step..
              rewardedInterstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error){
                  print("Error is ${error.code}");
                  print("Error is ${error.message}");
                },
                // 7th Step...
                onAdShowedFullScreenContent: (RewardedInterstitialAd ad){

                },

              );
            },
            // 5th step..
            onAdFailedToLoad: (AdError error){
              print("Error is ${error.code}");
              print("Error is ${error.message}");
            }
        ));
  }

  //10th Step...........

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    initRewardedInterstitialAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Center(child: Text("Interstitial Reward")),),
        body:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //8th Step..
                  InkWell
                    (
                      onTap: (){
                        if(isrewardedInterstitialAdLoad){
                          rewardedInterstitialAd.show(onUserEarnedReward: (ad, reward){
                            print("You Won Reward");
                          });
                        }

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>const InterstitialScreen()));
                      },
                      child: const Text("Open Reward Interstitial Ads",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.blue),)
                  ),

                ]
            ),
            )
        );

    }
}