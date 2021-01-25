//
//  IntroCell.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit

class IntroCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescriptions: UILabel!
    
    @IBOutlet weak var imgIntro: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // to set UI apperiance
        setUIApperiance()
    }
    
    func setUIApperiance() {
        lblTitle.textColor = UIColor.white
        lblDescriptions.textColor = UIColor.white
    }

}

extension UILabel {
    
    func startBlink() {
        UIView.animate(withDuration: 0.8, delay:0.0, options:[.allowUserInteraction, .curveEaseInOut], animations: {
            self.alpha = 1
        },completion: nil)
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 0
    }
}

