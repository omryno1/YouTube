//
//  HomeController.swift
//  YouTube
//
//  Created by Omry Dabush on 05/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    

    @IBOutlet var viewControllerView: UIView!
    
    @IBOutlet weak var menuBarUIView: menuBar!
    
    @IBOutlet weak var navBarSearchButton: UIBarButtonItem!
    
    @IBOutlet weak var navBarMoreButton: UIBarButtonItem!

    @IBOutlet weak var mainCollectionView: UICollectionView!

    
    @IBAction func moreSettingsButton(_ sender: UIBarButtonItem) {
        
        self.settingsLuncher.showSettings()
    }
    
    
    var videos : [Video]?
    let settingsLuncher = SettingsLuncher()
    private var lastContantOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupMenuBar()
        setupMainCollectioView()

    }

    func setupNavBar(){
        //Setting the ViewController Background
        self.viewControllerView.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - (32), height: 50))
        titleLabel.text = " Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
    
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        //Get rid of the navigation bar shadow
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupMenuBar(){
        menuBarUIView.homeController = self
        menuBarUIView.menuBarCollectionView.frame = menuBarUIView.bounds
    }
    
    func setupMainCollectioView(){
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundColor = UIColor.white
        
        mainCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cellId")
        mainCollectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "trendingCell")
        mainCollectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: "subscriptionCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let identifier: String
        if indexPath.item == 1 {
            identifier = "trendingCell"
        }
        else if indexPath.item == 2{
            identifier = "subscriptionCell"
        }else {
            identifier = "cellId"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize (width: view.frame.width, height: view.frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBarUIView.horizontalLineLeftConstraint?.constant = mainCollectionView.contentOffset.x / 4
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width 
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBarUIView.menuBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }

    func scrollToMenuAtIndexPath(menuIndex : Int){
        let index = IndexPath(item: menuIndex, section: 0)
        mainCollectionView.scrollToItem(at: index, at: UICollectionViewScrollPosition(), animated: true)
    }

}

