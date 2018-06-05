//
//  AppDelegate.swift
//  liveTvSwift
//
//  Created by Ali Raza on 26/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FAPanels
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {

    var window: UIWindow?

    var orientationLock = UIInterfaceOrientationMask.portrait
    var myOrientation: UIInterfaceOrientationMask = .portrait
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return myOrientation
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let leftMenuVC: LeftMenuViewController = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuViewController
        
        
        let centerVC: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "eventScreen") as! UINavigationController
        
        leftMenuVC.eventController = centerVC
        
        let rootController = FAPanelController()
        window?.rootViewController = rootController
    
        rootController.leftPanelPosition = .front

        rootController.configs.leftPanelWidth = 280
        rootController.configs.bounceOnRightPanelOpen = false
        
        rootController.configs.panFromEdge = false
        rootController.configs.minEdgeForLeftPanel  = 70
        rootController.configs.minEdgeForRightPanel = 70
        
        window?.rootViewController = rootController.center(centerVC).left(leftMenuVC)


        checkForAddBlocker()
        _ = Timer.scheduledTimer(timeInterval: ADD_BLOCKER_CHECKING_TIME, target: self, selector: #selector(self.checkForAddBlocker), userInfo: nil, repeats: true)
        GADMobileAds.configure(withApplicationID: ADMOB_APP_ID)
        // Override point for customization after application launch.
        AdsManager.sharedInstance.initAds()
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        registerForPushNotifications()

        return true
    }

    func registerForPushNotifications() {
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        
        Messaging.messaging().apnsToken = deviceToken

        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Mark: Helper Methods
    
    @objc func checkForAddBlocker() {
        // Something cool
        
        //testing

        let isAddsBlocking = AddBlockerDetector.isAddBlockerRunning()

        if isAddsBlocking
        {
            self.blockApplication(message: ADD_BLOCKER_RUNNING_MSG)
        }
        
    }
    
    func loadSplashScreenWithConfiguration(json: JSON)
    {
        let myVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
        myVC.configuration = json
        myVC.view.frame = (APP_DELEGATE().window?.frame)!;

        window?.rootViewController?.addChildViewController(myVC)
        window?.rootViewController?.view.addSubview(myVC.view)
        window?.rootViewController?.view.bringSubview(toFront: myVC.view)
        window?.rootViewController?.view.clipsToBounds = false
        myVC.didMove(toParentViewController: window?.rootViewController)
    }

    func blockApplication(message: String)
    {
        DispatchQueue.main.async
        {
            let myVC = AppBlockViewController(nibName: "AppBlockViewController", bundle: nil)
            myVC.message = message
            myVC.view.frame = (APP_DELEGATE().window?.frame)!;
            self.window?.rootViewController?.addChildViewController(myVC)
            self.window?.rootViewController?.view.addSubview(myVC.view)
            self.window?.rootViewController?.view.bringSubview(toFront: myVC.view)
            self.window?.rootViewController?.view.clipsToBounds = false
            myVC.didMove(toParentViewController: self.window?.rootViewController)
        }
        
    }
}

