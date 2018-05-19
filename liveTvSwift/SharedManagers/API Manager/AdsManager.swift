//
//  AdsManager.swift
//  liveTvSwift
//
//  Created by Ali  Raza on 15/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdsManager:NSObject,GADBannerViewDelegate,GADInterstitialDelegate
{
    static let sharedInstance = AdsManager()
    
    var window: UIWindow!
    var bannerView: GADBannerView!
    var adjustableView: UIView!
    var interstitial: GADInterstitial!
    var adsData: NSMutableArray!
    
    func initAds()
    {
        window = APP_DELEGATE().window
        //admob banner
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = ADMOB_BANNER_ID
        bannerView.delegate = self
        adsData = NSMutableArray()
        
//        interstitial = GADInterstitial(adUnitID: ADMOB_INTERSTITIAL_ID)

        showAdmobInterstitial(window.rootViewController!)
    }
    
    
    //full screen ads
    
    func showInterstatial(_ vc:UIViewController?, location:String)
    {
      for adsObj in adsData
      {
        let currentObj:Ads = adsObj as! Ads
        for loc in currentObj.locations
        {
            if loc == location
            {
                if currentObj.provider == "Admob"
                {
                    showAdmobInterstitial(vc);
                }
                else if currentObj.provider == "Chartboost"
                {
                    //show chartboost
                }
                else if currentObj.provider == "Facebook"
                {
                    //show chartboost
                }
            }
        }
        
        }
    }
    
    //admob interstatial
    func showAdmobInterstitial(_ vc:UIViewController?)
    {
        print("interstitial:ready to present")
//        if self.interstitial.isReady
//        {
//            interstitial.present(fromRootViewController: vc)
//        }
        interstitial = GADInterstitial(adUnitID: ADMOB_INTERSTITIAL_ID)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitial:DidReceiveAd")
        interstitial.present(fromRootViewController: self.window.rootViewController!)
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    //Banner related functions
    func showBanner(_ vi:UIView!)
    {
        addBannerViewToView(bannerView, vi)
        bannerView.load(GADRequest())
        bannerView.delegate = self
        bannerView.rootViewController = window.rootViewController
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView, _ vie:UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        vie.addSubview(bannerView)
        vie.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: vie.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: vie,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError)
    {
//        if adjustableView.subviews.count == 0
//        {
//            adjustableView.constant = 0;
//            adjustableView.layoutIfNeeded();
//        }
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
    
    
}
