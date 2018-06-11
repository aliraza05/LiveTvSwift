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
    
    var isTopBannerShowing : Bool = false
    
    func initAds()
    {
        window = APP_DELEGATE().window
        //admob banner
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = ADMOB_BANNER_ID
        bannerView.delegate = self
        adsData = NSMutableArray()
        
        Chartboost.start(withAppId: CHARTBOOST_ID, appSignature: CHARTBOOST_SIG, delegate: nil)
        
        Chartboost.cacheInterstitial(CBLocationHomeScreen)
        Chartboost.cacheRewardedVideo(CBLocationHomeScreen)
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self as? GADRewardBasedVideoAdDelegate
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),withAdUnitID: ADMOB_VIDEOADD_ID)
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
                    showChartboostInterstitial();
                }
                else if currentObj.provider == "Facebook"
                {
                    //show FB Ads
                }
            }
        }
        }
    }
    func showVideoAd(location:String)
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
                         showAdmobVideoAd()
                    }
                    else if currentObj.provider == "Chartboost"
                    {
                        showChartboostVideo()
                    }
                }
            }
            
        }
    }
    
    //admob interstatial
    func showChartboostInterstitial()
    {
        Chartboost.showInterstitial(CBLocationHomeScreen)
        Chartboost.cacheInterstitial(CBLocationHomeScreen)
    }
    func showChartboostVideo()
    {
        Chartboost.showRewardedVideo(CBLocationMainMenu)
        Chartboost.cacheRewardedVideo(CBLocationHomeScreen)
    }
    //admob interstatial
    func showAdmobInterstitial(_ vc:UIViewController?)
    {
        print("interstitial:ready to present")
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
    
    func updateBannerPosition(orientation : UIDeviceOrientation)
    {
        if isTopBannerShowing
        {
            if orientation.isLandscape
            {
                bannerView.snp.updateConstraints { (make) in
                    
                    make.top.equalToSuperview().offset(0)
                }
            }else if orientation.isPortrait
            {
                bannerView.snp.updateConstraints { (make) in
                    
                    make.top.equalToSuperview().offset(64)
                }
            }
        }
    }
    
    func showBanner(_ vi:UIView!,location:String)
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
                        if location == "location2bottom" || location == "location1"
                        {
                            addBannerViewToViewAtBottom(bannerView, vi)
                        }
                        else
                        {
                            addBannerViewToViewAtTop(bannerView, vi)
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    
    func addBannerViewToViewAtBottom(_ bannerView: GADBannerView, _ vie:UIView) {
        
        isTopBannerShowing = false

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        vie.addSubview(bannerView)

        bannerView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(320)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let request = GADRequest()
        bannerView.delegate = self
        bannerView.rootViewController = window.rootViewController
        bannerView.load(request)
    }
    
    func addBannerViewToViewAtTop(_ bannerView: GADBannerView, _ vie:UIView) {
        
        isTopBannerShowing = true
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        vie.addSubview(bannerView)
        
        bannerView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(320)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        }
        
        let request = GADRequest()
        bannerView.delegate = self
        bannerView.rootViewController = window.rootViewController
        bannerView.load(request)
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

    //Video Ad
    func showAdmobVideoAd()
    {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController:self.window.rootViewController!)
        }
        
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),withAdUnitID: ADMOB_VIDEOADD_ID)
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }

    
}
