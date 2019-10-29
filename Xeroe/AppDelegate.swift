//
//  AppDelegate.swift
//  Xeroe
//
//  Created by Денис Марков on 7/29/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

import IQKeyboardManagerSwift
import GooglePlaces
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    let loginVCIdentifier = "LoginViewController"
    let containerVCIdentifier = "ContainerViewController"
    let homeVCIdentifier = "HomeViewController"

    let googleMapsApiKey = "AIzaSyDwwMGHMrgee2y8tRjDJJl0DOOp3N-CZaA"


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        IQKeyboardManager.shared.enable = true

        window = UIWindow()
        
        DropDown.startListeningToKeyboard()
        //if there is no token - opens LoginViewController, if there is - HomeViewController
        
        debugPrint("AppDelegate: didFinishLaunchingWithOptions: token: ", UserProfile.shared.token ?? "no token")
        if UserProfile.shared.token?.isEmpty ?? true {
            let startViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: loginVCIdentifier) as! LoginViewController
            navigationController = UINavigationController(rootViewController: startViewController)

        } else {
            let startViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: containerVCIdentifier) as! ContainerViewController
            startViewController.identifier = homeVCIdentifier
            navigationController = UINavigationController(rootViewController: startViewController)
        }

        // Override point for customization after application launch.

        GMSPlacesClient.provideAPIKey(googleMapsApiKey)
        
        navigationController?.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
          let barColor: UIColor =  basicBlueColor
        let backgroundColor: UIColor =  _ColorLiteralType(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let textColor: UIColor =  _ColorLiteralType(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        // Navigation bar background.
          UINavigationBar.appearance().barTintColor = barColor
          UINavigationBar.appearance().tintColor = UIColor.white
        // Color and font of typed text in the search bar.
          let searchBarTextAttributes = [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont(name: robotoRegular, size: 16)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes as [NSAttributedString.Key : Any]
        // Color of the placeholder text in the search bar prior to text entry
          let placeholderAttributes = [NSAttributedString.Key.foregroundColor: backgroundColor, NSAttributedString.Key.font: UIFont(name: robotoRegular, size: 15)]
        // Color of the default search text.
          let attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes as [NSAttributedString.Key : Any])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attributedPlaceholder
        
        return true
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

}

