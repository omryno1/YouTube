//
//  FeedCell.swift
//  YouTube
//
//  Created by Omry Dabush on 15/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class FeedCell: BaseCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var videoCollectioView: UICollectionView!
    
    var videos : [Video]?
    private var lastContantOffset: CGFloat = 0.0
    
    override func setupViews() {
        setupCollectionView()
        fetchVideoData()
        
    }
    
    func setupCollectionView(){
        Bundle.main.loadNibNamed("Video", owner: self, options: nil)
        self.addSubview(videoCollectioView)
        videoCollectioView.delegate = self
        videoCollectioView.dataSource = self
        //sets the feed collection view to be the size of the main FeedCell size
        videoCollectioView.frame = self.bounds
    }
    
    func fetchVideoData (){
        ApiService.sharedInstance.fetchHomeVideos { (videos) in
            self.videos = videos
            self.videoCollectioView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * (9/16)
        return CGSize(width:  frame.width, height : height + 100)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "VideoCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCollectionViewCell
        cell.profile.layer.cornerRadius = 22
        cell.profile.layer.masksToBounds = true
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    //Hides & Show the Navigation bar
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        //Checking in scrolling down by 20 pixels to hide the nav bar
//        if (self.lastContantOffset < scrollView.contentOffset.y){
//            if !(self.navigationController?.isNavigationBarHidden)! {
//                navigationController?.setNavigationBarHidden(true, animated: true)
//            }
//            self.lastContantOffset = targetContentOffset.pointee.y
//            //Checking if scrolling up by 50  pixels or more or getting near the to of the scroll view to reveal the nav bar
//        }else if (targetContentOffset.pointee.y >= 0) {
//            if (self.lastContantOffset - targetContentOffset.pointee.y >= 50){
//                if (navigationController?.isNavigationBarHidden)!{
//                    navigationController?.setNavigationBarHidden(false , animated: true)
//                }
//            }
//            self.lastContantOffset = targetContentOffset.pointee.y
//        }else {
//            UIView.animate(withDuration: 0.3, animations: {
//                scrollView.contentOffset.y = -10
//                self.navigationController?.setNavigationBarHidden(false , animated: true)
//            })
//            self.lastContantOffset = 0
//        }
//    }
}
