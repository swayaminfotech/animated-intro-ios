//
//  Welcome.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit

class Welcome: UIViewController {
    
    // to define label.
    let lblWelcome: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        lbl.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        lbl.textColor = UIColor.white
        lbl.text = "welcome".localized
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to change background color
        self.view.backgroundColor = UIColor(red: 51.0/255.0, green: 173.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        self.view.addSubview(lblWelcome)
        lblWelcome.center = view.center
    }
}

