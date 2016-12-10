//
//  HomeController.swift
//  YouTube
//
//  Created by Omry Dabush on 05/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var menuBarUIView: menuBar!
    
    @IBOutlet weak var navBarSearchButton: UIBarButtonItem!
    @IBOutlet weak var navBarMoreButton: UIBarButtonItem!

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
//    var videos:[Video] = {
//        var blankSpaceVideo = Video()
//        var taylorChannel = Channel()
//        
//        taylorChannel.channelName = "Taylor Swift Channel"
//        taylorChannel.channelProfileImageName = "taylor_swift_profile"
//        
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.videoTitle = "Taylor Swift - Blank Space"
//        blankSpaceVideo.numOfViews = 123456712
//        blankSpaceVideo.channel = taylorChannel
//        
//        var badBloodVideo = Video()
//        var KanyeChannel = Channel()
//        
//        KanyeChannel.channelName = "Kanye West Channel"
//        KanyeChannel.channelProfileImageName = "kanye_profile"
//        
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.videoTitle = "Taylor Swift - Bad Blood feturing Kandrik Lamar"
//        badBloodVideo.numOfViews = 321421412
//        badBloodVideo.channel = KanyeChannel
//        
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    var videos : [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideoData()
        setupNavBar()
        setupMainCollectioView()
        setupMenuBar()
    }
    
    func fetchVideoData (){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if (error != nil){
                print (error as! NSError)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
//                print(json)
                for dictionary in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.videoTitle = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numOfViews = dictionary["number_of_views"] as? NSNumber
                    video.duration = dictionary["duration"] as? NSNumber
                
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.channelName = channelDictionary["name"] as? String
                    channel.channelProfileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                    self.mainCollectionView.reloadData()
                }
                
            }catch let jsonError {
                print (jsonError)
            }
        }.resume()
        
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
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - (32), height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
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
    
}

