//
//  HomeBackupViewController.swift
//  YouTube
//
//  Created by Omry Dabush on 15/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

//
//  HomeController.swift
//  YouTube
//
//  Created by Omry Dabush on 05/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class HomeBackUpController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
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
        fetchVideoData()
        setupNavBar()
        setupMainCollectioView()
        setupMenuBar()
    }
    
    
    //Fetching The video Cells Data from a Json File
    func fetchVideoData (){
        
        ApiService.sharedInstance.fetchHomeVideos { (videos) in
            self.videos = videos
            self.mainCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCollectionViewCell
        cell.profile.layer.cornerRadius = 22
        cell.profile.layer.masksToBounds = true
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * (9/16)
        return CGSize(width: view.frame.width, height : height + (80))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func setupNavBar(){
        //Setting the ViewController Background
        self.viewControllerView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - (32), height: 50))
        titleLabel.text = " Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        //Get rid of the navigation bar shadow
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupMainCollectioView(){
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundColor = UIColor.white
    }
    
    func setupMenuBar(){
        menuBarUIView.menuBarCollectionView.frame = menuBarUIView.bounds
    }
    
    
    
    
    //Hides & Show the Navigation bar
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //Checking in scrolling down by 20 pixels to hide the nav bar
        if (self.lastContantOffset < scrollView.contentOffset.y){
            if !(navigationController?.isNavigationBarHidden)! {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
            self.lastContantOffset = targetContentOffset.pointee.y
            //Checking if scrolling up by 50  pixels or more or getting near the to of the scroll view to reveal the nav bar
        }else if (targetContentOffset.pointee.y >= 0) {
            if (self.lastContantOffset - targetContentOffset.pointee.y >= 50){
                if (navigationController?.isNavigationBarHidden)!{
                    navigationController?.setNavigationBarHidden(false , animated: true)
                }
            }
            self.lastContantOffset = targetContentOffset.pointee.y
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                scrollView.contentOffset.y = -10
                self.navigationController?.setNavigationBarHidden(false , animated: true)
            })
            self.lastContantOffset = 0
        }
    }
}

