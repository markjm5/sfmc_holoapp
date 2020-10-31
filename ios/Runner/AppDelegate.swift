import UIKit
import Flutter
import Firebase
import Evergage

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let evergage = Evergage.sharedInstance()
    
    // Recommended to set the authenticated user's ID as soon as known:
    evergage.userId = "theAuthenticatedUserId"

    // Start Evergage with your Evergage Configuration:
    evergage.start { (clientConfigurationBuilder) in
        clientConfigurationBuilder.account = "interactionstudio"
        clientConfigurationBuilder.dataset = "mmukherjee_sandbox"
        clientConfigurationBuilder.usePushNotifications = true
        clientConfigurationBuilder.useDesignMode = true
    }
    
    GeneratedPluginRegistrant.register(with: self)
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override init() { FirebaseApp.configure() }
}
