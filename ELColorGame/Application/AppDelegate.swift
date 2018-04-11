import UIKit
import GameAnalytics
import FBSDKCoreKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupGoogleAnalytics()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

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
