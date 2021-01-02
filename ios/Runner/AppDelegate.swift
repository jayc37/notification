import UIKit
import Flutter
import Firebase
import FirebaseAnalytics
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
    // [START configure_firebase]

            Messaging.messaging().delegate = self
            //Added push notification

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
                 application.registerUserNotificationSettings(settings)
             }

             application.registerForRemoteNotifications()

             Messaging.messaging().isAutoInitEnabled = true
    // [END configure_firebase]
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
  }
}


