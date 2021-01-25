//
//  Util.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import Foundation
import UIKit

class Util: NSObject {
    
    private override init() {
    }
    
    static let sharedInstance: Util = Util()
    
    // to get particular storyboard name.
    class func getStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

