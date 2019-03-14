//
//  AppearanceHelper.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import UIKit

enum AppearanceHelper {
    
    static var lightPink = UIColor(red: 222.0/255.0, green: 124.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  
    
    static func setupAppearance(){
       
        UINavigationBar.appearance().barTintColor = lightPink
        UIBarButtonItem.appearance().tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
    }

}
