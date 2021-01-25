//
//  PageControl.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit

class PageControl: UIView {
    
    // define for total number of page
    private var numberOfPage: Int = 6 {
        didSet {
            setView()
        }
    }
    
    // define for crrent select page
    var selectedPage: Int = 0 {
        didSet {
            setView()
        }
    }
    
    // define for configure page control UI
    let spacing: CGFloat  = 10
    let ballHeight: CGFloat = 10
    let selectedWidth: CGFloat = 25
    let selectedHeight: CGFloat = 5
    
    // define for save last scroll position
    var lastContentOffset: CGPoint = .zero
    
    // define for save all pages in array
    private var arrPage = [CGFloat]()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setView()
    }
    
    func setView() {
                
        for vw in self.subviews {
            vw.removeFromSuperview()
        }
        
        arrPage.removeAll()
        
        let width: CGFloat = spacing * CGFloat(numberOfPage - 1) + ballHeight * CGFloat(numberOfPage - 1) + selectedWidth
        
        let viewMain = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        viewMain.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
        viewMain.tag = 700
        
        var x: CGFloat = 0
        
        for i in 0..<numberOfPage {
            
            arrPage.append(CGFloat(i))
            var vw = UIView()
            if i == selectedPage {
                vw = UIView(frame: CGRect(x: x, y: 0, width: selectedWidth, height: selectedHeight))
                vw.tag = 455
            } else {
                vw = UIView(frame: CGRect(x: x, y: 0, width: ballHeight, height: ballHeight))
                vw.layer.cornerRadius = vw.frame.size.height/2
            }
            vw.clipsToBounds = true
            vw.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)
            viewMain.addSubview(vw)
            vw.center.y = viewMain.center.y
            x += spacing + vw.frame.size.width
        }
        
        viewMain.center.x = self.center.x
        self.addSubview(viewMain)
    }

    // define for change the current page according to scrolling
    func scrollWith( scrollView: UIScrollView) {
        
        // define ratio to move the selected page
        let ratio: CGFloat = (spacing * CGFloat(numberOfPage - 1) + ballHeight * CGFloat(numberOfPage - 1) + selectedWidth) / (screenWidth * CGFloat(numberOfPage + 1))
        
        for vw in self.subviews {
            for selectedView in vw.subviews {
                if selectedView.tag == 455 {
                    if self.lastContentOffset.x > scrollView.contentOffset.x {
                        // left
                        selectedView.frame.origin.x -= abs(scrollView.contentOffset.x - lastContentOffset.x) * ratio
                    } else {
                        // right
                        selectedView.frame.origin.x += abs(scrollView.contentOffset.x - lastContentOffset.x) * ratio
                    }
                }
            }
            self.lastContentOffset.x = scrollView.contentOffset.x

            if arrPage.contains(scrollView.contentOffset.x/scrollView.frame.size.width) {
                self.selectedPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
            }
        }
    }
    
}
