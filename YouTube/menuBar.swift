//
//  menuBar.swift
//  YouTube
//
//  Created by Omry Dabush on 06/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class menuBar: UIView, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var menuBarCollectionView: UICollectionView!
    
    let images = ["home", "trending", "subscriptions","account"]
    
    var homeController : HomeController?
    var horizontalLineLeftConstraint : NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("menuBar", owner: self, options: nil)
        self.addSubview(menuBarCollectionView)
        menuBarCollectionView.delegate = self
        menuBarCollectionView.dataSource = self
        menuBarCollectionView.backgroundColor =  UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuBarCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        setupHorizontalLine()
    }

    
    func setupHorizontalLine(){
        let horizontalLine = UIView()
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.addSubview(horizontalLine)
        
        horizontalLineLeftConstraint = horizontalLine.leftAnchor.constraint(equalTo: self.menuBarCollectionView.leftAnchor)
        horizontalLineLeftConstraint?.isActive = true
        
        horizontalLine.bottomAnchor.constraint(equalTo: self.menuBarCollectionView.bottomAnchor).isActive = true
        horizontalLine.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalLine.widthAnchor.constraint(equalTo: self.menuBarCollectionView.widthAnchor, multiplier: 1/4).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homeController?.scrollToMenuAtIndexPath(menuIndex: indexPath.item)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "menuBarCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "menuBarcell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuBarcell", for: indexPath)  as! menuBarCell
        cell.menuBarImageView.image = UIImage(named: images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (self.frame.width) / 4 , height: 50)
    }
    
    
}




