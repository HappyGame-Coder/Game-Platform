import UIKit
import Fabric
import Crashlytics
import GameAnalytics
import FBSDKCoreKit

import AVOSCloud




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,JPUSHRegisterDelegate{

    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error====\(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo);
        completionHandler(UIBackgroundFetchResult.newData);
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupGoogleAnalytics()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) |  Int(JPAuthorizationOptions.sound.rawValue) |  Int(JPAuthorizationOptions.badge.rawValue);
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self);
        // 注册极光推送
        //        isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
        JPUSHService.setup(withOption: launchOptions, appKey: "7ef14d5cbc6af7435f548b1c", channel:"AppleStore" , apsForProduction: true)
        // 获取推送消息
        
        AVOSCloud.setApplicationId("BRPJSkjqoN61AgpXxwfHrpmY-gzGzoHsz", clientKey: "Q4TRWjuDTT5UKtgCW8liAcHs")
//        let object = AVObject.init(className: "DataType")
//        object.setObject("DataType", forKey: "DataType")
//        object.save()
        UIApplication.shared.applicationIconBadgeNumber = 0

        window = UIWindow(frame: UIScreen.main.bounds)
        let starViewC = StartViewController(tracker: Tracker(gaiTracker: gai.defaultTracker))
        
        window?.rootViewController = starViewC
        window?.makeKeyAndVisible()
        return true
    }

    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
  
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate
            .sharedInstance()
            .application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    // MARK: Private

    private func setupGoogleAnalytics() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
    }

    private let gai: GAI = {
        guard let gai = GAI.sharedInstance() else { fatalError("Google Analytics not configured correctly") }
        gai.trackUncaughtExceptions = true
        gai.dispatchInterval = 20
        return gai
    }()

}
