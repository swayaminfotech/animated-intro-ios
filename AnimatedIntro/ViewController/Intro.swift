//
//  Intro.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit

class Intro: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to configure intro view
        configureIntroView()
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func configureIntroView() {
        
        let introView = Bundle.main.loadNibNamed("IntroView", owner: nil, options: nil)![0] as! IntroView
        introView.frame = view.bounds
        self.view.addSubview(introView)
    }
    
}
