//
//  IntroView.swift
//  AnimatedIntro
//
//  Created by Swayam Infotech on 01/10/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import Foundation
import UIKit

class IntroView: UIView {
    
    // define outlet for intro collection view
    @IBOutlet weak var collectionIntro: UICollectionView!
    
    // define the buttons outlet
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    // define outlet for bottom buttons view
    @IBOutlet weak var viewButtons: UIView!
    
    // define for intro cell id
    let cellID = "introCell"
    
    // define for total number of page for intro screen
    let totalPage = 6
    
    // define for contetentOffSet x of collection view
    private var lastContentOffset: CGFloat = 0
    
    // define for change colors
    var currPage = 0
    let colors: [UIColor] = [UIColor(red: 51.0/255.0, green: 173.0/255.0, blue: 255.0/255.0, alpha: 1.0),
                             UIColor(red: 0.0/255.0, green: 204.0/255.0, blue: 153.0/255.0, alpha: 1.0),
                             UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0),
                             UIColor(red: 204.0/255.0, green: 0.0/255.0, blue: 102.0/255.0, alpha: 1.0),
                             UIColor(red: 204.0/255.0, green: 102.0/255.0, blue: 255.0/255.0, alpha: 1.0),
                             UIColor(red: 102.0/255.0, green: 0.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    ]
    
    // define custom pagecontrol
    var pageControll = PageControl()
    
    var arrTitles = ["welcome_title".localized,"choose_restaurant".localized,"fresh_food".localized,"fast_order".localized,"fase_delivery".localized,"easy_payment".localized]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // to set view background color
        self.backgroundColor = colors[0]
        
        // to initialize collection view
        setIntroColletion()
        
        // to initialize page control
        setPageControl()
        
        // to set localizable string
        setLocalizableString()
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        pageControll.frame = CGRect(x: 0, y: viewButtons.frame.origin.y - 60.0, width: screenWidth, height: 60.0)
        pageControll.setView()
    }
    
    func setLocalizableString() {
        btnNext.setTitle("next".localized, for: .normal)
        btnSkip.setTitle("skip".localized, for: .normal)
    }
    
    @IBAction func userHandlerActions(_ sender: UIButton) {
        if sender == btnNext {
            let page = pageControll.selectedPage + 1
            if page < totalPage {
                self.collectionIntro.setContentOffset(CGPoint(x: screenWidth * CGFloat(page), y: collectionIntro.contentOffset.y), animated: true)
            } else {
                sharedAppDelegate.navigationControl.pushViewController(Welcome(), animated: true)
            }
        } else if sender == btnSkip {
            sharedAppDelegate.navigationControl.pushViewController(Welcome(), animated: true)
        }
    }
    
    func setIntroColletion() {
        
        collectionIntro.delegate = self
        collectionIntro.dataSource = self
        collectionIntro.isPagingEnabled = true
        collectionIntro.showsVerticalScrollIndicator = false
        collectionIntro.showsHorizontalScrollIndicator = false
        
        if let collectionViewLayout = collectionIntro.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.scrollDirection = .horizontal
        }
    }
    
    func setPageControl() {
        pageControll = PageControl(frame: CGRect(x: 0, y: viewButtons.frame.origin.y - 40, width: screenWidth, height: 40.0))
        self.addSubview(pageControll)
    }
    
    // define for calculate alpha for the cell
    func changeSizeScaleToAlphaScale(_ x : CGFloat) -> CGFloat {
        let minScale : CGFloat = 0.86
        let maxScale : CGFloat = 1.0
        
        let minAlpha : CGFloat = 0.5
        let maxAlpha : CGFloat = 1.0
        
        return ((maxAlpha - minAlpha) * (x - minScale)) / (maxScale - minScale) + minAlpha
    }
    
    // calculates intermediate color, percent should in between 0.0 - 1.0
    func colorBetween(col1: UIColor, col2: UIColor, percent: CGFloat) -> UIColor {
        let c1 = CIColor(color: col1)
        let c2 = CIColor(color: col2)
        
        let alpha = (c2.alpha - c1.alpha) * percent + c1.alpha
        let red = (c2.red - c1.red) * percent + c1.red
        let blue = (c2.blue - c1.blue) * percent + c1.blue
        let green = (c2.green - c1.green) * percent + c1.green
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

//MARK:- UICollectionView Delegate
extension IntroView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalPage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionIntro.register(UINib(nibName: "IntroCell", bundle: nil), forCellWithReuseIdentifier: "cellID\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID\(indexPath.row)", for: indexPath) as! IntroCell
        cell.imgIntro.image = UIImage(named: "\(indexPath.row + 1)")
        cell.lblTitle.text = "Title \(indexPath.row + 1)"
        cell.lblDescriptions.text = "Description \(indexPath.row + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK:- UIScrollView Delegate

extension IntroView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        
        let progress = scrollView.contentOffset.x / scrollView.bounds.width
        if currPage != index { currPage = index }
        let nextPage = Int(progress + 1)
        let prog = 1 - (CGFloat(Int(progress + 1)) - progress)
        if currPage >= 0 && currPage < colors.count && nextPage >= 0 && nextPage < colors.count {
            let interColor = colorBetween(col1: colors[currPage], col2: colors[nextPage], percent: prog)
            self.backgroundColor = interColor
        }
        
        // set button title
        if index == totalPage - 1 {
            btnNext.setTitle("done".localized, for: .normal)
        } else {
            btnNext.setTitle("next".localized, for: .normal)
        }
        
        // for chaging selected page
        pageControll.scrollWith(scrollView: scrollView)
        
        guard let collectionView = collectionIntro else {
            return
        }
        for indexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: indexPath) {
                let halfWidth = cell.contentView.frame.size.width / 2.0
                let realCenter = collectionView.convert(cell.center, to: collectionView.superview)
                let diff = abs(halfWidth - realCenter.x)
                let scale = 1.0 - diff / 950
                let scaleTransform = CGAffineTransform.init(scaleX: scale, y: scale)
                cell.transform = scaleTransform
                cell.alpha = changeSizeScaleToAlphaScale(scale)
            }
        }
    }
}
