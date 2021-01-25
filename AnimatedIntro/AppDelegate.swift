//
//  AppDelegate.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationControl = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //to set initial view controller
        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "Intro")
        navigationControl = UINavigationController(rootViewController: vc)
        navigationControl.isNavigationBarHidden = true
        window?.rootViewController = navigationControl
        window?.makeKeyAndVisible()
        
        return true
    }

}

