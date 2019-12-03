import UIKit
import Flutter
import "GoogleMaps/GoogleMaps.h"
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      // Add the following line, with your API key
  [GMSServices provideAPIKey: @"AIzaSyC92eDKBZnkGThA_VpoHtR63reLgPs216Q"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
