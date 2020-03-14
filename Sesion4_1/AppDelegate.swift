//
//  AppDelegate.swift
//  Sesion4_1
//
//  Created by Jose Antonio Trejo Flores on 28/02/20.
//  Copyright © 2020 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appearanceNavigationBar()
        appearanceTextField()
        return true
    }
    
    private func appearanceNavigationBar() {
        
        let backgroundColor = UIColor.purple
        let tintColor = UIColor.white
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [.foregroundColor: tintColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
            
            UINavigationBar.appearance().tintColor = tintColor
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = tintColor
            UINavigationBar.appearance().barTintColor = backgroundColor
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
    private func appearanceTextField() {
         UITextField.appearance().backgroundColor = .white
    }
}

