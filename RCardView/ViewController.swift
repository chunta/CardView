//
//  ViewController.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import GoogleMobileAds

class ViewController: UIViewController {

    var cardView:RCardViewController!
    var cardHorizontalView:RCardHorizontalVCtl!
    var cardSliderSample:RCardSliderSampleVCtl!
    
    var adLoader:GADAdLoader!
    @IBOutlet var nativeAdView: GADUnifiedNativeAdView!
    
    // The ad unit ID.
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guide:UILayoutGuide = self.view.safeAreaLayoutGuide


        
        adLoader = GADAdLoader(adUnitID: adUnitID,
                               rootViewController: self,
                               adTypes: [ GADAdLoaderAdType.unifiedNative],
                               options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest())
        nativeAdView.layer.borderWidth = 1
    }
}

extension ViewController : GADUnifiedNativeAdLoaderDelegate {
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        print("123")
        
        nativeAdView.nativeAd = nativeAd
        
        // Set ourselves as the native ad delegate to be notified of native ad events.
        nativeAd.delegate = self
        
        if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
            print(nativeAd.mediaContent.aspectRatio)
        }
        
    }
}


extension ViewController: GADAdLoaderDelegate {
    
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        
    }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        
    }
    
}

extension ViewController: GADUnifiedNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad was shown.
    }
    
    func nativeAdDidRecordClick(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad was clicked on.
    }
    
    func nativeAdWillPresentScreen(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad will present a full screen view.
    }
    
    func nativeAdWillDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad will dismiss a full screen view.
    }
    
    func nativeAdDidDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad did dismiss a full screen view.
    }
    
    func nativeAdWillLeaveApplication(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad will cause the application to become inactive and
        // open a new application.
    }
}

