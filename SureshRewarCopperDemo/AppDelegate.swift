//
//  AppDelegate.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var fav:[Result] = []
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let isUserSignedIn = UserDefaults.standard.value(forKey: Constants.isSignedIn.rawValue) as? Bool{
            if isUserSignedIn{
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBar = storyboard.instantiateViewController(withIdentifier: Constants.HomeTabBar.rawValue) as? HomeTabBar
                 let appDelegate = UIApplication.shared.delegate as! AppDelegate
                  appDelegate.window?.rootViewController = tabBar
            }
        }
        GIDSignIn.sharedInstance()?.clientID = Constants.token.rawValue
        GIDSignIn.sharedInstance()?.delegate = self
        GMSPlacesClient.provideAPIKey(Constants.apiKey.rawValue)
        GMSServices.provideAPIKey(Constants.apiKey.rawValue)
        return true
    }
    
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        guard let handle =  GIDSignIn.sharedInstance()?.handle(url) else {
            return false
        }
      if handle {
        return true
      }
      return false
    }

}


extension AppDelegate:GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { return }
        UserDefaults.standard.setValue(true, forKey:Constants.isSignedIn.rawValue)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let tabBar = storyboard.instantiateViewController(withIdentifier: Constants.HomeTabBar.rawValue) as? HomeTabBar
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.window?.rootViewController = tabBar
    }
}
