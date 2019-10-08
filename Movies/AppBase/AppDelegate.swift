//
//  AppDelegate.swift
//  Movies
//
//  Created by alessandro on 07/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainRouter:MoviesRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        updateUI()
        
        mainRouter = MoviesRouter(window: window)
        
        if let mainRouter = mainRouter{
            mainRouter.list()
        }
        
        return true
    }

    private func updateUI(){
        UINavigationBar.appearance().barTintColor = UIColor(named: "main")
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        
    }

}

